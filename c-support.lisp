#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defvar *this* #.(or *compile-file-pathname* *load-pathname*
                       (error "COMPILE-FILE or LOAD this file.")))
  (defvar *static*
    (make-pathname :name NIL :type NIL
                   :defaults (merge-pathnames "static/" *this*))))

(defvar steam::*callback-id-map* (make-hash-table :test 'eq))
(defvar steam::*function-callresult-map* (make-hash-table :test 'eq))

(defun callback-type-id (callback)
  (or (gethash callback steam::*callback-id-map*)
      (error "Not a callback: ~s" callback)))

(define-compiler-macro callback-type-id (&whole whole callback &environment env)
  (if (constantp callback env)
      `(load-time-value (or (gethash ,callback steam::*callback-id-map*)
                            (error "Not a callback: ~s" ,callback)))
      whole))

(defun function-callresult (function)
  (or (gethash function steam::*function-callresult-map*)
      (error "Not a callresult function: ~s" function)))

(define-compiler-macro function-callresult (&whole whole function &environment env)
  (if (constantp function env)
      `(load-time-value (or (gethash ,function steam::*function-callresult-map*)
                            (error "Not a callresult function: ~s" ,function)))
      whole))

(defun c-slot-value-extractor (struct slotdef)
  (destructuring-bind (name type &key count offset) slotdef
    (declare (ignore offset))
    (cond ((= 1 count)
           `(cffi:foreign-slot-value value '(:struct ,struct) ',name))
          ((eql type :char)
           `(cffi:foreign-string-to-lisp
             (cffi:foreign-slot-pointer value '(:struct ,struct) ',name)
             :count ,count :encoding :utf-8))
          (T
           `(loop with ptr = (cffi:foreign-slot-pointer value '(:struct ,struct) ',name)
                  for i from 0 below ,count
                  collect (cffi:mem-aref ptr ',type i))))))

(defmacro steam::defcstruct* (name &body slots)
  (flet ((name (format &rest args)
           (intern (format NIL "~?" format args) '#:org.shirakumo.fraf.steamworks.cffi)))
    (let ((name-class (name "~a-TCLASS" name))
          (constructor (name "MAKE-~a" name))
          (handle (name "_HANDLE"))
          (handle-accessor (name "~a-_HANDLE" name)))
      `(progn
         (cffi:defcstruct (,name :class ,name-class)
           ,@slots)
         (defstruct (,name (:constructor ,constructor (,handle ,@(mapcar #'first slots))))
           ,handle ,@(mapcar #'first slots))
         (defmethod cffi:translate-from-foreign (value (type ,name-class))
           (,constructor
            value
            ,@(loop for slot in slots
                    collect (c-slot-value-extractor name slot))))
         (defmethod steam::_handle ((,name ,name))
           (,handle-accessor ,name))))))

(cffi:define-foreign-library steam::steamworks
  ((:and :darwin :x86)
   "libsteam_api.dylib"
   :search-path #.(merge-pathnames "osx32/" *static*))
  ((:and :unix :x86)
   "libsteam_api.so"
   :search-path #.(merge-pathnames "linux32/" *static*))
  ((:and :unix :x86-64)
   "libsteam_api.so"
   :search-path #.(merge-pathnames "linux64/" *static*))
  ((:and :windows :x86)
   "steam_api.dll"
   :search-path #.(merge-pathnames "/" *static*))
  ((:and :windows :x86-64)
   "steam_api.dll"
   :search-path #.(merge-pathnames "win64/" *static*)))

(cffi:defctype steam::steam-id :unsigned-long)

(defun maybe-load-low-level (&optional file)
  (let ((file (or file (make-pathname :name "low-level" :type "lisp" :defaults *this*))))
    (when (probe-file file)
      (cffi:load-foreign-library 'steam::steamworks)
      (let ((fasl #-asdf (compile-file-pathname file)
                  #+asdf (asdf:output-file (asdf:find-operation NIL 'asdf:compile-op)
                                           (make-instance 'asdf:cl-source-file
                                                          :parent (asdf:find-system :cl-steamworks)
                                                          :name "low-level"
                                                          :pathname file))))
        (if (probe-file fasl)
            (load fasl :verbose NIL :print NIL)
            (load file :verbose NIL :print NIL)))
      T)))

(defun maybe-compile-low-level (&optional file)
  (let ((file (or file (make-pathname :name "low-level" :type "lisp" :defaults *this*))))
    (when (probe-file file)
      (cffi:load-foreign-library 'steam::steamworks)
      #+asdf
      (let ((component (make-instance 'asdf:cl-source-file
                                      :parent (asdf:find-system :cl-steamworks)
                                      :name "low-level"
                                      :pathname file))
            (compile (asdf:find-operation NIL 'asdf:compile-op)))
        (asdf:perform compile component))
      #-asdf
      (let ((fasl (compile-file-pathname file)))
        (compile-file file :verbose NIL :print NIL :output-file fasl))
      T)))

;; DEFCSTRUCT interns its accessors in *PACKAGE* rather than using the package
;; of either CONC-NAME or the slot name, so we have to switch packages here.
(in-package #:org.shirakumo.fraf.steamworks.cffi)

#+windows
(cffi:defcstruct (vtable :class vtable :conc-name vtable-)
  (result-with-info :pointer)
  (result :pointer)
  (size :pointer))

#-windows
(cffi:defcstruct (vtable :class vtable :conc-name vtable-)
  ;; void (pointer this, pointer param)
  (result :pointer)
  ;; void (pointer this, pointer param, bool failed, steam-apicall-t api-call)
  (result-with-info :pointer)
  ;; int (pointer this)
  (size :pointer))

(cffi:defcstruct (callback :class callback :conc-name callback-)
  ;; Pointer to vtable instance.
  (vtable-ptr :pointer)
  ;; Should be 2 on a game server, 0 otherwise?
  (flags :uint8)
  ;; Identifier of the type of callback to register.
  (id :int)
  ;; Identifier for the callresult token.
  (token :uint64)
  ;; Self pointer used when calling back.
  (this :pointer)
  ;; Function pointer to call for callresult
  (function :pointer)
  ;; vtable alloc
  (vtable (:struct vtable)))
