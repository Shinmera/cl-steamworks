#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(defpackage #:cl-steamworks-generator
  (:nicknames #:org.shirakumo.fraf.steamworks.generator)
  (:use #:cl #:cffi)
  (:export
   #:*standard-low-level-file*
   #:*extras-file*
   #:generate
   #:setup))
(in-package #:org.shirakumo.fraf.steamworks.generator)

(defvar *this* #.(or *compile-file-pathname* *load-pathname*
                     (error "COMPILE-FILE or LOAD this file.")))

(defvar *standard-low-level-file*
  (make-pathname :name "low-level" :type "lisp" :defaults *this*))

(defvar *extras-file*
  (make-pathname :name "extra" :type "json" :defaults *this*))

(defparameter *c-type-map*
  (let ((map (make-hash-table :test 'equalp)))
    (flet ((to-c-name (name)
             (map 'string (lambda (c) (if (char= #\- c) #\  c))
                  (string-downcase name))))
      (loop for type in '(:int8 :uint8
                          :int16 :uint16
                          :int32 :uint32
                          :int64 :uint64
                          :float :double
                          :bool :boolean
                          :void)
            do (setf (gethash (to-c-name type) map) type))
      (loop for type in '(:char :short :int :long :long-long)
            do (setf (gethash (to-c-name type) map) type)
               (setf (gethash (to-c-name (format NIL "SIGNED-~a" type)) map) type)
               (let ((type (intern (format NIL "UNSIGNED-~a" type) "KEYWORD")))
                 (setf (gethash (to-c-name type) map) type)))
      map)))

(defvar *bad-types* #("ValvePackingSentinel_t"))

(defvar *bad-consts* #("k_cchPersonaNameMax"))

(defvar *bad-structs* #("CSteamID" "CGameID" "CSteamAPIContext" "CCallResult"
                        "CCallback" "CCallbackBase" "ValvePackingSentinel_t"))

(defvar *large-structs* #("LeaderboardEntry_t"))

(defun prefix-p (prefix string)
  (and (<= (length prefix) (length string))
       (string-equal string prefix :end1 (length prefix))))

(defun strip-prefixes (string &rest prefixes)
  (loop for prefix in prefixes
        when (prefix-p prefix string)
        do (return (subseq string (length prefix)))
        finally (return string)))

(defun strip-hungarian (string)
  (let ((i 0))
    (loop while (or (lower-case-p (char string i))
                    (char= (char string i) #\_))
          do (incf i))
    (if (= i (length string))
        string
        (subseq string i))))

(defun kw (name)
  (intern (string-upcase name) "KEYWORD"))

(defun translate-name (string)
  (with-output-to-string (out)
    (loop for prev = (char string 0) then char
          for char across string
          do (case char
               (#\_ (unless (char= #\_ prev)
                      (write-char #\- out)))
               (#\: (unless (char= #\: prev)
                      (write-char #\- out)))
               (T
                (when (and (not (find prev "_:"))
                           (upper-case-p char)
                           (lower-case-p prev))
                  (write-char #\- out))
                (write-char (char-upcase char) out))))))

(defun name (string)
  (intern (translate-name string)
          #.(find-package '#:org.shirakumo.fraf.steamworks.cffi)))

(defun split (split string)
  (let ((parts ())
        (buffer (make-string-output-stream)))
    (flet ((commit ()
             (let ((part (get-output-stream-string buffer)))
               (when (string/= "" part)
                 (push part parts)))))
      (loop for char across string
            do (if (eql split char)
                   (commit)
                   (write-char char buffer))
            finally (commit)))
    (nreverse parts)))

(defun parse-typespec (specstring)
  (let ((parts (split #\Space specstring))
        (type ())
        (count 1))
    (loop for part = (pop parts)
          while part
          do (case (char part 0)
               (#\*
                ;; (loop repeat (length part)
                ;;       do (setf type `(:pointer ,type)))
                (setf type :pointer))
               (#\&
                (setf type :pointer))
               (#\[
                (setf count (parse-integer part :start 1
                                                :end (1- (length part)))))
               (#\(
                (setf type :pointer)
                (loop-finish))
               (#\E
                (setf type (name part)))
               (T (cond ((string= part "const"))
                        ((string= part "enum"))
                        ((string= part "class")
                         (let ((name (pop parts)))
                           (cond ((string= name "CSteamID") (setf type :unsigned-long))
                                 ((string= name "CGameID") (setf type :unsigned-long))
                                 (T (setf type `(:struct ,(name name)))))))
                        ((string= part "struct")
                         (setf type `(:struct ,(name (pop parts)))))
                        ((string= "_Bool" specstring)
                         (setf type :bool))
                        (T
                         (let* ((parts (list* part (loop for part = (car parts)
                                                         until (or (null part) (find (char part 0) "*[(E"))
                                                         collect part do (pop parts))))
                                (name (format NIL "~{~a~^ ~}" parts)))
                           (setf type (or (gethash name *c-type-map*)
                                          (name name)))))))))
    (when (equal type '(:pointer :char)) (setf type :string))
    (values type count)))

(defun compile-typedef (typedef)
  (if (or (find (getf typedef :typedef) *bad-types* :test #'string=))
      (values NIL (format NIL "Ignored type definition ~s" (getf typedef :typedef)))
      `(cffi:defctype ,(name (getf typedef :typedef))
           ,(parse-typespec (getf typedef :type))
         ,@(when (getf typedef :desc) (list (getf typedef :desc))))))

(defun compile-enum (enum)
  `(cffi:defcenum ,(name (getf enum :enumname))
     ,@(when (getf enum :desc) (list (getf enum :desc)))
     ,@(loop for entry in (getf enum :values)
             collect (list (kw (translate-name (strip-prefixes (strip-prefixes (getf entry :name) "k_n" "k_e" "k_" "dc_")
                                                               (subseq (getf enum :enumname) 1))))
                           (parse-integer (getf entry :value))))))

(defun compile-const (const)
  (if (or (find (getf const :constname) *bad-consts* :test #'string=))
      (values NIL (format NIL "Ignored const definition ~s" (getf const :constname)))
      `(cl:defconstant ,(name (strip-prefixes (getf const :constname) "k_cch" "k_cwch" "k_c" "k_i"))
         ,(parse-integer (getf const :constval))
         ,@(when (getf const :desc) (list (getf const :desc))))))

(defun compile-struct (struct)
  (if (or (find (getf struct :struct) *bad-structs* :test #'string=)
          (search "::" (getf struct :struct)))
      (values NIL (format NIL "Ignored struct definition ~s" (getf struct :struct)))
      (let ((align #-windows 4 #+windows 8))
        #+windows ;; CSteamIDs make the struct 4-byte aligned.
        (when (and (find "class CSteamID" (getf struct :fields)
                         :key (lambda (a) (getf a :fieldtype))
                         :test #'search)
                   (not (find (getf struct :name) *large-structs* :test #'string=)))
          (setf align 4))
        `(cffi:defcstruct ,(name (getf struct :struct))
           ,@(when (getf struct :desc) (list (getf struct :desc)))
           ,@(loop with offset = 0
                   for field in (getf struct :fields)
                   collect (multiple-value-bind (type count) (parse-typespec (getf field :fieldtype))
                             (prog1 (list (name (strip-hungarian (getf field :fieldname)))
                                          type
                                          :count count
                                          :offset offset)
                               ;; Increase offset
                               (incf offset (* (cffi:foreign-type-size type) count))
                               ;; Force alignment
                               (setf offset (* align (ceiling offset align))))))))))

(defun %structure-types-p (method)
  (flet ((struct-type-p (type)
           (let ((type (parse-typespec type)))
             (and (listp type) (eql :struct (car type))))))
    (or (struct-type-p (getf method :returntype))
        (loop for param in (getf method :params)
              thereis (struct-type-p (getf param :paramtype))))))

(defun compile-method (method cache)
  (let ((name (format NIL "SteamAPI_~a_~a" (getf method :classname) (getf method :methodname))))
    (when (<= 0 (incf (gethash name cache -2)))
      (setf name (format NIL "~a~d" name (gethash name cache))))
    (if (and (%structure-types-p method)
             (not (find-symbol (string '#:libffi) '#:cffi)))
        (values NIL (format NIL "Ignored method definition ~s due to missing libffi." name))
        `(cffi:defcfun (,(name (strip-prefixes name "SteamAPI_ISteam" "SteamAPI_")) ,name
                        :library org.shirakumo.fraf.steamworks.cffi::steamworks)
             ,(parse-typespec (getf method :returntype))
           ,@(when (getf method :desc) (list (getf method :desc)))
           (,(name "this") :pointer)
           ,@(loop for arg in (getf method :params)
                   collect (list (name (getf arg :paramname))
                                 (parse-typespec (getf arg :paramtype))))))))

(defun compile-function (function)
  (let ((name (getf function :functionname)))
    `(cffi:defcfun (,(name (strip-prefixes name "SteamAPI_ISteam" "SteamAPI_")) ,name
                    :library org.shirakumo.fraf.steamworks.cffi::steamworks)
         ,(parse-typespec (getf function :returntype))
       ,@(when (getf function :desc) (list (getf function :desc)))
       ,@(loop for arg in (getf function :params)
               collect (list (name (getf arg :paramname))
                             (parse-typespec (getf arg :paramtype)))))))

(defun read-steam-api-spec (source)
  (yason:parse source :object-key-fn #'kw
                      :object-as :plist))

(defun merge-steam-api-spec (thing into)
  (loop for (key val) on thing by #'cddr
        do (setf (getf into key) (append val (getf into key))))
  into)

(defun compile-steam-api-spec (spec)
  (flet ((%compile (compiler definitions)
           (loop for definition in definitions
                 for (res note) = (multiple-value-list (funcall compiler definition))
                 do (if res
                        (handler-bind ((style-warning #'muffle-warning))
                          (eval res))
                        (warn note))
                 when res collect res)))
    (append (%compile #'compile-const (getf spec :consts))
            (%compile #'compile-enum (getf spec :enums))
            (%compile #'compile-typedef (getf spec :typedefs))
            (%compile #'compile-struct (getf spec :structs))
            (let ((cache (make-hash-table :test 'equal)))
              (%compile (lambda (f) (compile-method f cache)) (getf spec :methods)))
            (%compile #'compile-function (getf spec :functions)))))

(defun write-form (form &optional (stream *standard-output*))
  (with-standard-io-syntax
    (let ((*package* #.(find-package '#:org.shirakumo.fraf.steamworks.cffi)))
      (fresh-line stream)
      (terpri stream)
      (write form :stream stream
                  :readably NIL
                  :pretty T
                  :case :downcase)
      (fresh-line stream))))

(defun write-low-level-file (forms &key output (if-exists :error))
  (with-open-file (stream (or output *standard-low-level-file*)
                          :direction :output
                          :element-type 'character
                          :if-exists if-exists)
    (when stream
      (format stream "~
#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>

 Note: This file is auto-generated based on the SteamWorks
       steam_api.json file as available in the SteamWorks SDK.
       The generation occurs via the machinery from generator.lisp
       You should not edit this file manually.
|#~%")
      (write-form `(in-package #:org.shirakumo.fraf.steamworks.cffi) stream)
      (loop for form in forms
            do (write-form form stream)))))

(defun generate (source &key output (if-exists :supersede))
  (write-low-level-file
   (append
    (compile-steam-api-spec
     (merge-steam-api-spec
      (read-steam-api-spec *extras-file*)
      (read-steam-api-spec source))))
   :output output
   :if-exists if-exists))

(defun query-directory ()
  (format *query-io* "~&~%Please enter the path to the SteamWorks SDK root directory:~%> ")
  (let ((path (read-line *query-io*)))
    (when (string/= "" path)
      (parse-namestring
       (if (find (char path (1- (length path))) "\\/")
           path
           (format NIL "~a~c" path #+windows #\\ #-windows #\/))))))

(defun copy-directory-contents (source dest)
  (dolist (file (directory (merge-pathnames pathname-utils:*wild-file* source)))
    (cond ((pathname-utils:directory-p file)
           (let ((dest (pathname-utils:subdirectory dest (pathname-utils:directory-name file))))
             (ensure-directories-exist dest)
             (copy-directory-contents file dest)))
          (T
           (let ((dest (merge-pathnames (pathname-utils:to-file file) dest)))
             (alexandria:copy-file file dest))))))

(defun setup (&optional (sdk-directory (query-directory)))
  (when sdk-directory
    (format *query-io* "~&Copying binaries...")
    (copy-directory-contents
     (pathname-utils:subdirectory sdk-directory "redistributable_bin")
     (ensure-directories-exist (pathname-utils:subdirectory *this* "static")))
    (format *query-io* "~&Generating bindings...")
    (generate (make-pathname :name "steam_api"
                             :type "json"
                             :defaults (pathname-utils:subdirectory sdk-directory "public" "steam")))
    (format *query-io* "~&Loading the library...")
    (cl-steamworks-cffi::maybe-load-low-level)
    (format *query-io* "~&Done. You can now use cl-steamworks!~%")))
