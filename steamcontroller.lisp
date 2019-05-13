#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamcontroller (interface)
  ())

(defmethod initialize-instance :after ((interface steamcontroller) &key version steamworks)
  (setf (handle interface) (get-interface-handle* steamworks 'steam::client-get-isteam-controller
                                                  (t-or version steam::steamcontroller-interface-version))))

(defclass controller (interface-object)
  ()
  (:default-initargs :interface 'steamcontroller))

(defmethod list-action-set-layers ((controller controller))
  (cffi:with-foreign-object (handles 'steam::controller-action-set-handle-t 16)
    (let ((count (steam::controller-get-active-action-set-layers (handle (iface controller)) (handle controller) handles)))
      (loop for i from 0 below count
            for handle = (cffi:mem-aref handles 'steam::controller-action-set-handle-t i)
            collect (make-instance 'action-set-layer :interface (iface controller) :handle handle)))))

(defclass action-set (interface-object)
  ()
  (:default-initargs :interface 'steamcontroller))

(defmethod activate ((set action-set) (controller integer))
  (steam::controller-activate-action-set (iface* set) controller (handle set)))

(defmethod activate (thing (controller controller))
  (activate thing (handle controller)))

(defmethod activate (thing (all (eql T)))
  (activate thing (1- (ash 1 64))))

(defclass action-set-layer (interface-object)
  ()
  (:default-initargs :interface 'steamcontroller))

(defmethod activate ((set action-set-layer) (controller integer))
  (steam::controller-activate-action-set-layer (iface* set) controller (handle set)))

(defmethod deactivate ((set action-set-layer) (controller integer))
  (steam::controller-deactivate-action-set-layer (iface* set) controller (handle set)))

(defmethod deactivate ((set (eql T)) (controller integer))
  (steam::controller-deactivate-all-action-set-layers (iface* set) controller))
