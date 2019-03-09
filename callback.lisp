#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass callback (c-object)
  ())

(defgeneric result (callback parameter &optional failed api-call))
(defgeneric size (callback))

(defmethod allocate-handle ((object callback))
  (let* ((handle (calloc '(:struct cl-steamworks-cffi::callback)))
         (vtable (cffi:foreign-slot-pointer handle '(:struct cl-steamworks-cffi::callback)
                                            'cl-steamworks-cffi::vtable)))
    (setf (cl-steamworks-cffi::callback-vtable-ptr handle) vtable)
    (setf (cl-steamworks-cffi::vtable-result vtable) (cffi:callback result))
    (setf (cl-steamworks-cffi::vtable-result-with-info vtable) (cffi:callback result-with-info))
    (setf (cl-steamworks-cffi::vtable-size vtable) (cffi:callback size))))

;; FIXME: supposedly on x86 Windows it does not use thiscall, so...
(cffi:defcallback result :void ((this :pointer) (parameter :pointer))
  (let ((callback (pointer->object this)))
    (if callback
        (result callback parameter)
        (warn "Callback for unregistered pointer ~a" this))))

(cffi:defcallback result-with-info :void ((this :pointer) (parameter :pointer) (failed :bool) (api-call cl-steamworks-cffi::steam-apicall-t))
  (let ((callback (pointer->object this)))
    (if callback
        (result callback parameter failed api-call)
        (warn "Callback for unregistered pointer ~a" this))))

(cffi:defcallback size :int ((this :pointer))
  (let ((callback (pointer->object this)))
    (if callback
        (size callback)
        (warn "Callback for unregistered pointer ~a" this))))
