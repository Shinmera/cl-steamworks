#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(defpackage #:cl-steamworks-generator
  (:nicknames #:org.shirakumo.fraf.steamworks.generator)
  (:use #:cl #:cffi)
  (:export))
(in-package #:org.shirakumo.fraf.steamworks.generator)

(defvar *standard-low-level-file*
  (make-pathname :name "low-level" :type "lisp"
                 :defaults #.(or *compile-file-pathname* *load-pathname*
                                 (error "COMPILE-FILE or LOAD this file."))))

(defvar *c-type-map*
  (let ((map (make-hash-table :test 'equalp)))
    (flet ((to-c-name (name)
             (map 'string (lambda (c) (if (char= #\- c) #\  c))
                  (string-downcase name))))
      (loop for type in '(:char :unsigned-char
                          :short :unsigned-short
                          :long :unsigned-long
                          :long-long :unsigned-long-long
                          :int8 :uint8
                          :int16 :uint16
                          :int32 :uint32
                          :int64 :uint64
                          :void)
            do (setf (gethash (to-c-name type) map) type))
      map)))

(defun kw (name)
  (intern (string-upcase name) "KEYWORD"))

(defun translate-name (string)
  (with-output-to-string (out)
    (loop for char across string
          do (case char
               (#\_ (write-char #\- out))
               (#\: (write-char #\- out))
               (T (when (upper-case-p char)
                    (write-char char out))
                (write-char (char-upcase char) out))))))

(defun name (string)
  (intern (translate-name string) #.*package*))

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
                (loop repeat (length part)
                      do (setf type `(:pointer ,type))))
               (#\[
                (setf count (parse-integer part :start 1
                                                :end (1- (length part)))))
               (#\(
                (setf type :pointer)
                (loop-finish))
               (#\E
                (setf type `(:enum ,(name part))))
               (T (cond ((string= part "const"))
                        ((string= part "enum")
                         (setf type `(:enum ,(name (pop parts)))))
                        ((string= part "class")
                         (setf type `(:struct ,(name (pop parts)))))
                        ((string= part "struct")
                         (setf type `(:struct ,(name (pop parts)))))
                        (T
                         (let* ((parts (list* part (loop for part = (car parts)
                                                         until (find (char part 0) "*[(E")
                                                         collect part do (pop parts))))
                                (name (format NIL "~{~a ~}" parts)))
                           (or (gethash name *c-type-map*)
                               (name name))))))))
    (values type count)))

;; FIXME: Some structure types that appear referenced as return value types
;;        or argument types are not defined in the json file, but are present
;;        in other headers, sometimes through a type alias.
;; FIXME: The API seems to rely pretty heavily on structure returns...

(defun compile-typedef (typedef)
  `(defctype ,(name (getf typedef :typedef))
       ,(name (parse-typespec (getf typedef :type)))))

(defun compile-enum (enum)
  `(defcenum ,(name (getf enum :enumname))
     ,@(loop for entry in (getf enum :values)
             collect (list (kw (getf entry :name))
                           (parse-integer (getf entry :value))))))

(defun compile-const (const)
  `(defconstant ,(name (getf const :constname))
     ,(parse-integer (getf const :constval))))

(defun compile-struct (struct)
  `(defcstruct ,(name (getf struct :struct))
     ,@(loop for field in (getf struct :fields)
             collect (multiple-value-bind (type count) (parse-typespec (getf field :fieldtype))
                       (list (name (getf field :fieldname))
                             type
                             count)))))

(defun compile-method (method)
  (let ((name (format NIL "SteamAPI_~a_~a" (getf method :classname) (getf method :methodname))))
    `(defcfun (,(name name) ,name) ,(parse-typespec (getf method :returntype))
       ,@(loop for arg in (getf method :params)
               collect (list (name (getf arg :paramname))
                             (parse-typespec (getf arg :paramtype)))))))

(defun read-steam-api-spec (source)
  (yason:parse source :object-key-fn #'kw
                      :object-as :plist))

(defun compile-steam-api-spec (spec)
  (append (mapcar #'compile-const (getf spec :consts))
          (mapcar #'compile-enum (getf spec :enums))
          (mapcar #'compile-typedef (getf spec :typedefs))
          (mapcar #'compile-struct (getf spec :structs))
          (mapcar #'compile-method (getf spec :methods))))

(defun write-form (form &optional (stream *standard-output*))
  (with-standard-io-syntax
    (let ((*package* #.*package*))
      (fresh-line stream)
      (terpri stream)
      (write form :stream stream
                  :readably T
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
   (compile-steam-api-spec
    (read-steam-api-spec source))
   :output output
   :if-exists if-exists))
