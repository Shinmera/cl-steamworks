#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass steammatchmaking (interface)
  ())

(defmethod initialize-instance :after ((interface steammatchmaking) &key version steamworks)
  (setf (handle interface) (get-interface-handle* steamworks 'steam::client-get-isteam-inventory
                                                  (t-or version steam::steammatchmaking-interface-version))))

(defmethod add-favorite-game ((interface steammatchmaking) (app app) (ip string) (connection-port integer) (query-port integer) &optional (list :favorite))
  (steam::matchmaking-add-favorite-game (handle interface) (app-id app) (ipv4->int ip) connection-port query-port
                                        (ecase list
                                          (:favorite 1)
                                          (:history 2)
                                          (:none 0))
                                        (universal->unix (get-universal-time))))

(defmethod remove-favorite-game ((interface steammatchmaking) (app app) (ip string) (connection-port integer) (query-port integer) &optional (list :favorite))
  (steam::matchmaking-remove-favorite-game (handle interface) (app-id app) (ipv4->int ip) connection-port query-port
                                           (ecase list
                                             (:favorite 1)
                                             (:history 2)
                                             (:none 0))))

(defmethod favorite-games ((interface steammatchmaking))
  (let ((count (steam::matchmaking-get-favorite-game-count (handle interface))))
    (cffi:with-foreign-objects ((app 'steam::app-id-t)
                                (ip :uint32)
                                (connection-port :uint16)
                                (query-port :uint16)
                                (flags :uint32)
                                (last-played :uint32))
      (loop for i from 0 below count
            do (unless (steam::matchmaking-get-favorite-game (handle interface) i app ip connection-port query-port flags last-played)
                 (error "FIXME: failed"))
            collect (listp (make-instance 'app :interface (interface 'steamapps interface)
                                               :handle (cffi:mem-ref app 'steam::app-id-t))
                           (int->ipv4 (cffi:mem-ref ip :uint32))
                           (cffi:mem-ref connection-port :uint16)
                           (cffi:mem-ref query-port :uint16)
                           (case (cffi:mem-ref flags :uint32)
                             (1 :favorite)
                             (2 :history)
                             (0 :none))
                           (unix->universal (cffi:mem-ref last-played :uint32)))))))

(defmethod (setf favorite-games) ((after cons) (interface steammatchmaking))
  (flet ((trim-to-size (el)
           (let ((cons (nthcdr 4 el)))
             (if cons
                 (setf (cdr cons) NIL)
                 (setf (cdr (last el)) (list :favorite))))))
    (let ((before (mapcar #'trim-to-size (favorite-games interface)))
          (after (mapcar #'trim-to-size after))
          (to-add (set-difference after before))
          (to-remove (set-difference before after)))
      (dolist (item to-add)
        (apply #'add-favorite-game interface item))
      (dolist (item to-remove)
        (apply #'remove-favorite-game interface item))
      after)))

(defmethod request-lobby-list ((interface steammatchmaking) &key poll distance available-slots sort max-count filter)
  (when distance
    (steam::matchmaking-add-request-lobby-list-distance-filter (handle interface) distance))
  (when available-slots
    (steam::matchmaking-add-request-lobby-list-filter-slots-available (handle interface) available-slots))
  (loop for (key value) in sort
        do (steam::matchmaking-add-request-lobby-list-near-value-filter (handle interface) key value))
  (when max-count
    (steam::matchmaking-add-request-lobby-list-result-count-filter (handle interface) max-count))
  (loop for (key value comparator) in filter
        do (etypecase value
             (integer (steam::matchmaking-add-request-lobby-list-numerical-filter (handle interface) key value comparator))
             (string (steam::matchmaking-add-request-lobby-list-string-filter (handle interface) key value comparator))))
  (with-call-result (result :poll poll) (steam::matchmaking-request-lobby-list (handle interface))
    (let ((count (steam::lobby-match-list-lobbies-matching result)))
      (loop for i from 0 below count
            for handle = (steam::matchmaking-get-lobby-by-index (handle interface) i)
            collect (make-instance 'lobby :interface interface :handle handle)))))

(defclass lobby (interface-object)
  ()
  (:default-initargs :interface 'steammatchmaking))

(defmethod initialize-instance :after ((lobby lobby) &key type max-members)
  (unless (handle lobby)
    (assert (<= 0 max-members 250) (max-members))
    (with-call-result (result :poll T) (steam::matchmaking-create-lobby (iface lobby) type max-members)
      (with-error-on-failure (steam::lobby-created-result result))
      (setf (handle lobby) (steam::lobby-created-steam-idlobby result)))))

(defmethod steam-id ((lobby lobby))
  (handle lobby))

(define-interface-submethod lobby data (steam::matchmaking-get-lobby-data (key string))
  (check-empty-string result))
(define-interface-submethod lobby member-limit (steam::matchmaking-get-lobby-member-limit))
(define-interface-submethod lobby (setf member-limit) ((max integer) steam::matchmaking-set-lobby-member-limit)
  (unless result (error "FIXME: failed")))
(define-interface-submethod lobby owner (steam::matchmaking-get-lobby-owner)
  (make-instance 'friend :handle result :interface (interface 'steamfriends lobby)))
(define-interface-submethod lobby member-count (steam::matchmaking-get-num-lobby-members))
(define-interface-submethod lobby leave (steam::matchmaking-leave-lobby))
(define-interface-submethod lobby refresh (steam::matchmaking-request-lobby-data)
  (unless result (error "FIXME: failed")))
(define-interface-submethod lobby (setf joinable) (value steam::matchmaking-set-lobby-joinable)
  (unless result (error "FIXME: failed")))
(define-interface-submethod lobby (setf lobby-type) (value steam::matchmaking-set-lobby-type)
  (unless result (error "FIXME: failed")))

(defmethod join ((lobby lobby))
  (with-call-result (result :poll T) (steam::matchmaking-join-lobby (iface lobby) (handle lobby))
    (unless (= 1 (steam::lobby-enter-echat-room-enter-response result))
      (error "FIXME: failed"))))

(defmethod invite ((friend friend) (lobby lobby))
  (unless (steam::matchmaking-invite-user-to-lobby (iface* lobby) (handle lobby) (handle friend))
    (error "FIXME: failed")))

(defmethod (setf data) ((value null) (lobby lobby) (key string))
  (unless (steam::matchmaking-delete-lobby-data (iface* lobby) (handle lobby) key)
    (error "FIXME: failed")))

(defmethod (setf data) ((value string) (lobby lobby) (key string))
  (check-utf8-size 255 key)
  (check-utf8-size 8192 value)
  (unless (steam::matchmaking-set-lobby-data (iface* lobby) (handle lobby) key value)
    (error "FIXME: failed")))

(defmethod list-data ((lobby lobby))
  (let ((count (steam::matchmaking-get-lobby-data-count (iface* lobby) (handle lobby))))
    (cffi:with-foreign-objects ((key :uchar 255)
                                (value :uchar 8192))
      (loop for i from 0 below count
            collect (cons (cffi:foreign-string-to-lisp key :encoding :utf-8)
                          (cffi:foreign-string-to-lisp value :encoding :utf-8))))))
8192
(defmethod member-data ((member friend) (lobby lobby) (key string))
  (check-empty-string (steam::matchmaking-get-lobby-member-data (iface* lobby) (handle lobby) (steam-id user) key)))

(defmethod (setf member-data) ((value string) (member friend) (lobby lobby) (key string))
  (unless (= (steam-id member) (steam-id (interface 'steamuser member)))
    (error "FIXME: cannot set member data for others"))
  (steam::matchmaking-set-lobby-member-data (iface* lobby) (handle lobby))
  value)

(defmethod chat-entry ((index integer) (lobby lobby))
  (cffi:with-foreign-objects ((user 'steam::steam-id)
                              (buffer :uchar 4096))
    (let ((count (steam::matchmaking-get-lobby-chat-entry (iface* lobby) (handle lobby) index user buffer 4096 (cffi:null-pointer))))
      (values (cffi:foreign-string-to-lisp buffer :count count :encoding :utf-8)
              (make-instance 'friend :handle (cffi:mem-ref user 'steam::steam-id)
                                     :interface (interface 'steamfriends lobby))))))

(defmethod server-details ((lobby lobby))
  (cffi:with-foreign-objects ((ip :uint32)
                              (port :uint16)
                              (id 'steam::steam-id))
    (unless (steam::matchmaking-get-lobby-game-server (iface* lobby) (handle lobby) ip port id)
      (error "FIXME: failed"))
    (list (int->ipv4 (cffi:mem-ref ip :uint32))
          (cffi:mem-ref port :uint16)
          (cffi:mem-ref id 'steam::steam-id))))

(defmethod (setf server-details) ((value list) (lobby lobby))
  (destructuring-bind (ip port &optional (id 0)) value
    (steam::matchmaking-set-lobby-game-server (iface* lobby) (handle lobby) (ipv4->int ip) port id)
    value))

(defmethod list-members ((lobby lobby))
  (let ((count (steam::matchmaking-get-num-lobby-members (iface* lobby) (handle lobby))))
    (loop for i from 0 below count
          for handle = (steam::matchmaking-get-lobby-member-by-index (iface* lobby) (handle lobby) i)
          collect (make-instance 'friend :handle handle :interface (interface 'steamfriends lobby)))))

(defmethod send-message ((message string) (lobby lobby))
  (cffi:with-foreign-string ((buffer size) message :encoding :utf-8)
    (when (< 4096 size) (error "FIXME: message too long"))
    (unless (steam::matchmaking-send-lobby-chat-msg (iface* lobby) (handle lobby) buffer size)
      (error "FIXME: failed"))))

(defmethod (setf owner) ((friend friend) (lobby lobby))
  (unless (steam::matchmaking-set-lobby-owner (iface* lobby) (handle lobby) (handle friend))
    (error "FIXME: failed"))
  friend)
