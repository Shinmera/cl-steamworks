(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamgameserver (interface)
  ((stats-handle :initarg :stats-handle :accessor stats-handle)))

(defmethod initialize-instance :after ((interface steamgameserver) &key (version T) (stats-version T) steamworks)
  (setf (handle interface) (get-interface-handle* steamworks 'steam::client-get-isteam-game-server
                                                  (t-or version STEAM::STEAMGAMESERVER-INTERFACE-VERSION)))
  (setf (stats-handle interface) (get-interface-handle* steamworks 'steam::client-get-isteam-game-server-stats
                                                        (t-or version STEAM::STEAMGAMESERVERSTATS-INTERFACE-VERSION))))

(define-interface-method steamgameserver logged-on-p (steam::game-server-blogged-on))
(define-interface-method steamgameserver secure-p (steam::game-server-bsecure))
(define-interface-method steamgameserver heartbeat (steam::game-server-force-heartbeat))
(define-interface-method steamgameserver public-ip (steam::game-server-get-public-ip)
  (int->ipv4 result))
(define-interface-method steamgameserver steam-id (steam::game-server-get-steam-id))
(define-interface-method steamgameserver logoff (steam::game-server-log-off))
(define-interface-method steamgameserver (setf bot-count) ((count integer) steam::game-server-set-bot-player-count))
(define-interface-method steamgameserver (setf max-player-count) ((count integer) steam::game-server-set-max-player-count))
(define-interface-method steamgameserver (setf password-protected) (protected steam::game-server-set-password-protected))
(define-interface-method steamgameserver (setf region) ((region string) steam::game-server-set-region))
(define-interface-method steamgameserver (setf spectator-port) ((port integer) steam::game-server-set-spectator-port))
(define-interface-method steamgameserver restart-requested-p (steam::game-server-was-restart-requested))

(defmethod logon ((gameserver steamgameserver) &key token dedicated)
  (steam::game-server-set-dedicated-server (handle gameserver) dedicated)
  (if token
      (steam::game-server-log-on (handle gameserver) token)
      (steam::game-server-log-on-anonymous (handle gameserver))))

(defmethod (setf key-value) ((value string) (gameserver steamgameserver) (key string))
  (steam::game-server-set-key-value (handle gameserver) key value)
  value)

(defmethod (setf key-value) ((value null) (gameserver steamgameserver) (key (eql T)))
  (steam::game-server-clear-all-key-values (handle gameserver))
  value)

