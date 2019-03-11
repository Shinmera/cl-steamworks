#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass %callback (c-managed-object)
  ((struct-type :initarg :struct-type :accessor struct-type)))

(defmethod initialize-instance :before ((callback %callback) &key struct-type)
  (unless (and struct-type (boundp struct-type) (foreign-type-p struct-type))
    (error "~s is not a valid callback struct type." struct-type)))

(defmethod allocate-handle ((callback %callback))
  (let* ((handle (calloc '(:struct steam::callback)))
         (vtable (cffi:foreign-slot-pointer handle '(:struct steam::callback) 'steam::vtable)))
    (setf (steam::callback-vtable-ptr handle) vtable)
    (setf (steam::callback-id handle) (symbol-value (struct-type callback)))
    (setf (steam::callback-flags handle) (if (server-p (steamworks)) 2 0))
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

(defclass callresult (%callback)
  ((token :initarg :token :reader token)))

(defmethod initialize-instance :after ((callresult callresult) &key token)
  (steam::register-call-result (handle callresult) token))

(defmethod allocate-handle ((callresult callresult))
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
           utils token result (cffi:foreign-type-size result-type) (symbol-value (struct-type callresult)) failed)
          (cffi:mem-ref result result-type)
          (error "FIXME: call failed: ~a" (steam::utils-get-apicall-failure-reason utils token))))))

(cffi:defcallback result :void ((this :pointer) (parameter :pointer) (failed :bool))
  (let ((callback (pointer->object this)))
    (if callback
        (callback callback (cffi:mem-ref parameter `(:struct ,(struct-type callback))) failed)
        (warn* "Callback for unregistered pointer ~a" this))))

(defclass closure-callresult (callresult)
  ((closure :initarg :closure :initform (error "CLOSURE required.") :reader closure)))

(defmethod callback ((callresult closure-callresult) parameter &optional failed api-call)
  (declare (ignore api-call))
  (funcall (closure callresult) (if failed NIL parameter)))
