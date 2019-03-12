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

(defmethod app-id ((utils steamutils))
  (steam::utils-get-app-id (handle utils)))

(defmethod ipc-call-count ((utils steamutils))
  (steam::utils-get-ipccall-count (handle utils)))

(defmethod battery-power ((utils steamutils))
  (let ((res (steam::utils-get-current-battery-power (handle utils))))
    (if (= 255 res) :ac res)))

(defmethod country-code ((utils steamutils))
  (steam::utils-get-ipcountry (handle utils)))

(defmethod uptime ((utils steamutils))
  (steam::utils-get-seconds-since-app-active (handle utils)))

(defmethod idle-time ((utils steamutils))
  (steam::utils-get-seconds-since-computer-active (handle utils)))

(defmethod server-real-time ((utils steamutils))
  (steam::utils-get-server-real-time (handle utils)))

(defmethod big-picture-p ((utils steamutils))
  (steam::utils-is-steam-in-big-picture-mode (handle utils)))

(defmethod virtual-reality-p ((utils steamutils))
  (steam::utils-is-steam-running-in-vr (handle utils)))

(defmethod virtual-reality-streaming-p ((utils steamutils))
  (steam::utils-is-vrheadset-streaming-enabled (handle utils)))

(defmethod (setf virtual-reality-streaming-p) (value (utils steamutils))
  (steam::utils-set-vrheadset-streaming-enabled (handle utils) value))

(defmethod show-text-input ((utils steamutils) &key (mode :normal) (line-mode :single-line) (description "") (max 32) (default ""))
  (steam::utils-show-gamepad-text-input (handle utils) mode line-mode description max default))

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
                (when (steam::gamepad-text-input-dismissed-submitted ,struct)
                  (let ((,text (input-text ,utils)))
                    ,@body))))
         (make-instance 'closure-callback
                        :closure #',thunk
                        :struct-type 'steam::gamepad-text-input-dismissed-t)))))

(defmethod start-virtual-reality-dashboard ((utils steamutils))
  (steam::utils-start-vrdashboard (handle utils)))

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
