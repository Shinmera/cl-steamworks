#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass interface (c-object)
  ((steamworks :initarg :steamworks :initform (error "STEAMWORKS required.") :reader %steamworks)))

(defun get-interface-handle (steamworks function &rest args)
  (let ((handle (apply function (handle (interface 'steamclient steamworks)) args)))
    (when (cffi:null-pointer-p handle)
      (error "FIXME: failed to create steam utils handle."))
    handle))

(defmethod call-with ((interface interface) function &rest args)
  (apply function (handle interface) args))

(defmethod call-with ((interface symbol) function &rest args)
  (apply #'call-with (interface interface (steamworks)) function args))

(defclass steamclient (interface)
  ())

(defmethod initialize-instance :after ((client steamclient) &key version)
  (let ((handle (steam::create-interface version)))
    (when (cffi:null-pointer-p handle)
      (error "FIXME: failed to create steam client handle."))
    (setf (handle client) handle)
    (steam::client-set-warning-message-hook handle (cffi:callback warning-message))))

(cffi:defcallback warning-message :void ((severity :int) (debug-text :string))
  (format *error-output* "~&[~[INFO~;WARN~;ERR ~]] Steam: ~a~%"
          severity debug-text))
