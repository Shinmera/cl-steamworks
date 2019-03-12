#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamuser (interface)
  ())

(defmethod initialize-instance :after ((interface steamuser) &key version steamworks)
  (setf (handle interface) (get-interface-handle steamworks 'steam::client-get-isteam-user
                                                 (handle (user steamworks)) (handle (pipe steamworks)) version)))

(defmethod advertise-game (user server (ip string) port)
  (advertise-game user server (ipv4->int ip) port))

(define-interface-method steamuser advertise-game (steam::user-advertise-game server (ip integer) (port integer)))
(define-interface-method steamuser behind-nat-p (steam::user-bis-behind-nat))
(define-interface-method steamuser phone-identified-p (steam::user-bis-phone-identifying))
(define-interface-method steamuser phone-verification-needed-p (steam::user-bis-phone-requiring-verification))
(define-interface-method steamuser phone-verified-p (steam::user-bis-phone-verified))
(define-interface-method steamuser two-factor-p (steam::user-bis-two-factor-enabled))
(define-interface-method steamuser logged-on-p (steam::user-blogged-on))
(define-interface-method steamuser badge-level (steam::user-get-game-badge-level &key (series 1) foil))
(define-interface-method steamuser steam-level (steam::user-get-player-steam-level))
(define-interface-method steamuser steam-id (steam::user-get-steam-id))
(define-interface-method steamuser optimal-voice-sample-rate (steam::user-get-voice-optimal-sample-rate))
(define-interface-method steamuser make-store-url (steam::user-request-store-auth-url landing-page))
(define-interface-method steamuser start-voice-recording (steam::user-start-voice-recording))
(define-interface-method steamuser stop-voice-recording (steam::user-stop-voice-recording))

;; FIXME: Token mechanism

;; Internal static buffer for compressed voice data
(#-sbcl defvar #+sbcl sb-ext:defglobal compressed-voice-buffer
        (make-array (* 1024 8) :element-type '(unsigned-byte 8)))

(defmethod voice ((user steamuser) destination samplerate)
  (cffi:with-pointer-to-vector-data (dest destination)
    (cffi:with-pointer-to-vector-data (buffer COMPRESSED-VOICE-BUFFER)
      (cffi:with-foreign-objects ((compressed-written :uint32)
                                  (destination-written :uint32))
        (let ((result (steam::user-get-voice (handle user) NIL buffer (* 1024 8) compressed-written
                                             NIL (cffi:null-pointer) 0 (cffi:null-pointer) 0)))
          (case result
            (:ok
             (steam::user-decompress-voice (handle user) buffer (cffi:mem-ref compressed-written :uint32)
                                           dest (length destination) destination-written samplerate)
             (cffi:mem-ref destination-written))
            (:no-data
             0)
            (:data-corrupted
             (warn "FIXME: corrupted voice data.")
             0)
            (T
             (error "FIXME: failed to get voice data: ~a" result))))))))
