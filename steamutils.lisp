#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamutils (interface)
  ())

(defmethod initialize-instance :after ((interface steamutils) &key version steamworks)
  (setf (handle interface) (get-interface-handle steamworks 'steam::client-get-isteam-utils
                                                 (handle (pipe steamworks)) version)))

(define-interface-method steamutils app-id (steam::utils-get-app-id))
(define-interface-method steamutils ipc-call-count (steam::utils-get-ipccall-count))
(define-interface-method steamutils country-code (steam::utils-get-ipcountry))
(define-interface-method steamutils uptime (steam::utils-get-seconds-since-app-active))
(define-interface-method steamutils idle-time (steam::utils-get-seconds-since-computer-active))
(define-interface-method steamutils server-real-time (steam::utils-get-server-real-time))
(define-interface-method steamutils big-picture-p (steam::utils-is-steam-in-big-picture-mode))
(define-interface-method steamutils virtual-reality-p (steam::utils-is-steam-running-in-vr))
(define-interface-method steamutils virtual-reality-streaming-p (steam::utils-is-vrheadset-streaming-enabled))
(define-interface-method steamutils start-virtual-reality-dashboard (steam::utils-start-vrdashboard))
(define-interface-method steamutils (setf virtual-reality-streaming-p) (value steam::utils-set-vrheadset-streaming-enabled))
(define-interface-method steamutils show-text-input
    (steam::utils-show-gamepad-text-input &key (mode :normal) (line-mode :single-line) (description "") (max 32) (default "")))

(defmethod battery-power ((utils steamutils))
  (let ((res (steam::utils-get-current-battery-power (handle utils))))
    (if (= 255 res) (values) res)))

(defmethod input-text ((utils steamutils))
  (let ((length (steam::utils-get-entered-gamepad-text-length (handle utils))))
    (cffi:with-foreign-object (data :char length)
      (unless (steam::utils-get-entered-gamepad-text-input (handle utils) data length)
        (error "FIXME: failed to retrieve entered text. Was there any text to receive and are you in the callback?"))
      (cffi:foreign-string-to-lisp data :count length :encoding :utf-8))))

(defmacro with-input-text ((text utils &rest args) &body body)
  (let ((utilsg (gensym "UTILS"))
        (struct (gensym "STRUCT")))
    `(let ((,utilsg ,utils))
       (flet ((,thunk (,struct)
                (when (steam::gamepad-text-input-dismissed-t-submitted ,struct)
                  (let ((,text (input-text ,utils)))
                    ,@body))))
         (make-instance 'closure-callback
                        :closure #',thunk
                        :struct-type 'steam::gamepad-text-input-dismissed-t)))))

(defmethod (setf overlay-notification-location) ((value cons) (utils steamutils))
  (destructuring-bind (position x y) value
    (steam::utils-set-overlay-notification-position (handle utils) position)
    (steam::utils-set-overlay-notification-inset (handle utils) x y)
    value))

(defclass image (c-object)
  ((width :reader width)
   (height :reader height)
   (rgba :reader rgba)))

(defmethod initialize-instance :after ((image image) &key steamutils handle)
  (cffi:with-foreign-objects ((width :uint32)
                              (height :uint32))
    (unless (steam::utils-get-image-size (handle utils) handle)
      (error "FIXME: not a valid image handle."))
    (setf (slot-value image 'width) (cffi:mem-ref width :uint32))
    (setf (slot-value image 'height) (cffi:mem-ref height :uint32))
    (let ((size (* 4 (cffi:mem-ref width :uint32) (cffi:mem-ref height :uint32)))
          (rgba (make-array size :element-type '(unsigned-byte 8))))
      (cffi:with-pointer-to-vector-data (data rgba)
        (unless (steam::utils-get-image-rgba (handle utils) handle data size)
          (error "FIXME: failed to receive image data.")))
      (setf (slot-value image 'rgba) rgba))))
