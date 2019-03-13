#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamfriends (interface)
  ())

(defmethod initialize-instance :after ((interface steamfriends) &key version steamworks)
  (setf (handle interface) (get-interface-handle steamworks 'steam::client-get-isteam-friends
                                                 (handle (user steamworks)) (handle (pipe steamworks)) version)))

(define-interface-method steamfriends clear-rich-presence (steam::friends-clear-rich-presence))
(define-interface-method steamfriends close-clan-chat-window (steam::friends-close-clan-chat-window-in-steam chat-id))
(define-interface-method steamfriends display-name (steam::friends-get-persona-name))
(define-interface-method steamfriends state (steam::friends-get-persona-state))
(define-interface-method steamfriends (setf display-name) (name steam::friends-set-persona-name))

(defmethod restricted-p ((friends steamfriends))
  (< 0 (steam::friends-get-user-restrictions (handle friends))))

(defmethod activate-overlay ((friends steamfriends) &key (dialog :friends) user lobby app url)
  (let ((type (ecase dialog
                (:friends "friends")
                (:community "community")
                (:players "players")
                (:settings "settings")
                (:game-group "officialgamegroup")
                (:stats "stats")
                (:achievements "achievements"))))
    (when (< 1 (+ (if user 1 0) (if lobby 1 0) (if app 1 0) (if url 1 0)))
      (error "FIXME: Can't display more than one dialog at the same time."))
    (cond (lobby
           (steam::friends-activate-game-overlay-invite-dialog (handle friends) lobby))
          (app
           (steam::friends-activate-game-overlay-to-store (handle friends) app :none))
          (user
           (steam::friends-activate-game-overlay-to-user (handle friends) dialog user))
          (url
           (steam::friends-activate-game-overlay-to-web-page (handle friends) url :default))
          (T
           (steam::friends-activate-game-overlay (handle friends) dialog)))))

