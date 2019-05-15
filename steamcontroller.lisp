#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

;; FIXME: crawl constants

(defclass steamcontroller (c-managed-object interface)
  ())

(defmethod initialize-instance :after ((interface steamcontroller) &key version steamworks)
  (setf (handle interface) (get-interface-handle* steamworks 'steam::client-get-isteam-controller
                                                  (t-or version steam::steamcontroller-interface-version)))
  (steam::controller-init (handle interface)))

(defmethod free-handle-function ((steamcontroller steamcontroller) handle)
  (lambda () (steam::controller-shutdown handle)))

(define-interface-method steamcontroller find-action-set (steam::controller-get-action-set-handle (name string))
  (when (= 0 result)
    (error "FIXME: no action set found"))
  (make-instance 'action-set :interface steamcontroller :handle result))

(define-interface-method steamcontroller analog-action (steam::controller-get-analog-action-handle (name string))
  (when (= 0 result)
    (error "FIXME: no analog action found"))
  (make-instance 'analog-action :interface steamcontroller :handle result))

(define-interface-method steamcontroller digital-action (steam::controller-get-digital-action-handle (name string))
  (when (= 0 result)
    (error "FIXME: no digital action found"))
  (make-instance 'digital-action :interface steamcontroller :handle result))

(define-interface-method steamcontroller controller (steam::controller-get-controller-for-gamepad-index (index integer))
  (when (= 0 result)
    (error "FIXME: no controller at index"))
  (make-instance 'controller :interface steamcontroller :handle result))

(define-interface-method steamcontroller action-glyph (steam::controller-get-glyph-for-action-origin origin)
  ;; KLUDGE: ech, uiop
  ;; FIXME: cache
  (uiop:parse-native-namestring result))

(define-interface-method steamcontroller action-label (steam::controller-get-string-for-action-origin origin)
  ;; FIXME: cache
  )

(define-interface-method steamcontroller run-frame (steam::controller-run-frame))

(defmethod list-controllers ((steamcontroller steamcontroller))
  (cffi:with-foreign-object (handles 'steam::controller-handle-t 16)
    (let ((count (steam::controller-get-connected-controllers (handle steamcontroller) handles)))
      (loop for i from 0 below count
            for handle = (cffi:mem-aref handles 'steam::controller-handle-t i)
            collect (make-instance 'controller :interface steamcontroller :handle handle)))))

(defclass controller (interface-object)
  ()
  (:default-initargs :interface 'steamcontroller))

(defmethod initialize-instance :after ((controller controller) &key index)
  (when index
    (setf (handle controller) (steam::controller-get-controller-for-gamepad-index (iface* controller) index))))

(defmethod list-action-set-layers ((controller controller))
  (cffi:with-foreign-object (handles 'steam::controller-action-set-handle-t 16)
    (let ((count (steam::controller-get-active-action-set-layers (handle (iface controller)) (handle controller) handles)))
      (loop for i from 0 below count
            for handle = (cffi:mem-aref handles 'steam::controller-action-set-handle-t i)
            collect (make-instance 'action-set-layer :interface (iface controller) :handle handle)))))

(define-interface-submethod controller action-set (steam::controller-get-current-action-set)
  (make-instance 'action-set :interface (iface controller) :handle result))

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
  ;; FIXME: can't implement this due to structure return.
  )

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

(defclass analog-action (interface-object)
  ()
  (:default-initargs :interface 'steamcontroller))

(defmethod origins ((action analog-action) (controller controller) (set action-set))
  (cffi:with-foreign-object (origins 'steam::econtroller-action-origin 8)
    (let ((count (steam::controller-get-analog-action-origins (iface* action) (handle controller) (handle set) (handle action) origins)))
      (loop for i from 0 below count
            collect (cffi:mem-aref origins 'steam::econtroller-action-origin i)))))

(defmethod action-data ((action analog-action) (controller controller))
  ;; FIXME: can't implement this due to structure return.
  )

(defmethod stop-action-momentum ((action analog-action) (controller controller))
  (steam::controller-stop-analog-action-momentum (iface* action) (handle controller) (handle action)))

(defclass digital-action (interface-object)
  ()
  (:default-initargs :interface 'steamcontroller))

(defmethod origins ((action digital-action) (controller controller) (set action-set))
  (cffi:with-foreign-object (origins 'steam::econtroller-action-origin 8)
    (let ((count (steam::controller-get-digital-action-origins (iface* action) (handle controller) (handle set) (handle action) origins)))
      (loop for i from 0 below count
            collect (cffi:mem-aref origins 'steam::econtroller-action-origin i)))))

(defmethod action-data ((action digital-action) (controller controller))
  ;; FIXME: can't implement this due to structure return.
  )
