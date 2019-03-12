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

(define-interface-method steamuser advertise-game (steam::user-advertise-game server (ip integer) (port integer)))

(defmethod advertise-game (user server (ip string) port)
  (advertise-game user server (ipv4->int ip) port))

(define-interface-method steamuser behind-nat-p (steam::user-bis-behind-nat))
(define-interface-method steamuser phone-identified-p (steam::user-bis-phone-identifying))
(define-interface-method steamuser phone-verification-needed-p (steam::user-bis-phone-requiring-verification))
(define-interface-method steamuser phone-verified-p (steam::user-bis-phone-verified))
(define-interface-method steamuser two-factor-p (steam::user-bis-two-factor-enabled))
(define-interface-method steamuser logged-on-p (steam::user-blogged-on))
