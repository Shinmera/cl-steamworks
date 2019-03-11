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

(defmethod call-with (function (interface interface) &rest args)
  (apply function (handle interface) args))

(defmethod call-with (function (interface symbol) &rest args)
  (call-with function (interface interface (steamworks)) args))

(defclass steamclient (interface)
  ())

(defmethod initialize-instance :after ((client steamclient) &key version)
  (let ((handle (cl-steamworks-cffi::steam-internal-create-interface version)))
    (when (cffi:null-pointer-p handle)
      (error "FIXME: failed to create steam client handle."))
    (setf (handle client) handle)))
