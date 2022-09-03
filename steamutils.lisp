#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamutils (interface)
  ())

(defmethod initialize-instance :after ((interface steamutils) &key (version T) steamworks)
  (setf (handle interface) (get-interface-handle steamworks 'steam::client-get-isteam-utils
                                                 (handle (pipe steamworks))
                                                 (t-or version STEAM::STEAMUTILS-INTERFACE-VERSION))))

(define-interface-method steamutils app-id (steam::utils-get-app-id))
(define-interface-method steamutils ipc-call-count (steam::utils-get-ipccall-count))
(define-interface-method steamutils country-code (steam::utils-get-ipcountry))
(define-interface-method steamutils uptime (steam::utils-get-seconds-since-app-active))
(define-interface-method steamutils idle-time (steam::utils-get-seconds-since-computer-active))
(define-interface-method steamutils server-real-time (steam::utils-get-server-real-time)
  (unix->universal result))
(define-interface-method steamutils big-picture-p (steam::utils-is-steam-in-big-picture-mode))
(define-interface-method steamutils virtual-reality-p (steam::utils-is-steam-running-in-vr))
(define-interface-method steamutils virtual-reality-streaming-p (steam::utils-is-vrheadset-streaming-enabled))
(define-interface-method steamutils start-virtual-reality-dashboard (steam::utils-start-vrdashboard))
(define-interface-method steamutils (setf virtual-reality-streaming-p) (value steam::utils-set-vrheadset-streaming-enabled))
(define-interface-method steamutils show-text-input
    (steam::utils-show-gamepad-text-input &key (mode :normal) (line-mode :single-line) (description "") (max 32) (default "")))
(define-interface-method steamutils show-floating-text-input
    (steam::utils-show-floating-gamepad-text-input &key (mode :mode-single-line) (x 0) (y 0) (w 500) (h 300)))
(define-interface-method steamutils hide-floating-text-input
    (steam::utils-dismiss-floating-gamepad-text-input))

(defmethod battery-power ((utils steamutils))
  (let ((res (steam::utils-get-current-battery-power (handle utils))))
    (if (= 255 res) (values) res)))

(defmethod input-text ((utils steamutils))
  (let ((length (steam::utils-get-entered-gamepad-text-length (handle utils))))
    (cffi:with-foreign-object (data :char length)
      (with-invalid-check NIL (steam::utils-get-entered-gamepad-text-input (handle utils) data length))
      (cffi:foreign-string-to-lisp data :count length :encoding :utf-8))))

(defmacro with-input-text ((text utils &rest args) &body body)
  (let ((utilsg (gensym "UTILS"))
        (struct (gensym "STRUCT"))
        (thunk (gensym "THUNK")))
    `(let ((,utilsg ,utils))
       (flet ((,thunk (,struct)
                (when (steam::gamepad-text-input-dismissed-submitted ,struct)
                  (let ((,text (input-text ,utils)))
                    ,@body))
                T))
         (make-instance 'closure-callback
                        :closure #',thunk
                        :struct-type 'steam::gamepad-text-input-dismissed)
         (show-text-input utils ,@args)))))

(defmethod (setf overlay-notification-location) ((value cons) (utils steamutils))
  (destructuring-bind (position x y) value
    (steam::utils-set-overlay-notification-position (handle utils) position)
    (steam::utils-set-overlay-notification-inset (handle utils) x y)
    value))

(defclass image (interface-object)
  ((width :reader width)
   (height :reader height)
   (rgba :reader rgba))
  (:default-initargs :interface 'steamutils))

(defmethod initialize-instance :after ((image image) &key handle)
  (cffi:with-foreign-objects ((width :uint32)
                              (height :uint32))
    (with-invalid-check NIL (steam::utils-get-image-size (iface* image) handle width height))
    (setf (slot-value image 'width) (cffi:mem-ref width :uint32))
    (setf (slot-value image 'height) (cffi:mem-ref height :uint32))))

(defmethod print-object ((image image) stream)
  (print-unreadable-object (image stream :type T)
    (format stream "~dx~d @~d" (width image) (height image) (handle image))))

;; Lazy load and cache
(defmethod rgba ((image image))
  (if (slot-boundp image 'rgba)
      (slot-value image 'rgba)
      (let* ((size (* 4 (width image) (height image)))
             (rgba (make-array size :element-type '(unsigned-byte 8))))
        (cffi:with-pointer-to-vector-data (data rgba)
          (with-invalid-check NIL (steam::utils-get-image-rgba (iface* image) (handle image) data size)))
        (setf (slot-value image 'rgba) rgba))))
