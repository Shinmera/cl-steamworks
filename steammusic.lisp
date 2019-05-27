#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass steammusic (interface)
  ())

(defmethod initialize-instance :after ((interface steammusic) &key version steamworks)
  (setf (handle interface) (get-interface-handle* steamworks 'steam::client-get-isteam-music
                                                  (t-or version STEAM::STEAMMUSIC-INTERFACE-VERSION))))

(define-interface-method steammusic enabled-p (steam::music-bis-enabled))
(define-interface-method steammusic playing-p (steam::music-bis-playing))
(define-interface-method steammusic status (steam::music-get-playback-status))
(define-interface-method steammusic volume (steam::music-get-volume))
(define-interface-method steammusic play (steam::music-play))
(define-interface-method steammusic play-next (steam::music-play-next))
(define-interface-method steammusic play-previous (steam::music-play-previous))
(define-interface-method steammusic (setf volume) ((value float) steam::music-set-volume))
