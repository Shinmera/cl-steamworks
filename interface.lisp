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

(defmacro define-interface-method (interface method call &body transform)
  (let ((function (find-if (lambda (a) (eq (symbol-package a) (find-package '#:steam))) call))
        (method-args (copy-list call)))
    (setf (nth (position function method-args) method-args) (list interface interface))
    `(defmethod ,method ,method-args
       (let ((result (,function (handle ,interface) ,@(apply #'remove-all (mapcar #'delist call)
                                                             function LAMBDA-LIST-KEYWORDS))))
         ,@(or transform `(result))))))

(defmacro define-interface-submethod (interface sub method call)
  (let ((function (find-if (lambda (a) (eq (symbol-package a) (find-package '#:steam))) call))
        (method-args (copy-list call)))
    (setf (nth (position function method-args) method-args) (list sub sub))
    `(defmethod ,method ,method-args
       (,function (handle (,interface ,sub)) (handle ,sub)
                  ,@(apply #'remove-all (mapcar #'delist call)
                           function LAMBDA-LIST-KEYWORDS)))))
