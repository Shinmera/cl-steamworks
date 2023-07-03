(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamuser (interface)
  ())

(defmethod initialize-instance :after ((interface steamuser) &key (version T) steamworks)
  (setf (handle interface) (get-interface-handle* steamworks 'steam::client-get-isteam-user
                                                 (t-or version steam::steamuser-interface-version))))

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

(define-self-method steamuser steam-id)
(define-self-method steamuser logged-on-p)

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
             (cffi:mem-ref destination-written :uint32))
            (:no-data
             0)
            (:data-corrupted
             (warn 'voice-data-corrupted)
             0)
            (T
             (error 'api-call-failed :api-call 'steam::user-get-voice
                                     :error-code result))))))))

(defmethod make-session-ticket ((interface steamuser))
  (make-instance 'session-ticket :interface interface))

(defclass session-ticket (c-managed-object interface-object)
  ((payload :reader payload))
  (:default-initargs :interface 'steamuser
                     :free-on-gc T))

(defmethod allocate-handle ((ticket session-ticket) &key)
  (cffi:with-foreign-objects ((buffer :uchar 1024)
                              (length :uint32))
    (prog1 (steam::user-get-auth-session-ticket (iface* ticket) buffer 1024 length)
      (setf (slot-value ticket 'payload) (cffi:foreign-array-to-lisp buffer (list :array :uchar (cffi:mem-ref length :uint32)))))))

(defmethod free-handle-function ((ticket session-ticket) handle)
  (let ((interface (iface* ticket)))
    (lambda () (steam::user-cancel-auth-ticket interface handle))))

(defmethod begin-session ((interface steamuser) (ticket-payload vector) user)
  (make-instance 'auth-session :interface interface :ticket-payload ticket-payload :user user))

(defclass auth-session (c-managed-object interface-object)
  ()
  (:default-initargs :interface 'steamuser
                     :free-on-gc T))

(defmethod allocate-handle ((session auth-session) &key ticket-payload user)
  (check-type ticket-payload (vector (unsigned-byte 8)))
  (let ((handle (etypecase user
                  (integer user)
                  (friend (steam-id user)))))
    (cffi:with-pointer-to-vector-data (buffer ticket-payload)
      (with-valid-check :ok (steam::user-begin-auth-session (iface* session) buffer (length ticket-payload) handle)))
    handle))

(defmethod free-handle-function ((session auth-session) handle)
  (let ((interface (iface* session)))
    (lambda () (steam::user-end-auth-session interface handle))))

(defmethod user ((session auth-session))
  (ensure-iface-obj 'friend :handle (handle session) :interface (interface 'steamfriends session)))

(defmethod make-encrypted-app-ticket ((interface steamuser) &key data)
  (let ((buffer (cffi:null-pointer))
        (bufsize 0))
    (etypecase data
      (null)
      (string
       (multiple-value-bind (b bs) (cffi:foreign-string-alloc data)
         (setf buffer b bufsize bs)))
      ((vector (unsigned-byte 8))
       (multiple-value-bind (b bs) (cffi:foreign-array-alloc data :uint8)
         (setf buffer b bufsize bs))))
    (unwind-protect
         (with-call-result (result :poll T) (steam::user-request-encrypted-app-ticket (handle interface) buffer bufsize)
           (if (eql :ok (steam::encrypted-app-ticket-result result))
               (cffi:with-foreign-objects ((ticket :uint8 1024)
                                           (bytes :uint32))
                 (if (steam::user-get-encrypted-app-ticket (handle interface) ticket 1024 bytes)
                     (cffi:foreign-array-to-lisp ticket (list :array :uint8 (cffi:mem-ref bytes :uint32)) :element-type '(unsigned-byte 8))))
               (error "Failed to get new encrypted app ticket: ~a"
                      (steam::encrypted-app-ticket-result result))))
      (unless (cffi:null-pointer-p buffer)
        (cffi:foreign-free buffer)))))
