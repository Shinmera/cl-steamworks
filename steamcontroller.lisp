#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamcontroller (c-managed-object interface)
  ((action-glyph-cache :initform (make-hash-table :test 'eql) :reader action-glyph-cache)
   (action-label-cache :initform (make-hash-table :test 'eql) :reader action-label-cache)))

(defmethod initialize-instance :after ((interface steamcontroller) &key)
  (steam::controller-init (handle interface)))

(defmethod allocate-handle ((interface steamcontroller) &key version steamworks)
  (get-interface-handle* steamworks 'steam::client-get-isteam-controller
                         (t-or version steam::steamcontroller-interface-version)))

(defmethod free-handle-function ((steamcontroller steamcontroller) handle)
  (lambda () (steam::controller-shutdown handle)))

(define-interface-method steamcontroller find-action-set (steam::controller-get-action-set-handle (name string))
  (check-invalid 0 result "FIXME: no action set found")
  (ensure-iface-obj 'action-set :interface steamcontroller :handle result))

(define-interface-method steamcontroller analog-action (steam::controller-get-analog-action-handle (name string))
  (check-invalid 0 result "FIXME: no action set found")
  (ensure-iface-obj 'analog-action :interface steamcontroller :handle result))

(define-interface-method steamcontroller digital-action (steam::controller-get-digital-action-handle (name string))
  (check-invalid 0 result "FIXME: no action set found")
  (ensure-iface-obj 'digital-action :interface steamcontroller :handle result))

(define-interface-method steamcontroller controller (steam::controller-get-controller-for-gamepad-index (index integer))
  (check-invalid 0 result "FIXME: no action set found")
  (ensure-iface-obj 'controller :interface steamcontroller :handle result))

(define-interface-method steamcontroller action-glyph (steam::controller-get-glyph-for-action-origin origin)
  ;; KLUDGE: ech, uiop
  (uiop:parse-native-namestring result))
(define-interface-method steamcontroller action-label (steam::controller-get-string-for-action-origin origin))
(define-interface-method steamcontroller run-frame (steam::controller-run-frame))

(defmethod action-glyph :around ((interface steamcontroller) origin)
  (or (gethash origin (action-glyph-cache interface))
      (setf (gethash origin (action-glyph-cache interface))
            (call-next-method))))

(defmethod action-label :around ((interface steamcontroller) origin)
  (or (gethash origin (action-label-cache interface))
      (setf (gethash origin (action-label-cache interface))
            (call-next-method))))

(defmethod list-controllers ((steamcontroller steamcontroller))
  (cffi:with-foreign-object (handles 'steam::controller-handle-t steam::steam-controller-max-count)
    (let ((count (steam::controller-get-connected-controllers (handle steamcontroller) handles)))
      (loop for i from 0 below count
            for handle = (cffi:mem-aref handles 'steam::controller-handle-t i)
            collect (ensure-iface-obj 'controller :interface steamcontroller :handle handle)))))

(defclass controller (interface-object)
  ()
  (:default-initargs :interface 'steamcontroller))

(defmethod list-action-set-layers ((controller controller))
  (cffi:with-foreign-object (handles 'steam::controller-action-set-handle-t steam::steam-controller-max-count)
    (let ((count (steam::controller-get-active-action-set-layers (handle (iface controller)) (handle controller) handles)))
      (loop for i from 0 below count
            for handle = (cffi:mem-aref handles 'steam::controller-action-set-handle-t i)
            collect (ensure-iface-obj 'action-set-layer :interface (iface controller) :handle handle)))))

(define-interface-submethod controller action-set (steam::controller-get-current-action-set)
  (ensure-iface-obj 'action-set :interface (iface controller) :handle result))

(define-interface-submethod controller index (steam::controller-get-gamepad-index-for-controller)
  ;; WTF: I don't know how to detect if the controller is /not/ emulating a gamepad.
  )

(define-interface-submethod controller input-type (steam::controller-get-input-type-for-handle))
(define-interface-submethod controller show-binding-panel (steam::controller-show-binding-panel))

(defmethod (setf led-color) ((value (eql NIL)) (controller controller))
  (steam::controller-set-ledcolor (iface* controller) (handle controller) 0 0 0
                                  (flags 'steam::esteam-controller-ledflag :restore-user-default)))

(defmethod (setf led-color) ((value cons) (controller controller))
  (destructuring-bind (r g b) value
    (steam::controller-set-ledcolor (iface* controller) (handle controller) r g b
                                    (flags 'steam::esteam-controller-ledflag :set-color))))

(defmethod (setf led-color) ((value vector) (controller controller))
  (steam::controller-set-ledcolor (iface* controller) (handle controller) (aref value 0) (aref value 1) (aref value 2)
                                  (flags 'steam::esteam-controller-ledflag :set-color)))

(defmethod (setf led-color) ((value integer) (controller controller))
  (let ((r (logand #xFF (ash value 16)))
        (g (logand #xFF (ash value  8)))
        (b (logand #xFF (ash value  0))))
    (steam::controller-set-ledcolor (iface* controller) (handle controller) r g b
                                    (flags 'steam::esteam-controller-ledflag :set-color))))

(defmethod motion-data ((controller controller))
  (with-foreign-value (data '(:struct steam::input-motion-data))
    (steam::shim-isteam-controller-get-motion-data (iface* controller) (handle controller) data)))

(defmethod haptic-pulse ((controller controller) pad &key (duration 0.1) (pause 0.1) (repeat 1))
  (if (<= repeat 1)
      (steam::controller-trigger-haptic-pulse (iface* controller) (handle controller) pad
                                              (microsecs duration))
      (steam::controller-trigger-repeated-haptic-pulse (iface* controller) (handle controller) pad
                                                       (microsecs duration) (microsecs pause) repeat 0)))

(defmethod vibrate ((controller controller) &key (duration 0.1) (left duration) (right duration))
  (steam::controller-trigger-vibration (iface* controller) (handle controller)
                                       (microsecs left) (microsecs right)))

(defclass action-set (interface-object)
  ()
  (:default-initargs :interface 'steamcontroller))

(defmethod activate ((set action-set) (controller integer))
  (steam::controller-activate-action-set (iface* set) controller (handle set)))

(defmethod activate (thing (controller controller))
  (activate thing (handle controller)))

(defmethod activate (thing (all (eql T)))
  (activate thing steam::steam-controller-handle-all-controllers))

(defclass action-set-layer (interface-object)
  ()
  (:default-initargs :interface 'steamcontroller))

(defmethod activate ((set action-set-layer) (controller integer))
  (steam::controller-activate-action-set-layer (iface* set) controller (handle set)))

(defmethod deactivate ((set action-set-layer) (controller integer))
  (steam::controller-deactivate-action-set-layer (iface* set) controller (handle set)))

(defmethod deactivate ((set (eql T)) (controller integer))
  (steam::controller-deactivate-all-action-set-layers (iface* set) controller))

(defclass analog-action (interface-object)
  ()
  (:default-initargs :interface 'steamcontroller))

(defmethod origins ((action analog-action) (controller controller) (set action-set))
  (cffi:with-foreign-object (origins 'steam::econtroller-action-origin steam::steam-controller-max-origins)
    (let ((count (steam::controller-get-analog-action-origins (iface* action) (handle controller) (handle set) (handle action) origins)))
      (loop for i from 0 below count
            collect (cffi:mem-aref origins 'steam::econtroller-action-origin i)))))

(defmethod action-data ((action analog-action) (controller controller))
  (with-foreign-value (data '(:struct steam::input-analog-action-data))
    (steam::shim-isteam-controller-get-analog-action-data (iface* controller) (handle controller) (handle action) data)))

(defmethod stop-action-momentum ((action analog-action) (controller controller))
  (steam::controller-stop-analog-action-momentum (iface* action) (handle controller) (handle action)))

(defclass digital-action (interface-object)
  ()
  (:default-initargs :interface 'steamcontroller))

(defmethod origins ((action digital-action) (controller controller) (set action-set))
  (cffi:with-foreign-object (origins 'steam::econtroller-action-origin steam::steam-controller-max-origins)
    (let ((count (steam::controller-get-digital-action-origins (iface* action) (handle controller) (handle set) (handle action) origins)))
      (loop for i from 0 below count
            collect (cffi:mem-aref origins 'steam::econtroller-action-origin i)))))

(defmethod action-data ((action digital-action) (controller controller))
  (with-foreign-value (data '(:struct steam::input-digital-action-data))
    (steam::shim-isteam-controller-get-digital-action-data (iface* controller) (handle controller) (handle action) data)))
