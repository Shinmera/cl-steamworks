(in-package #:org.shirakumo.fraf.steamworks)

(defclass steaminput (c-managed-object interface)
  ((action-glyph-cache :initform (make-hash-table :test 'eql) :reader action-glyph-cache)
   (action-label-cache :initform (make-hash-table :test 'eql) :reader action-label-cache))
  (:default-initargs :free-on-gc T))

(defmethod initialize-instance :after ((interface steaminput) &key (version T) steamworks)
  (setf (handle interface) (get-interface-handle steamworks 'steam::client-get-isteam-input
                                                 (handle (user steamworks)) (handle (pipe steamworks))
                                                 (t-or version STEAM::STEAMINPUT-INTERFACE-VERSION)))
  (steam::input-init (handle interface) T))

(defmethod allocate-handle ((interface steaminput) &key (version T) steamworks)
  (get-interface-handle* steamworks 'steam::client-get-isteam-input
                         (t-or version STEAM::STEAMINPUT-INTERFACE-VERSION)))

(defmethod free-handle-function ((steaminput steaminput) handle)
  (lambda () (steam::input-shutdown handle)))

(define-interface-method steaminput find-action-set (steam::input-get-action-set-handle (name string))
  (when (< 0 result)
    (ensure-iface-obj 'action-set :interface steaminput :handle result)))

(define-interface-method steaminput find-analog-action (steam::input-get-analog-action-handle (name string))
  (when (< 0 result)
    (ensure-iface-obj 'analog-action :interface steaminput :handle result)))

(define-interface-method steaminput find-digital-action (steam::input-get-digital-action-handle (name string))
  (when (< 0 result)
    (ensure-iface-obj 'digital-action :interface steaminput :handle result)))

(define-interface-method steaminput find-controller (steam::input-get-controller-for-gamepad-index (index integer))
  (when (< 0 result)
    (ensure-iface-obj 'controller :interface steaminput :handle result)))

(define-interface-method steaminput action-glyph (steam::input-get-glyph-for-action-origin origin)
  ;; KLUDGE: ech, uiop
  (uiop:parse-native-namestring result))
(define-interface-method steaminput action-label (steam::input-get-string-for-action-origin origin))
(define-interface-method steaminput run-frame (steam::input-run-frame))
(define-interface-method steaminput translate-action-origin (steam::input-translate-action-origin controller-type button))

(defmethod action-glyph :around ((interface steaminput) origin)
  (or (gethash origin (action-glyph-cache interface))
      (setf (gethash origin (action-glyph-cache interface))
            (call-next-method))))

(defmethod action-label :around ((interface steaminput) origin)
  (or (gethash origin (action-label-cache interface))
      (setf (gethash origin (action-label-cache interface))
            (call-next-method))))

(defmethod list-controllers ((steaminput steaminput))
  (cffi:with-foreign-object (handles 'steam::input-handle steam::steam-input-max-count)
    (let ((count (steam::input-get-connected-controllers (handle steaminput) handles)))
      (loop for i from 0 below count
            for handle = (cffi:mem-aref handles 'steam::input-handle i)
            collect (ensure-iface-obj 'controller :interface steaminput :handle handle)))))

(defmacro do-controllers ((controller interface) &body body)
  (let ((steaminput (gensym "STEAMINPUT")))
    `(cffi:with-foreign-object (handles 'steam::input-handle steam::steam-input-max-count)
       (let* ((,steaminput ,interface)
              (count (steam::input-get-connected-controllers (handle ,steaminput) handles)))
         (loop for i from 0 below count
               for handle = (cffi:mem-aref handles 'steam::input-handle i)
               for ,controller = (ensure-iface-obj 'controller :interface ,steaminput :handle handle)
               do (progn ,@body))))))

(defclass controller (interface-object)
  ()
  (:default-initargs :interface 'steaminput))

(defmethod list-action-set-layers ((controller controller))
  (cffi:with-foreign-object (handles 'steam::input-action-set-handle steam::steam-input-max-count)
    (let ((count (steam::input-get-active-action-set-layers (iface* controller) (handle controller) handles)))
      (loop for i from 0 below count
            for handle = (cffi:mem-aref handles 'steam::input-action-set-handle i)
            collect (ensure-iface-obj 'action-set-layer :interface (iface controller) :handle handle)))))

(define-interface-submethod controller action-set (steam::input-get-current-action-set)
  (ensure-iface-obj 'action-set :interface (iface controller) :handle result))

(define-interface-submethod controller index (steam::input-get-gamepad-index-for-controller)
  ;; WTF: I don't know how to detect if the controller is /not/ emulating a gamepad.
  )

(define-interface-submethod controller input-type (steam::input-get-input-type-for-handle))
(define-interface-submethod controller show-binding-panel (steam::input-show-binding-panel))
(define-interface-submethod controller remote-play-session-id (steam::input-get-remote-play-session-id))
(define-interface-submethod controller xbox-action-origin (steam::input-get-action-origin-from-xbox-origin origin))

(defmethod device-binding-revision ((controller controller))
  (cffi:with-foreign-objects ((major :int) (minor :int))
    (if (steam::input-get-device-binding-revision (iface* controller) (handle controller) major minor)
        (values (cffi:mem-ref major :int) (cffi:mem-ref minor :int) T)
        (values 0 0 NIL))))

(defmethod (setf led-color) ((value (eql NIL)) (controller controller))
  (steam::input-set-ledcolor (iface* controller) (handle controller) 0 0 0
                             (flags 'steam::esteam-input-ledflag :restore-user-default)))

(defmethod (setf led-color) ((value cons) (controller controller))
  (destructuring-bind (r g b) value
    (steam::input-set-ledcolor (iface* controller) (handle controller) r g b
                               (flags 'steam::esteam-input-ledflag :set-color))))

(defmethod (setf led-color) ((value vector) (controller controller))
  (steam::input-set-ledcolor (iface* controller) (handle controller) (aref value 0) (aref value 1) (aref value 2)
                             (flags 'steam::esteam-input-ledflag :set-color)))

(defmethod (setf led-color) ((value integer) (controller controller))
  (let ((r (logand #xFF (ash value 16)))
        (g (logand #xFF (ash value  8)))
        (b (logand #xFF (ash value  0))))
    (steam::input-set-ledcolor (iface* controller) (handle controller) r g b
                               (flags 'steam::esteam-input-ledflag :set-color))))

(defmethod motion-data ((controller controller))
  (with-foreign-value (data '(:struct steam::input-motion-data))
    (steam::shim-isteam-input-get-motion-data (iface* controller) (handle controller) data)))

(defmethod haptic-pulse ((controller controller) pad &key (duration 0.1) (pause 0.1) (repeat 1))
  (if (<= repeat 1)
      (steam::input-trigger-haptic-pulse (iface* controller) (handle controller) pad
                                         (microsecs duration))
      (steam::input-trigger-repeated-haptic-pulse (iface* controller) (handle controller) pad
                                                  (microsecs duration) (microsecs pause) repeat 0)))

(defmethod vibrate ((controller controller) &key (duration 0.1) (left duration) (right duration))
  (steam::input-trigger-vibration (iface* controller) (handle controller)
                                  (microsecs left) (microsecs right)))

(defclass action-set (interface-object)
  ()
  (:default-initargs :interface 'steaminput))

(defmethod activate ((set action-set) (controller integer))
  (steam::input-activate-action-set (iface* set) controller (handle set)))

(defmethod activate (thing (controller controller))
  (activate thing (handle controller)))

(defmethod activate (thing (all (eql T)))
  (activate thing STEAM::STEAM-CONTROLLER-HANDLE-ALL-CONTROLLERS))

(defclass action-set-layer (interface-object)
  ()
  (:default-initargs :interface 'steaminput))

(defmethod activate ((set action-set-layer) (controller integer))
  (steam::input-activate-action-set-layer (iface* set) controller (handle set)))

(defmethod deactivate ((set action-set-layer) (controller integer))
  (steam::input-deactivate-action-set-layer (iface* set) controller (handle set)))

(defmethod deactivate ((set (eql T)) (controller integer))
  (steam::input-deactivate-all-action-set-layers (iface* set) controller))

(defclass analog-action (interface-object)
  ((previous-action-data :initform '(NIL :none 0f0 0f0) :accessor previous-action-data))
  (:default-initargs :interface 'steaminput))

(defmethod origins ((action analog-action) (controller controller) (set action-set))
  (cffi:with-foreign-object (origins 'steam::econtroller-action-origin steam::steam-input-max-origins)
    (let ((count (steam::input-get-analog-action-origins (iface* action) (handle controller) (handle set) (handle action) origins)))
      (loop for i from 0 below count
            collect (cffi:mem-aref origins 'steam::econtroller-action-origin i)))))

(defmethod action-data ((action analog-action) (controller controller))
  (cffi:with-foreign-object (data '(:struct steam::input-analog-action-data))
    (steam::shim-isteam-input-get-analog-action-data (iface* controller) (handle controller) (handle action) data)
    (setf (previous-action-data action) (list (cffi:foreign-slot-value data '(:struct steam::input-analog-action-data) 'steam::active)
                                              (cffi:foreign-slot-value data '(:struct steam::input-analog-action-data) 'steam::mode)
                                              (cffi:foreign-slot-value data '(:struct steam::input-analog-action-data) 'steam::x)
                                              (cffi:foreign-slot-value data '(:struct steam::input-analog-action-data) 'steam::y)))))

(defmethod stop-action-momentum ((action analog-action) (controller controller))
  (steam::input-stop-analog-action-momentum (iface* action) (handle controller) (handle action)))

(defclass digital-action (interface-object)
  ((previous-action-data :initform '(NIL NIL) :accessor previous-action-data))
  (:default-initargs :interface 'steaminput))

(defmethod origins ((action digital-action) (controller controller) (set action-set))
  (cffi:with-foreign-object (origins 'steam::econtroller-action-origin steam::steam-input-max-origins)
    (let ((count (steam::input-get-digital-action-origins (iface* action) (handle controller) (handle set) (handle action) origins)))
      (loop for i from 0 below count
            collect (cffi:mem-aref origins 'steam::econtroller-action-origin i)))))

(defmethod action-data ((action digital-action) (controller controller))
  (cffi:with-foreign-object (data '(:struct steam::input-digital-action-data))
    (steam::shim-isteam-input-get-digital-action-data (iface* controller) (handle controller) (handle action) data)
    (setf (previous-action-data action) (list (cffi:foreign-slot-value data '(:struct steam::input-digital-action-data) 'steam::active)
                                              (cffi:foreign-slot-value data '(:struct steam::input-digital-action-data) 'steam::state)))))
