#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(defpackage #:cl-steamworks-generator
  (:nicknames #:org.shirakumo.fraf.steamworks.generator)
  (:use #:cl #:cffi)
  (:local-nicknames (#:steam #:org.shirakumo.fraf.steamworks.cffi))
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

(defun suffix-p (suffix string)
  (and (<= (length suffix) (length string))
       (string-equal string suffix :start1 (- (length string) (length suffix)))))

(defun strip-prefixes (string &rest prefixes)
  (loop for prefix in prefixes
        when (prefix-p prefix string)
        do (return (subseq string (length prefix)))
        finally (return string)))

(defun strip-suffixes (string &rest suffixes)
  (loop for suffix in suffixes
        when (suffix-p suffix string)
        do (return (subseq string 0 (- (length string) (length suffix))))
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

(defun strip-function-name (name)
  (strip-prefixes name "SteamAPI_ISteam" "SteamAPI_" "SteamInternal_" "Steam"))

(defun strip-struct-name (name)
  (strip-suffixes name "Result_t" "Response_t" "_t"))

(defun strip-constant-name (name)
  (strip-prefixes name "k_cch" "k_cwch" "k_c" "k_i"))

(defun parse-typespec (specstring)
  (let ((parts (split #\Space specstring))
        (type ())
        (count 1))
    (loop for part = (pop parts)
          while part
          do (case (char part 0)
               (#\*
                ;;;; Can't do the following as (for some reason) cffi tries to resolve the
                ;;;; wrapped type, resulting in dependence ordering problems.
                ;; (loop repeat (length part)
                ;;       do (setf type `(:pointer ,type)))
                (if (eql type :char)
                    (setf type :string)
                    (setf type :pointer)))
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
                                 (T (setf type `(:struct ,(name (strip-struct-name name))))))))
                        ((string= part "struct")
                         (setf type `(:struct ,(name (strip-struct-name (pop parts))))))
                        ((string= "_Bool" specstring)
                         (setf type :bool))
                        (T
                         (let* ((parts (list* part (loop for part = (car parts)
                                                         until (or (null part) (find (char part 0) "*[(E"))
                                                         collect part do (pop parts))))
                                (name (format NIL "~{~a~^ ~}" parts)))
                           (setf type (or (gethash name *c-type-map*)
                                          (name name)))))))))
    (values type count)))

(defun compile-typedef (def)
  (if (or (find (getf def :typedef) *bad-types* :test #'string=))
      (values NIL (format NIL "Ignored type definition ~s" (getf def :typedef)))
      `(cffi:defctype ,(name (getf def :typedef))
           ,(parse-typespec (getf def :type))
         ,@(when (getf def :desc) (list (getf def :desc))))))

(defun compile-enum (def)
  (let ((name (getf def :enumname)))
    `(cffi:defcenum ,(name name)
       ,@(when (getf def :desc) (list (getf def :desc)))
       ,@(loop for entry in (getf def :values)
               collect (list (kw (translate-name (strip-prefixes (strip-prefixes (getf entry :name) "k_n" "k_e" "k_" "dc_")
                                                                 (subseq name 1)
                                                                 (subseq name 1 (1- (length name))))))
                             (parse-integer (getf entry :value)))))))

(defun compile-const (def)
  (if (or (find (getf def :constname) *bad-consts* :test #'string=))
      (values NIL (format NIL "Ignored const definition ~s" (getf def :constname)))
      (let ((name (name (strip-constant-name (getf def :constname)))))
        `(cl:defconstant ,name
           ,(or (ignore-errors (parse-integer (getf def :constval)))
                `(if (boundp ',name) (symbol-value ',name) ,(getf def :constval)))
           ,@(when (getf def :desc) (list (getf def :desc)))))))

(defun compile-callback (def)
  (if (and (string= (getf def :struct) "callbackname")
           (string= (getf def :constname) "callbackid"))
      (values NIL "Ignored callback definition scanned from preprocessor directive.")
      `(cl:setf (cl:gethash ',(name (strip-struct-name (getf def :struct))) steam::*callback-id-map*)
                (+ ,(name (strip-constant-name (getf def :constname)))
                   ,(parse-integer (getf def :offset))))))

(defun compile-callresult (def)
  (cond ((and (equal "SteamAPICall_t" (getf def :returntype))
              (null (getf def :callresult)))
         (values NIL (format NIL "Missing callresult declaration for method ~a::~a"
                             (getf def :classname) (getf def :methodname))))
        ((getf def :callresult)
         (let ((name (format NIL "SteamAPI_~a_~a" (getf def :classname) (getf def :methodname))))
           `(cl:setf (cl:gethash ',(name (strip-function-name name)) steam::*function-callresult-map*)
                     ',(name (strip-struct-name (getf def :callresult))))))))

(defun compile-struct (def)
  (if (or (find (getf def :struct) *bad-structs* :test #'string=)
          (search "::" (getf def :struct)))
      (values NIL (format NIL "Ignored struct definition ~s" (getf def :struct)))
      (let ((align #-windows 4 #+windows 8))
        #+windows ;; CSteamIDs make the struct 4-byte aligned.
        (when (and (find "class CSteamID" (getf def :fields)
                         :key (lambda (a) (getf a :fieldtype))
                         :test #'search)
                   (not (find (getf def :name) *large-structs* :test #'string=)))
          (setf align 4))
        `(steam::defcstruct* ,(name (strip-struct-name (getf def :struct)))
           ,@(when (getf def :desc) (list (getf def :desc)))
           ,@(loop with offset = 0
                   with cache = (make-hash-table :test 'equalp)
                   for field in (getf def :fields)
                   for name = (strip-hungarian (getf field :fieldname))
                   collect (multiple-value-bind (type count) (parse-typespec (getf field :fieldtype))
                             (when (<= 1 (incf (gethash name cache -1)))
                               (setf name (format NIL "~a~d" name (gethash name cache))))
                             (prog1 (list (name name)
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

(defun compile-method (def cache)
  (let ((name (format NIL "SteamAPI_~a_~a" (getf def :classname) (getf def :methodname))))
    (when (<= 0 (incf (gethash name cache -2)))
      (setf name (format NIL "~a~d" name (gethash name cache))))
    (if (and (%structure-types-p def)
             (not (find-symbol (string '#:libffi) '#:cffi)))
        (values NIL (format NIL "Ignored method definition ~s due to missing libffi." name))
        `(cffi:defcfun (,(name (strip-function-name name)) ,name
                        :library org.shirakumo.fraf.steamworks.cffi::steamworks)
             ,(parse-typespec (getf def :returntype))
           ,@(when (getf def :desc) (list (getf def :desc)))
           (,(name "this") :pointer)
           ,@(loop for arg in (getf def :params)
                   collect (list (name (getf arg :paramname))
                                 (parse-typespec (getf arg :paramtype))))))))

(defun compile-function (def)
  (let ((name (getf def :functionname)))
    `(cffi:defcfun (,(name (strip-function-name name)) ,name
                    :library org.shirakumo.fraf.steamworks.cffi::steamworks)
         ,(parse-typespec (getf def :returntype))
       ,@(when (getf def :desc) (list (getf def :desc)))
       ,@(loop for arg in (getf def :params)
               collect (list (name (getf arg :paramname))
                             (parse-typespec (getf arg :paramtype)))))))

(defun scan-for-callbacks (content)
  (let ((results ()))
    (flet ((add-callback (struct const offset)
             (push (list :struct struct :constname const :offset (or offset "0"))
                   results)))
      (cl-ppcre:do-register-groups (struct base offset) ("struct ([\\w_]+)\\s*\\{(?:.|\\s)*?enum \\{ k_iCallback = ([\\w_]+)(?: \\+ ([0-9]+))? \\};"
                                                         content)
        (add-callback struct base offset))
      (cl-ppcre:do-register-groups (struct base offset) ("STEAM_CALLBACK_BEGIN\\( ([\\w_]+), ([\\w_]+)(?: \\+ ([0-9]+))? \\);"
                                                         content)
        (add-callback struct base offset)))
    results))

(defun scan-for-constants (content)
  (let ((results ()))
    (flet ((add-constant (name value)
             (push (list :constname name :constval value)
                   results)))
      (cl-ppcre:do-register-groups (name value) ("#define ([\\w_]+)\\s+\"([^\"]+?)\"" content)
        (add-constant name value)))
    results))

(defun scan-all-headers (directory)
  (let ((scan (merge-pathnames (make-pathname :type "h" :name pathname-utils:*wild-component*
                                              :directory (list :relative pathname-utils:*wild-inferiors-component*))
                               directory)))
    (loop for path in (directory scan)
          for content = (alexandria:read-file-into-string path :external-format :latin-1)
          append (scan-for-callbacks content) into callbacks
          append (scan-for-constants content) into constants
          finally (return (list :callbacks callbacks
                                :consts constants)))))

(defun read-steam-api-spec (source)
  (yason:parse source :object-key-fn #'kw
                      :object-as :plist))

(defun merge-steam-api-spec (into &rest things)
  (dolist (thing things)
    (loop for (key val) on thing by #'cddr
          do (setf (getf into key) (append val (getf into key)))))
  into)

(defun compile-steam-api-spec (spec)
  (flet ((%compile (compiler definitions)
           (loop for definition in definitions
                 for (res note) = (multiple-value-list (funcall compiler definition))
                 do (cond (res
                           (handler-bind ((style-warning #'muffle-warning))
                             (eval res)))
                          (note
                           (warn note)))
                 when res collect res)))
    (append (%compile #'compile-const (getf spec :consts))
            (%compile #'compile-callback (getf spec :callbacks))
            (%compile #'compile-enum (getf spec :enums))
            (%compile #'compile-typedef (getf spec :typedefs))
            (%compile #'compile-struct (getf spec :structs))
            (%compile #'compile-callresult (getf spec :methods))
            (%compile #'compile-callresult (getf spec :callresults))
            (let ((cache (make-hash-table :test 'equal)))
              (%compile (lambda (f) (compile-method f cache)) (getf spec :methods)))
            (%compile #'compile-function (getf spec :functions)))))

(defun write-form (form &optional (stream *standard-output*))
  (with-standard-io-syntax
    (let ((*package* #.(find-package '#:steam)))
      (fresh-line stream)
      (terpri stream)
      (write form :stream stream
                  :readably NIL
                  :pretty T
                  :case :downcase)
      (fresh-line stream))))

(defun write-low-level-file (forms &key output (if-exists :error))
  (let ((file (or output *standard-low-level-file*)))
    (with-open-file (stream file
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
              do (write-form form stream))
        file))))

(defun generate (source &key output (if-exists :supersede))
  (let* ((meta (pathname-utils:subdirectory source "public" "steam"))
         (json (make-pathname :name "steam_api" :type "json" :defaults meta)))
    (cl-steamworks::maybe-compile-low-level
     (write-low-level-file
      (append
       (compile-steam-api-spec
        (merge-steam-api-spec
         (read-steam-api-spec json)
         (read-steam-api-spec *extras-file*)
         (scan-all-headers meta))))
      :output output
      :if-exists if-exists))))

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
    (cffi:load-foreign-library 'steam::steamworks)
    (generate sdk-directory)
    (format *query-io* "~&Done. You can now use cl-steamworks!~%")))