(defmethod clan ((friends steamfriends) (index integer))
  (make-instance 'clan :steamfriends friends :index index))

(defmethod list-clans ((friends steamfriends))
  (loop for i from 0 below (steam::friends-get-clan-count (handle friends))
        collect (clan friends i)))

(defmethod follower-count ((friends steamfriends) (user integer))
  (with-call-result (result :poll T) (steam::friends-get-follower-count (handle friends) user)
    (with-error-on-failure (steam::friends-get-follower-count-t-result result))
    (steam::friends-get-follower-count-t-count result)))

(defmethod list-friend-groups ((friends steamfriends))
  (loop for i from 0 below (steam::friends-get-friends-group-count (handle friends))
        collect (make-instance 'friend-group :steamfriends friends :index i)))

(defmethod list-friends ((friends steamfriends) &key flags source coplay)
  (cond (source
         (let ((source (handle source)))
           (loop for i from 0 below (steam::friends-get-friend-count-from-source (handle friends) source)
                 collect (make-instance 'friend :steamfriends friends :source source :index i))))
        (coplay
         (loop for i from 0 below (steam::friends-get-coplay-friend-count (handle friends))
               collect (make-instance 'friend :steamfriends friends :coplay T :index i)))
        (T
         (let ((flags (apply #'flags 'steam::efriend-flags flags)))
           (loop for i from 0 below (steam::friends-get-friend-count (handle friends) flags)
                 collect (make-instance 'friend :steamfriends friends :flags flags :index i))))))

(defmethod (setf rich-presence) (value (friends steamfriends) key)
  (let ((key (case key
               (:status "status")
               (:connect "connect")
               (:display "steam_display")
               (:group "steam_player_group")
               (:group-size "steam_player_group_size")
               (T (let ((*print-case* :downcase))
                    (princ-to-string key)))))
        (value (let ((*print-case* :downcase))
                 (pring-to-string value))))
    (when (< steam::max-rich-presence-key-length (length key))
      (error "FIXME: key too long"))
    (when (< steam::max-rich-presence-value-length (length value))
      (error "FIXME: value too long"))
    (unless (steam::friends-set-rich-presence (handle friends) key value)
      (error "FIXME: failed to set the rich presence.")))
  value)

(defclass friend (c-object)
  ((steamfriends :initarg :steamfriends :reader steamfriends)))

(defmethod initialize-instance :after ((friend friend) &key steamfriends index flags source coplay)
  (cond (source
         (setf (handle friend) (steam::friends-get-friend-from-source-by-index (handle steamfriends) source index)))
        (flags
         (setf (handle friend) (steam::friends-get-friend-by-index (handle steamfriends) index flags)))
        (coplay
         (setf (handle friend) (steam::friends-get-coplay-friend (handle friends) index))))
  (steam::friends-request-user-information (handle steamfriends) (handle friend) T))

;; FIXME: game representation
(define-interface-submethod steamfriends friend coplay-game (steam::friends-get-friend-coplay-game))
(define-interface-submethod steamfriends friend coplay-time (steam::friends-get-friend-coplay-time)
  (unix->universal result))
(define-interface-submethod steamfriends friend state (steam::friends-get-friend-persona-state))
(define-interface-submethod steamfriends friend relationship (steam::friends-get-friend-relationship))
(define-interface-submethod steamfriends friend rich-presence (steam::friends-get-friend-rich-presence key))
(define-interface-submethod steamfriends friend steam-level (steam::friends-get-friend-steam-level))
(define-interface-submethod steamfriends friend following-p (steam::friends-is-following))
(define-interface-submethod steamfriends friend in-source-p (steam::friends-is-user-in-source (source integer)))
(define-interface-submethod steamfriends friend send-message ((message string) steam::friends-reply-to-friend-message))
(define-interface-submethod steamfriends friend request-rich-presence (steam::friends-request-friend-rich-presence))

(defmethod in-source-p ((friend friend) (source c-object))
  (in-source-p friend (handle source)))

(defmethod rich-presence ((friend friend) (all (eql T)))
  (loop for i from 0 below (steam::friends-get-friend-rich-presence-key-count (handle (steamfriends friend)) (handle friend))
        for key = (steam::friends-get-friend-rich-presence-key-by-index (handle (steamfriends friend)) (handle friend) i)
        collect (cons key (rich-presence friend key))))

(defmethod display-name ((friend friend))
  (let ((name (steam::friends-get-friend-persona-name (handle (steamfriends friend)) (handle friend))))
    (when (and (string/= name "")
               (string/= name "[unknown]"))
      name)))

(defmethod nickname ((friend friend))
  (let ((name (steam::friends-get-player-nickname (handle (steamfriends friend)) (handle friend))))
    (when (and name (string/= name "")) name)))

(defmethod display-name-history ((friend friend))
  (loop for i from 0
        for name = (steam::friends-get-friend-persona-name-history (handle (steamfriends friend)) (handle friend) i)
        while (string/= name "")
        collect name))

(defmethod current-game ((friend friend))
  (cffi:with-foreign-object (info '(:struct steam::friend-game-info-t))
    (when (steam::friends-get-friend-game-played (handle (steamfriends friend)) (handle friend) info)
      info)))

(defmethod avatar ((friend friend) &key (size :medium) callback)
  (flet ((make-image (handle)
           (unless (= 0 handle)
             (make-instance 'image :steamutils (interface 'steamutils (steamworks (steamfriends friend)))
                                   :handle handle))))
    (ecase size
      (:small (make-image (steam::friends-get-small-friend-avatar (handle (steamfriends friend)) (handle friend))))
      (:medium (make-image (steam::friends-get-medium-friend-avatar (handle (steamfriends friend)) (handle friend))))
      (:large
       (unless callback (error "CALLBACK required for large avatar requests."))
       (let ((handle (steam::friends-get-large-friend-avatar (handle (steamfriends friend)) (handle friend))))
         (flet ((thunk (parameter)
                  (when (and parameter (= (handle friend) (steam::avatar-image-loaded-t-id parameter)))
                    (funcall callback (make-image (steam::avatar-image-loaded-t-image parameter)))
                    T)))
           (if (/= -1 handle)
               (funcall callback (make-image handle))
               (make-instance 'closure-callback
                              :closure #'thunk
                              :struct-type 'steam::avatar-image-loaded-t))))))))

(defmethod kind-p ((friend friend) flags)
  (steam::friends-has-friend (handle (steamfriends friend)) (handle friend) (apply #'flags 'steam::efriend-flags flags)))

(defmethod invite ((friend friend) (message string))
  (when (< steam::max-rich-presence-value-length (length message))
    (error "FIXME: message too long"))
  (unless (steam::friends-invite-user-to-game (handle (steamfriends friend)) (handle friend) message)
    (error "FIXME: failed to invite the friend.")))

(defmethod mark-as-played-with ((friend friend))
  (steam::friends-set-played-with (handle (steamfriends friend)) (handle friend)))

(defclass friend-group (c-object)
  ((steamfriends :initarg :steamfriends :reader steamfriends)))

(defmethod initialize-instance :after ((group friend-group) &key steamfriends index)
  (when index
    (setf (handle group) (steam::friends-get-friends-group-idby-index (handle steamfriends) index))))

(define-interface-submethod steamfriends friend-group display-name (steam::friends-get-friends-group-name))

(defmethod members ((group friend-group))
  (let ((count (steam::friends-get-friends-group-members-count (handle (steamfriends group)) (handle group))))
    (cffi:with-foreign-object (members :unsigned-long count)
      (steam::friends-get-friends-group-members-list (handle (steamfriends group)) (handle group) members count)
      (loop for i from 0 below count
            collect (make-instance 'friend :steamfriends (steamfriends group)
                                           :handle (cffi:mem-aref members :unsigned-long i))))))

;; FIXME: friend instance cache to allow eq comparison
;; FIXME: message stuff (only in callbacks)

(defclass clan (c-object)
  ((steamfriends :initarg :steamfriends :reader steamfriends)))

(defmethod initialize-instance :after ((clan clan) &key steamfriends index)
  (when index
    (setf (handle clan) (steam::friends-get-clan-by-index (handle friends) index))))

(define-interface-submethod steamfriends clan member-count (steam::friends-get-clan-chat-member-count))
(define-interface-submethod steamfriends clan admin-p (steam::friends-is-clan-chat-admin (user integer)))
(define-interface-submethod steamfriends clan public-p (steam::friends-is-clan-public))
(define-interface-submethod steamfriends clan official-p (steam::friends-is-clan-official-game-group))
(define-interface-submethod steamfriends clan chat-window-open-p (steam::friends-is-clan-chat-window-open-in-steam))
(define-interface-submethod steamfriends clan join (steam::friends-join-clan-chat-room))
(define-interface-submethod steamfriends clan leave (steam::friends-leave-clan-chat-room))
(define-interface-submethod steamfriends clan open-chat-window (steam::friends-open-clan-chat-window-in-steam))
(define-interface-submethod steamfriends clan send-message ((message string) steam::friends-send-clan-chat-message))

(defmethod admin-p ((clan clan) (user friend))
  (admin-p clan (handle user)))

(defmethod activity ((clan clan) &key callback)
  (if callback
      (cffi:with-foreign-object (list :unsigned-long)
        (setf (cffi:mem-ref list :unsigned-long) (handle clan))
        (with-call-result (result) (steam::friends-download-clan-activity-counts (handle friends) list 1)
          (when (steam::download-clan-activity-counts-t-success result)
            (funcall callback (activity clan)))))
      (cffi:with-foreign-objects ((online :int)
                                  (in-game :int)
                                  (chatting :int))
        (steam::friends-get-clan-activity-counts (handle friends) (handle clan) online in-game chatting)
        (list :online (cffi:mem-ref online :int)
              :in-game (cffi:mem-ref in-game :int)
              :chatting (cffi:mem-ref chatting :int)))))

(defmethod display-name ((clan clan))
  (let ((name (steam::friends-get-clan-name (handle (steamfriends clan)) (handle clan))))
    (when (string/= name "") name)))

(defmethod tag-name ((clan clan))
  (let ((name (steam::friends-get-clan-tag (handle (steamfriends clan)) (handle clan))))
    (when (string/= name "") name)))

(defmethod refresh-clan ((clan clan) &key (block T))
  (with-call-result (result :poll block)
      (steam::friends-request-clan-officer-list (handle (steamfriends clan)) (handle clan))))

(defmethod officer ((clan clan) (index integer))
  (let ((result (steam::friends-get-clan-officer-by-index (handle (steamfriends clan)) (handle clan) index)))
    (when (= 0 result)
      (refresh-clan clan)
      (setf result (steam::friends-get-clan-officer-by-index (handle (steamfriends clan)) (handle clan) index))
      (when (= 0 result) (error "FIXME: No such clan officer.")))
    (make-instance 'friend :steamfriends (steamfriends clan) :handle result)))

(defmethod list-officers ((clan clan))
  (let ((result (steam::friends-get-clan-officer-count (handle (steamfriends clan)) (handle clan))))
    (when (= 0 result)
      (refresh-clan clan)
      (setf result (steam::friends-get-clan-officer-count (handle (steamfriends clan)) (handle clan))))
    (loop for i from 0 below result
          collect (officer clan i))))

(defmethod owner ((clan clan))
  (let ((result (steam::friends-get-clan-owner (handle (steamfriends clan)) (handle clan))))
    (when (= 0 result)
      (refresh-clan clan)
      (setf result (steam::friends-get-clan-owner (handle (steamfriends clan)) (handle clan))))
    (make-instance 'friend :steamfriends (steamfriends clan) :handle result)))
