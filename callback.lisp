#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass callback (c-object)
  ((struct-type :initarg :struct-type :accessor struct-type)))

(defmethod initialize-instance :before ((callback callback) &key struct-type)
  (unless (and struct-type (boundp struct-type) (foreign-type-p struct-type))
    (error "~s is not a valid callback struct type." struct-type)))

(defgeneric callback (callback parameter &optional failed api-call))

(defmethod allocate-handle ((callback callback))
  (let* ((handle (calloc '(:struct cl-steamworks-cffi::callback)))
         (vtable (cffi:foreign-slot-pointer handle '(:struct cl-steamworks-cffi::callback)
                                            'cl-steamworks-cffi::vtable)))
    (setf (cl-steamworks-cffi::callback-vtable-ptr handle) vtable)
    (setf (cl-steamworks-cffi::callback-id handle) (symbol-value (struct-type callback)))
    (setf (cl-steamworks-cffi::callback-flags handle) (if (server-p (steamworks)) 2 0))
    (setf (cl-steamworks-cffi::vtable-result vtable) (cffi:callback result))
    (setf (cl-steamworks-cffi::vtable-result-with-info vtable) (cffi:callback result-with-info))
    (setf (cl-steamworks-cffi::vtable-size vtable) (cffi:callback size))))

(defmethod free-handle-function ((callback callback) handle)
  (lambda ()
    (cl-steamworks-cffi::unregister-callback handle)
    (cffi:foreign-free handle)))

;; FIXME: supposedly on x86 Windows it does not use thiscall
;; FIXME: thiscall does /not/ work via a this pointer as the first arg on the stack
;;        but rather like stdcall with ECX being the this pointer. That's a big problem.
;;        See: https://docs.microsoft.com/en-us/cpp/cpp/thiscall?view=vs-2017
(cffi:defcallback result :void ((this :pointer) (parameter :pointer))
  (let ((callback (pointer->object this)))
    (if callback
        (result callback (cffi:mem-ref parameter `(:struct ,(struct-type callback))) NIL)
        (warn "Callback for unregistered pointer ~a" this))))

(cffi:defcallback result-with-info :void ((this :pointer) (parameter :pointer) (failed :bool) (api-call :uint64))
  (let ((callback (pointer->object this)))
    (if callback
        (result callback (cffi:mem-ref parameter `(:struct ,(struct-type callback))) failed api-call)
        (warn "Callback for unregistered pointer ~a" this))))

(cffi:defcallback size :int ((this :pointer))
  (let ((callback (pointer->object this)))
    (if callback
        (cffi:foreign-type-size `(:struct ,(struct-type callback)))
        (warn "Callback for unregistered pointer ~a" this))))

(defclass callresult (callback)
  ((call-id :initarg :call-id :accessor call-id)))

(defmethod maybe-result ((callresult callresult))
  (let ((utils (handle (utils (steamworks)))))
    (cffi:with-foreign-object (failed :bool)
      (when (cl-steamworks-cffi::utils-is-apicall-completed utils (call-id callresult) failed)
        (result callresult)))))

(defmethod result ((callresult callresult))
  (let ((utils (handle (utils (steamworks))))
        (result-type `(:struct ,(struct-type callresult))))
    (cffi:with-foreign-object (result result-type)
      (when (cl-steamworks-cffi::utils-get-apicall-result
             utils id result (cffi:foreign-type-size result-type) (symbol-value (struct-type callresult)) failed)
        (cffi:mem-ref result result-type)))))