(defmethod associate-with-clan ((clan clan) (gameserver steamgameserver))
  (with-call-result (result :poll T) (steam::game-server-associate-with-clan (handle gameserver) (handle clan))
    (check-result (steam::associate-with-clan-result result)
                  'steam::game-server-associate-with-clan)))

(defmethod compute-player-compatibility ((user friend) (gameserver steamgameserver))
  (with-call-result (result :poll T) (steam::game-server-compute-new-player-compatibility (handle gameserver) (steam-id user))
    (check-result (steam::associate-with-clan-result result)
                  'steam::game-server-compute-new-player-compatibility)))

(defmethod next-outgoing-packet ((gameserver steamgameserver))
  (cffi:with-foreign-objects ((buffer :uint8 (* 16 1024))
                              (ip :uint32)
                              (port :uint16))
    (let ((size (steam::game-server-get-next-outgoing-packet (handle gameserver) buffer (* 16 1024) ip port)))
      (values (cffi:foreign-array-to-lisp buffer (list :array :uint8 size) :element-type '(unsigned-byte 8))
              (int->ipv4 (cffi:mem-ref ip :uint32))
              (cffi:mem-ref port :uint16)))))

(defmethod handle-incoming-packet ((gameserver steamgameserver) packet ip port)
  (cffi:with-foreign-array (data packet :uint8)
    (steam::game-server-handle-incoming-packet (handle gameserver) data (length packet) (ipv4->int ip) port)))

(defmethod request-user-group-status ((user friend) (group friend-group) (gameserver steamgameserver))
  (steam::game-server-request-user-group-status (handle gameserver) (handle user) (handle group)))

(defmethod (setf game-data) ((value string) (gameserver steamgameserver))
  (check-utf8-size STEAM::MAX-GAME-SERVER-GAME-DATA value)
  (steam::game-server-set-game-data (handle gameserver) value)
  value)

(defmethod (setf game-data) ((value cons) (gameserver steamgameserver))
  (setf (game-data gameserver) (format NIL "~{~a~^,~}" value)))

(defmethod (setf game-description) ((value string) (gameserver steamgameserver))
  (check-utf8-size STEAM::MAX-GAME-SERVER-GAME-DESCRIPTION value)
  (steam::game-server-set-game-description (handle gameserver) value)
  value)

(defmethod (setf game-tags) ((value string) (gameserver steamgameserver))
  (check-utf8-size STEAM::MAX-GAME-SERVER-TAGS value)
  (steam::game-server-set-game-tags (handle gameserver) value)
  value)

(defmethod (setf game-tags) ((value cons) (gameserver steamgameserver))
  (setf (game-tags gameserver) (format NIL "~{~a~^,~}" value)))

(defmethod (setf map-name) ((value string) (gameserver steamgameserver))
  (check-utf8-size STEAM::MAX-GAME-SERVER-MAP-NAME value)
  (steam::game-server-set-map-name (handle gameserver) value)
  value)

(defmethod (setf heartbeat) ((value T) (gameserver steamgameserver))
  (steam::game-server-enable-heartbeats (handle gameserver) T))

(defmethod (setf heartbeat) ((value null) (gameserver steamgameserver))
  (steam::game-server-enable-heartbeats (handle gameserver) NIL))

(defmethod (setf heartbeat) ((value number) (gameserver steamgameserver))
  (if (= 0 value)
      (setf (heartbeat gameserver) NIL)
      (steam::game-server-set-heartbeat-interval (handle gameserver) (millisecs value))))

(defmethod (setf product) ((value integer) (gameserver steamgameserver))
  (steam::game-server-set-product (handle gameserver) (princ-to-string value)))

(defmethod (setf product) ((value app) (gameserver steamgameserver))
  (setf (product gameserver) (app-id value)))

(defmethod (setf product) ((value (eql T)) (gameserver steamgameserver))
  (setf (product gameserver) (app (interface 'steamapps gameserver))))

(defmethod (setf spectator-port) ((value null) (gameserver steamgameserver))
  (setf (spectator-port gameserver) 0))

(defmethod (setf spectator-server) ((value string) (gameserver steamgameserver))
  (check-utf8-size STEAM::MAX-GAME-SERVER-MAP-NAME value)
  (steam::game-server-set-spectator-server-name (handle gameserver) value)
  value)

(defmethod user-stats ((user friend) (gameserver steamgameserver) &key stats achievements)
  (with-call-result (result :poll T) (steam::game-server-stats-request-user-stats (stats-handle gameserver) (steam-id user))
    (check-result (steam::gsstats-received-result result)
                  'steam::game-server-stats-request-user-stats)
    (list :stats
          (cffi:with-foreign-object (data :int32)
            (loop for stat in stats
                  collect (destructuring-bind (name type) (enlist stat :int32)
                            (check-utf8-size STEAM::STAT-NAME-MAX name)
                            (ecase type
                              (:int32
                               (with-invalid-check NIL (steam::game-server-stats-get-user-stat (stats-handle gameserver) (steam-id user) name data))
                               (cons name (cffi:mem-ref data :int32)))
                              (:float
                               (with-invalid-check NIL (steam::game-server-stats-get-user-stat0 (stats-handle gameserver) (steam-id user) name data))
                               (cons name (cffi:mem-ref data :float)))))))
          :achievements
          (cffi:with-foreign-object (data :bool)
            (loop for achievement in achievements
                  do (with-invalid-check NIL (steam::game-server-stats-get-user-achievement (stats-handle gameserver) (steam-id user) achievement data))
                  collect (cons achievement (cffi:mem-ref data :bool)))))))

(defmethod (setf user-stats) ((value cons) (user friend) (gameserver steamgameserver) &key sync)
  (with-call-result (result :poll T)  (steam::game-server-stats-request-user-stats (stats-handle gameserver) (steam-id user))
    (check-result (steam::gsstats-received-result result)
                  'steam::game-server-stats-request-user-stats)
    (destructuring-bind (&key stats achievements avgrates) value
      (loop for (stat . value) in stats
            do (check-invalid NIL (etypecase value
                                    (integer
                                     (steam::game-server-stats-set-user-stat (stats-handle gameserver) (steam-id user) stat value))
                                    (float
                                     (steam::game-server-stats-set-user-stat0 (stats-handle gameserver) (steam-id user) stat (coerce value 'single-float))))
                              'steam::game-server-stats-set-user-stat))
      (loop for (achievement . value) in achievements
            do (check-invalid NIL (if value
                                      (steam::game-server-stats-set-user-achievement (stats-handle gameserver) (steam-id user) achievement)
                                      (steam::game-server-stats-clear-user-achievement (stats-handle gameserver) (steam-id user) achievement))
                              'steam::game-server-stats-set-user-achievement))
      (loop for (avgrate count length) in avgrates
            do (with-invalid-check NIL (steam::game-server-stats-update-user-avg-rate-stat (stats-handle gameserver) (steam-id user) avgrate count length)))))
  (when sync
    (loop for i from 0 below 10
          do (with-call-result (result :poll T) (steam::game-server-stats-store-user-stats (stats-handle gameserver) (steam-id user))
               (when (eq :ok (steam::gsstats-stored-result result))
                 (return)))
             (sleep 0.1)
          finally (error 'api-call-failed :api-call 'steam::game-server-stats-store-user-stats)))
  value)

(defmethod make-session-ticket ((interface steamgameserver))
  (make-instance 'server-session-ticket :interface interface))

(defclass server-session-ticket (session-ticket)
  ()
  (:default-initargs :interface 'steamgameserver))

(defmethod allocate-handle ((ticket server-session-ticket) &key)
  (cffi:with-foreign-objects ((buffer :uchar 1024)
                              (length :uint32))
    (prog1 (steam::game-server-get-auth-session-ticket (iface* ticket) buffer 1024 length)
      (setf (slot-value ticket 'payload) (cffi:foreign-array-to-lisp buffer (list :array :uchar (cffi:mem-ref length :uint32)))))))

(defmethod free-handle-function ((ticket server-session-ticket) handle)
  (let ((interface (iface* ticket)))
    (lambda () (steam::game-server-cancel-auth-ticket interface handle))))

(defmethod begin-session ((interface steamgameserver) (ticket-payload vector) user)
  (make-instance 'server-auth-session :interface interface :ticket-payload ticket-payload :user user))

(defclass server-auth-session (auth-session)
  ()
  (:default-initargs :interface 'steamgameserver))

(defmethod allocate-handle ((session server-auth-session) &key ticket-payload user)
  (check-type ticket-payload (vector (unsigned-byte 8)))
  (let ((handle (etypecase user
                  (integer user)
                  (friend (steam-id user)))))
    (cffi:with-pointer-to-vector-data (buffer ticket-payload)
      (with-valid-check :ok (steam::game-server-begin-auth-session (iface* session) buffer (length ticket-payload) handle)))
    handle))

(defmethod free-handle-function ((session server-auth-session) handle)
  (let ((interface (iface* session)))
    (lambda () (steam::game-server-end-auth-session interface handle))))
