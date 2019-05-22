#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass interface (c-object)
  ((steamworks :initarg :steamworks :initform (error "STEAMWORKS required.") :reader %steamworks)
   (object-cache :initform (tg:make-weak-hash-table :weakness :value :test 'eql) :reader object-cache)))

(defun ensure-iface-obj (class &rest initargs &key handle interface &allow-other-keys)
  (or (interface-object handle interface)
      (setf (interface-object handle interface)
            (apply #'make-instance class initargs))))

(defmethod interface ((name symbol) (interface interface))
  (interface (%steamworks interface)))

(defmethod interface-object (handle (interface symbol))
  (interface-object handle (interface interface T)))

(defmethod interface-object (handle (interface interface))
  (gethash handle (object-cache interface)))

(defmethod (setf interface-object) (object handle (name symbol))
  (setf (interface-object handle (interface name T)) object))

(defmethod (setf interface-object) (object handle (interface interface))
  (setf (gethash handle (object-cache interface)) object))

(defmethod remove-interface-object (handle (name symbol))
  (remove-interface-object handle (interface name T)))

(defmethod remove-interface-object (handle (interface interface))
  (remhash handle (object-cache interface)))

(defmethod remove-interface-object ((all (eql T)) (interface interface))
  (clrhash (object-cache interface)))

(defun get-interface-handle (steamworks function &rest args)
  (let ((handle (apply function (handle (interface 'steamclient steamworks)) args)))
    (when (cffi:null-pointer-p handle)
      (error "FIXME: failed to create steam utils handle."))
    handle))

(defun get-interface-handle* (steamworks function version)
  (get-interface-handle steamworks function (handle (user steamworks)) (handle (pipe steamworks)) version))

(defmethod call-with ((interface interface) function &rest args)
  (apply function (handle interface) args))

(defmethod call-with ((handle integer) function &rest args)
  (apply function handle args))

(defmethod call-with ((interface symbol) function &rest args)
  (apply #'call-with (interface interface (steamworks)) function args))

(defmacro define-interface-method (interface method call &body transform)
  (destructuring-bind (interface handle) (enlist interface 'handle)
    (let ((function (find-if (lambda (a) (and (symbolp a) (eq (symbol-package a) (find-package '#:steam)))) call))
          (method-args (copy-list call)))
      (setf (nth (position function method-args) method-args) (list interface interface))
      `(defmethod ,method ,method-args
         (let ((result (,function (,handle ,interface) ,@(apply #'remove-all (mapcar #'delist call)
                                                                function LAMBDA-LIST-KEYWORDS))))
           (declare (ignorable result))
           ,@(or transform
                 (when (listp method)
                   (list (delist (first call))))
                 `(result)))))))

(defmacro define-interface-submethod (sub method call &body transform)
  (destructuring-bind (sub handle) (enlist sub 'handle)
    (let ((function (find-if (lambda (a) (and (symbolp a) (eq (symbol-package a) (find-package '#:steam)))) call))
          (method-args (copy-list call)))
      (setf (nth (position function method-args) method-args) (list sub sub))
      `(defmethod ,method ,method-args
         (let ((result (,function (,handle (iface ,sub)) (handle ,sub)
                                  ,@(apply #'remove-all (mapcar #'delist call)
                                           function LAMBDA-LIST-KEYWORDS))))
           (declare (ignorable result))
           ,@(or transform
                 (when (listp method)
                   (list (delist (first call))))
                 `(result)))))))

(defclass interface-object (c-object)
  ((interface :reader iface)))

(defmethod initialize-instance ((object interface-object) &key interface steamworks)
  (call-next-method)
  (setf (slot-value object 'interface)
        (etypecase interface
          (interface interface)
          ((and symbol (not null)) (interface interface (or steamworks (steamworks)))))))

(defun iface* (object)
  (handle (iface object)))

(defmethod %steamworks ((object interface-object))
  (%steamworks (iface object)))

(defmethod interface ((name symbol) (object interface-object))
  (interface (%steamworks object)))
