(in-package #:org.shirakumo.fraf.steamworks)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defvar *this* #.(or *compile-file-pathname* *load-pathname*
                       (error "COMPILE-FILE or LOAD this file.")))
  (defvar *static*
    (make-pathname :name NIL :type NIL
                   :defaults (merge-pathnames "static/" *this*))))

(defparameter steam::*debug-calls* NIL)
(defvar steam::*callback-id-map* (make-hash-table :test 'eq))
(defvar steam::*function-callresult-map* (make-hash-table :test 'eq))

(defun callback-type-id (callback)
  (or (gethash callback steam::*callback-id-map*)
      (if *low-level-present*
          (error "Not a callback: ~s" callback)
          0)))

(define-compiler-macro callback-type-id (&whole whole callback &environment env)
  (if (constantp callback env)
      `(load-time-value (or (gethash ,callback steam::*callback-id-map*)
                            (if *low-level-present*
                                (error "Not a callback: ~s" ,callback)
                                0)))
      whole))

(defun function-callresult (function)
  (or (gethash function steam::*function-callresult-map*)
      (if *low-level-present*
          (error "Not a callresult function: ~s" function)
          NIL)))

(define-compiler-macro function-callresult (&whole whole function &environment env)
  (if (constantp function env)
      `(load-time-value (or (gethash ,function steam::*function-callresult-map*)
                            (if *low-level-present*
                                (error "Not a callresult function: ~s" ,function)
                                NIL)))
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

(defmacro steam::defcfun* ((lisp-name foreign-name &rest options) return-type &rest args)
  (flet ((format-arg (arg)
           (case (let ((type (second arg)))
                   (if (listp type) (first type) type))
             (:pointer `(if (cffi:null-pointer-p ,(first arg))
                            "NULL"
                            (format NIL "0x~8,'0x" (cffi:pointer-address ,(first arg)))))
             ((:bool :boolean) `(if ,(first arg) 1 0))
             (T (first arg)))))
    (let* ((arg-names (mapcar #'first args))
           (arg-types (mapcar #'second args))
           (syms (cffi::make-gensym-list (length args))))
      (multiple-value-bind (prelude caller)
          (cffi::defcfun-helper-forms
              foreign-name lisp-name (cffi::canonicalize-foreign-type return-type)
            syms (mapcar #'cffi::canonicalize-foreign-type arg-types) options)
        `(progn
           ,prelude
           (defun ,lisp-name ,arg-names
             ,(when steam::*debug-calls*
                `(format *debug-io* ,(format NIL "~~&~a(~{~~a~*~^, ~}) " foreign-name args)
                         ,@(mapcar #'format-arg args)))
             (let ((retval ,(cffi::translate-objects syms arg-names arg-types return-type caller)))
               ,(when (and steam::*debug-calls* (not (eql :void return-type)))
                  `(format *debug-io* "~a~%" ,(format-arg (list 'retval return-type))))
               retval)))))))

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
  ((:and :darwin)
   "libsteam_api.dylib"
   :search-path #.(merge-pathnames "osx/" *static*))
  ((:and :linux :x86)
   "libsteam_api.so"
   :search-path #.(merge-pathnames "linux32/" *static*))
  ((:and :linux :x86-64)
   "libsteam_api.so"
   :search-path #.(merge-pathnames "linux64/" *static*))
  ((:and :windows :x86)
   "steam_api.dll"
   :search-path #.(merge-pathnames "/" *static*))
  ((:and :windows :x86-64)
   (:or "steam_api64.dll" "steam_api.dll")
   :search-path #.(merge-pathnames "win64/" *static*)))

(cffi:define-foreign-library steam::steamworks-shim
  ((:and :darwin)
   "steamworks_shim.dylib"
   :search-path #.(merge-pathnames "osx/" *static*))
  ((:and :linux :x86)
   "steamworks_shim.so"
   :search-path #.(merge-pathnames "linux32/" *static*))
  ((:and :linux :x86-64)
   "steamworks_shim.so"
   :search-path #.(merge-pathnames "linux64/" *static*))
  ((:and :windows :x86)
   "steamworks_shim.dll"
   :search-path #.(merge-pathnames "/" *static*))
  ((:and :windows :x86-64)
   "steamworks_shim.dll"
   :search-path #.(merge-pathnames "win64/" *static*)))

(cffi:defctype steam::steam-id :unsigned-long)

(defvar *low-level-present* NIL)

(defun maybe-load-low-level (&optional file)
  (let ((file (or file (make-pathname :name "low-level" :type "lisp" :defaults *this*))))
    (when (probe-file file)
      (let ((fasl #+asdf (funcall asdf/driver:*output-translation-function* (compile-file-pathname file))
                  #-asdf (compile-file-pathname file)))
        (unless (probe-file fasl)
          (ignore-errors (compile-file file :verbose NIL :print NIL :output-file fasl)))
        (if (probe-file fasl)
            (load fasl :verbose NIL :print NIL)
            (load file :verbose NIL :print NIL)))
      (setf *low-level-present* T))))

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
