#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defvar *global-callbacks* (make-hash-table :test 'eq))

(defun global-callback (name &optional (errorp T))
  (or (gethash name *global-callbacks*)
      (when errorp (error 'no-such-callback :callback-name name))))

(defun (setf global-callback) (callback name)
  (check-type name symbol)
  (check-type callback (cons symbol (cons function null)))
  (setf (gethash name *global-callbacks*) callback))

(defun remove-global-callback (name)
  (remhash name *global-callbacks*))

(defmacro define-callback (struct-type (result &rest slots) &body body)
  (destructuring-bind (name type) (enlist struct-type struct-type)
    `(flet ((callback-thunk (,result)
              (let ,(loop for slot in slots
                          collect (destructuring-bind (var name) (enlist slot slot)
                                    (list var `(,(intern (format NIL "~a-~a" type name) '#:steam) ,result))))
                ,@body)))
       (setf (global-callback ',name)
             (list ',type #'callback-thunk)))))

(defun create-global-callbacks ()
  (loop for (struct-type thunk) being the hash-values of *global-callbacks*
        do (make-instance 'closure-callback :closure thunk :struct-type struct-type)))

(defclass %callback (c-registered-object c-managed-object)
  ((struct-type :initarg :struct-type :accessor struct-type)))

(defmethod initialize-instance :before ((callback %callback) &key struct-type)
  (unless (and struct-type (boundp struct-type) (foreign-type-p struct-type))
    (error "~s is not a valid callback struct type." struct-type)))

(defmethod allocate-handle ((callback %callback) &key)
  (let* ((handle (calloc '(:struct steam::callback)))
         (vtable (cffi:foreign-slot-pointer handle '(:struct steam::callback) 'steam::vtable)))
    (setf (steam::callback-vtable-ptr handle) vtable)
    (setf (steam::callback-id handle) (callback-type-id (struct-type callback)))
    (setf (steam::callback-flags handle) (if (typep (steamworks) 'steamworks-server) 2 0))
    (setf (steam::vtable-result vtable) (cffi:callback callback))
    (setf (steam::vtable-result-with-info vtable) (cffi:callback callback-with-info))
    (setf (steam::vtable-size vtable) (cffi:callback size))
    handle))

(defgeneric callback (callback parameter &optional failed api-call))

;; FIXME: supposedly on x86 Windows it does not use thiscall
;; FIXME: thiscall does /not/ work via a this pointer as the first arg on the stack
;;        but rather like stdcall with ECX being the this pointer. That's a big problem.
;;        See: https://docs.microsoft.com/en-us/cpp/cpp/thiscall?view=vs-2017
(cffi:defcallback callback :void ((this :pointer) (parameter :pointer))
  (let ((callback (pointer->object this)))
    (if callback
        (callback callback (cffi:mem-ref parameter `(:struct ,(struct-type callback))))
        (warn* "Callback for unregistered pointer ~a" this))))

(cffi:defcallback callback-with-info :void ((this :pointer) (parameter :pointer) (failed :bool) (api-call :uint64))
  (let ((callback (pointer->object this)))
    (if callback
        (callback callback (cffi:mem-ref parameter `(:struct ,(struct-type callback))) failed api-call)
        (warn* "Callback for unregistered pointer ~a" this))))

(cffi:defcallback size :int ((this :pointer))
  (let ((callback (pointer->object this)))
    (if callback
        (cffi:foreign-type-size `(:struct ,(struct-type callback)))
        (warn* "Callback for unregistered pointer ~a" this))))

(defclass callback (%callback)
  ())

(defmethod initialize-instance :after ((callback callback) &key)
  (steam::register-callback (handle callback) (steam::callback-id (handle callback))))

(defmethod free-handle-function ((callback callback) handle)
  (lambda ()
    (steam::unregister-callback handle)
    (cffi:foreign-free handle)))

(defclass closure-callback (callback)
  ((closure :initarg :closure :initform (error "CLOSURE required.") :reader closure)))

(defmethod callback ((callback closure-callback) parameter &optional failed api-call)
  (declare (ignore api-call))
  (when (funcall (closure callback) (if failed NIL parameter))
    (free callback)))

(defclass callresult (%callback)
  ((token :initarg :token :reader token)))

(defmethod initialize-instance :after ((callresult callresult) &key token (register T))
  (when register
    (steam::register-call-result (handle callresult) token)))

(defmethod allocate-handle ((callresult callresult) &key)
  (let ((handle (call-next-method)))
    (setf (steam::callback-token handle) (token callresult))
    (setf (steam::callback-this handle) handle)
    (setf (steam::callback-function handle) (cffi:callback result))
    handle))

(defmethod free-handle-function ((callresult callresult) handle)
  (lambda ()
    (steam::unregister-call-result handle (token callresult))
    (cffi:foreign-free handle)))

(defmethod maybe-result ((callresult callresult))
  (let ((utils (handle (interface 'steamutils T))))
    (cffi:with-foreign-object (failed :bool)
      (when (steam::utils-is-apicall-completed utils (token callresult) failed)
        (result callresult)))))

(defmethod result ((callresult callresult))
  (let ((utils (handle (interface 'steamutils T)))
        (token (token callresult))
        (result-type `(:struct ,(struct-type callresult))))
    (cffi:with-foreign-objects ((failed :bool)
                                (result result-type))
      (if (steam::utils-get-apicall-result
           utils token result (cffi:foreign-type-size result-type) (callback-type-id (struct-type callresult)) failed)
          (cffi:mem-ref result result-type)
          (error 'api-call-failed
                 :api-call (struct-type callresult)
                 :error-code (steam::utils-get-apicall-failure-reason utils token))))))

(cffi:defcallback result :void ((this :pointer) (parameter :pointer) (failed :bool))
  (let ((callback (pointer->object this)))
    (if callback
        (callback callback (cffi:mem-ref parameter `(:struct ,(struct-type callback))) failed)
        (warn* "Callback for unregistered pointer ~a" this))))

(defclass closure-callresult (callresult)
  ((closure :initarg :closure :initform (error "CLOSURE required.") :reader closure)))

(defmethod callback ((callresult closure-callresult) parameter &optional failed api-call)
  (declare (ignore api-call))
  (unwind-protect (funcall (closure callresult) (if failed NIL parameter))
    (free callresult)))

(defun poll-for-result (type handle &key (pause 0.01))
  (let ((instance (make-instance 'closure-callresult
                                 :token handle
                                 :struct-type type
                                 :closure (constantly NIL))))
    (loop for result = (maybe-result instance)
          do (if result
                 (return result)
                 (sleep pause)))))

(defmacro with-call-result ((result &key poll) (method interface &rest args) &body body &environment env)
  ;; KLUDGE: in order to infer the struct-type we need access to the method name
  ;;         which extends the macro to the call and disallows passing a token
  ;;         directly.
  (let ((thunk (gensym "THUNK"))
        (instance (gensym "INSTANCE"))
        (interval (gensym "INTERVAL"))
        (interface (if (constantp interface env)
                       `(interface ,interface T)
                       interface)))
    `(flet ((,thunk (,result)
              ,@body))
       (let ((,instance (make-instance 'closure-callresult
                                       :token (call-with #',method ,interface ,@args)
                                       :struct-type (function-callresult ',method)
                                       :closure #',thunk
                                       :register ,(null poll)))
             (,interval (let ((,interval ,poll))
                          (etypecase ,interval
                            
                            ((eql T) 0.01)
                            (integer ,interval)))))
         (if ,interval
             (loop for ,result = (maybe-result ,instance)
                   do (if ,result
                          (return (,thunk ,result))
                          (sleep ,interval)))
             ,instance)))))
