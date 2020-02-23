#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamvideo (interface)
  ())

(defmethod initialize-instance :after ((interface steamvideo) &key (version T) steamworks)
  (setf (handle interface) (get-interface-handle steamworks 'steam::client-get-isteam-video
                                                 (handle (user steamworks)) (handle (pipe steamworks))
                                                 (t-or version STEAM::STEAMVIDEO-INTERFACE-VERSION))))

(define-interface-method steamvideo request-opf-settings (steam::video-get-opfsettings id))
(define-interface-method steamvideo request-video-url (steam::video-get-video-url id))

(defmethod viewer-count ((video steamvideo))
  (cffi:with-foreign-object (count :int)
    (if (steam::video-is-broadcasting (handle video) count)
        (cffi:mem-ref count :int)
        0)))

(defmethod opf-string ((video steamvideo) id)
  (cffi:with-foreign-object (size :int32)
    (setf (cffi:mem-ref size :int32) 0)
    (steam::video-get-opfstring-for-app (handle video) id (cffi:null-pointer) size)
    (cffi:with-foreign-object (buffer :char (cffi:mem-ref size :int32))
      (with-invalid-check NIL (steam::video-get-opfstring-for-app (handle video) id buffer size)))))
