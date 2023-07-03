(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamfriends (interface)
  ())

(defmethod initialize-instance :after ((interface steamfriends) &key (version T) steamworks)
  (setf (handle interface) (get-interface-handle* steamworks 'steam::client-get-isteam-friends
                                                  (t-or version STEAM::STEAMFRIENDS-INTERFACE-VERSION))))

(define-interface-method steamfriends clear-rich-presence (steam::friends-clear-rich-presence))
(define-interface-method steamfriends close-clan-chat-window (steam::friends-close-clan-chat-window-in-steam chat-id))
(define-interface-method steamfriends display-name (steam::friends-get-persona-name))
(define-interface-method steamfriends state (steam::friends-get-persona-state))
(define-interface-method steamfriends (setf display-name) (name steam::friends-set-persona-name))
(define-interface-method steamfriends (setf listen-for-messages) (value steam::friends-set-listen-for-friends-messages))

(define-self-method steamfriends display-name)
(define-self-method steamfriends (setf display-name))

(defmethod restricted-p ((friends steamfriends))
  (< 0 (steam::friends-get-user-restrictions (handle friends))))

(defmethod activate-overlay ((friends steamfriends) &key (dialog :friends) user lobby app url)
  (let ((dialog (ecase dialog
                  (:friends "friends")
                  (:community "community")
                  (:players "players")
                  (:settings "settings")
                  (:game-group "officialgamegroup")
                  (:stats "stats")
                  (:achievements "achievements"))))
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
  (let ((handle (steam::friends-get-clan-by-index (handle friends) index)))
    (ensure-iface-obj 'clan :interface friends :handle handle)))

(defmethod list-clans ((friends steamfriends))
  (loop for i from 0 below (steam::friends-get-clan-count (handle friends))
        collect (clan friends i)))

(defmethod follower-count ((friends steamfriends) (user integer))
  (with-call-result (result :poll T) (steam::friends-get-follower-count (handle friends) user)
    (check-result (steam::friends-get-follower-count-result result)
                  'steam::friends-get-follower-count)
    (steam::friends-get-follower-count-count result)))

(defmethod list-friend-groups ((friends steamfriends))
  (loop for i from 0 below (steam::friends-get-friends-group-count (handle friends))
        for handle = (steam::friends-get-friends-group-idby-index (handle friends) i)
        collect (ensure-iface-obj 'friend-group :interface friends :handle handle)))

(defmethod list-friends ((friends steamfriends) &key (flags '(:all)) source coplay)
  (cond (source
         (let ((source (handle source)))
           (loop for i from 0 below (steam::friends-get-friend-count-from-source (handle friends) source)
                 for handle = (steam::friends-get-friend-from-source-by-index (handle friends) source i)
                 collect (ensure-iface-obj 'friend :interface friends :handle handle))))
        (coplay
         (loop for i from 0 below (steam::friends-get-coplay-friend-count (handle friends))
               for handle = (steam::friends-get-coplay-friend (handle friends) i)
               collect (ensure-iface-obj 'friend :interface friends :handle handle)))
        (T
         (let ((flags (apply #'flags 'steam::efriend-flags flags)))
           (loop for i from 0 below (steam::friends-get-friend-count (handle friends) flags)
                 for handle = (steam::friends-get-friend-by-index (handle friends) i flags)
                 collect (ensure-iface-obj 'friend :interface friends :handle handle))))))

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
                 (princ-to-string value))))
    (check-utf8-size STEAM::MAX-RICH-PRESENCE-KEY-LENGTH key)
    (check-utf8-size STEAM::MAX-RICH-PRESENCE-VALUE-LENGTH value)
    (with-invalid-check NIL (steam::friends-set-rich-presence (handle friends) key value)))
  value)

(defmethod self ((friends steamfriends))
  (make-instance 'friend :interface friends :handle (steam-id T)))

(defmethod self ((default (eql T)))
  (self (interface 'steamfriends T)))

(defclass friend (interface-object)
  ()
  (:default-initargs :interface 'steamfriends))

(defmethod initialize-instance :after ((friend friend) &key)
  (steam::friends-request-user-information (iface* friend) (handle friend) T))

(defmethod print-object ((friend friend) stream)
  (print-unreadable-object (friend stream :type T)
    (format stream "~s @~d" (display-name friend) (handle friend))))

(define-interface-submethod friend coplay-game (steam::friends-get-friend-coplay-game)
  (when (/= 0 result) (ensure-iface-obj 'app :interface (interface 'steamapps friend) :handle result)))
(define-interface-submethod friend coplay-time (steam::friends-get-friend-coplay-time)
  (unix->universal result))
(define-interface-submethod friend state (steam::friends-get-friend-persona-state))
(define-interface-submethod friend relationship (steam::friends-get-friend-relationship))
(define-interface-submethod friend rich-presence (steam::friends-get-friend-rich-presence key))
(define-interface-submethod friend steam-level (steam::friends-get-friend-steam-level))
(define-interface-submethod friend following-p (steam::friends-is-following))
(define-interface-submethod friend in-source-p (steam::friends-is-user-in-source (source integer)))
(define-interface-submethod friend send-message ((message string) steam::friends-reply-to-friend-message))
(define-interface-submethod friend request-rich-presence (steam::friends-request-friend-rich-presence))

(defmethod steam-id ((friend friend))
  (handle friend))

(defmethod in-source-p ((friend friend) (source c-object))
  (in-source-p friend (handle source)))

(defmethod rich-presence ((friend friend) (all (eql T)))
  (loop for i from 0 below (steam::friends-get-friend-rich-presence-key-count (iface* friend) (handle friend))
        for key = (steam::friends-get-friend-rich-presence-key-by-index (iface* friend) (handle friend) i)
        collect (cons key (rich-presence friend key))))

(defmethod display-name ((friend friend))
  (let ((name (steam::friends-get-friend-persona-name (iface* friend) (handle friend))))
    (when (and (string/= name "")
               (string/= name "[unknown]"))
      name)))

(defmethod nickname ((friend friend))
  (let ((name (steam::friends-get-player-nickname (iface* friend) (handle friend))))
    (when (and name (string/= name "")) name)))

(defmethod display-name-history ((friend friend))
  (loop for i from 0
        for name = (steam::friends-get-friend-persona-name-history (iface* friend) (handle friend) i)
        while (string/= name "")
        collect name))

(defmethod current-game ((friend friend))
  (cffi:with-foreign-object (info '(:struct steam::friend-game-info))
    (when (steam::friends-get-friend-game-played (iface* friend) (handle friend) info)
      info)))

(defmethod avatar ((friend friend) &key (size :medium) callback)
  (flet ((make-image (handle)
           (unless (= 0 handle)
             (make-instance 'image :interface (interface 'steamutils friend)
                                   :handle handle))))
    (ecase size
      (:small (make-image (steam::friends-get-small-friend-avatar (iface* friend) (handle friend))))
      (:medium (make-image (steam::friends-get-medium-friend-avatar (iface* friend) (handle friend))))
      (:large
       (unless callback (error "CALLBACK required for large avatar requests."))
       (let ((handle (steam::friends-get-large-friend-avatar (iface* friend) (handle friend))))
         (flet ((thunk (parameter)
                  (when (and parameter (= (handle friend) (steam::avatar-image-loaded-id parameter)))
                    (funcall callback (make-image (steam::avatar-image-loaded-image parameter)))
                    T)))
           (if (/= -1 handle)
               (funcall callback (make-image handle))
               (make-instance 'closure-callback
                              :closure #'thunk
                              :struct-type 'steam::avatar-image-loaded))))))))

(defmethod kind-p ((friend friend) flags)
  (steam::friends-has-friend (iface* friend) (handle friend) (apply #'flags 'steam::efriend-flags flags)))

(defmethod invite ((friend friend) (message string))
  (check-utf8-size STEAM::MAX-RICH-PRESENCE-VALUE-LENGTH message)
  (with-invalid-check NIL (steam::friends-invite-user-to-game (iface* friend) (handle friend) message)))

(defmethod mark-as-played-with ((friend friend))
  (steam::friends-set-played-with (iface* friend) (handle friend)))

(defmethod get-message ((friend friend) (index integer))
  (cffi:with-foreign-objects ((buffer :uchar (+ 2048 1))
                              (type 'steam::echat-entry-type))
    (let ((count (with-invalid-check 0 (steam::friends-get-friend-message (iface* friend) (handle friend) index buffer (+ 2048 1) type))))
      (list :type (cffi:mem-ref type 'steam::echat-entry-type)
            :user friend
            :text (cffi:foreign-string-to-lisp buffer :count count :encoding :utf-8)))))

(defclass friend-group (interface-object)
  ()
  (:default-initargs :interface 'steamfriends))

(defmethod print-object ((group friend-group) stream)
  (print-unreadable-object (group stream :type T)
    (format stream "~s @~d" (display-name group) (handle group))))

(define-interface-submethod friend-group display-name (steam::friends-get-friends-group-name))

(defmethod members ((group friend-group))
  (let ((count (steam::friends-get-friends-group-members-count (iface* group) (handle group))))
    (cffi:with-foreign-object (members :unsigned-long count)
      (steam::friends-get-friends-group-members-list (iface* group) (handle group) members count)
      (loop for i from 0 below count
            collect (ensure-iface-obj 'friend :interface (iface group)
                                              :handle (cffi:mem-aref members :unsigned-long i))))))

(defclass clan (interface-object)
  ()
  (:default-initargs :interface 'steamfriends))

(defmethod print-object ((clan clan) stream)
  (print-unreadable-object (clan stream :type T)
    (format stream "~s @~d" (display-name clan) (handle clan))))

(define-interface-submethod clan member-count (steam::friends-get-clan-chat-member-count))
(define-interface-submethod clan admin-p (steam::friends-is-clan-chat-admin (user integer)))
(define-interface-submethod clan public-p (steam::friends-is-clan-public))
(define-interface-submethod clan official-p (steam::friends-is-clan-official-game-group))
(define-interface-submethod clan chat-window-open-p (steam::friends-is-clan-chat-window-open-in-steam))
(define-interface-submethod clan join (steam::friends-join-clan-chat-room))
(define-interface-submethod clan leave (steam::friends-leave-clan-chat-room))
(define-interface-submethod clan open-chat-window (steam::friends-open-clan-chat-window-in-steam))
(define-interface-submethod clan send-message ((message string) steam::friends-send-clan-chat-message))

(defmethod admin-p ((clan clan) (user friend))
  (admin-p clan (handle user)))

(defmethod activity ((clan clan) &key callback)
  (let ((friends (iface* clan)))
    (if callback
        (cffi:with-foreign-object (list :unsigned-long)
          (setf (cffi:mem-ref list :unsigned-long) (handle clan))
          (with-call-result (result) (steam::friends-download-clan-activity-counts friends list 1)
            (when (steam::download-clan-activity-counts-success result)
              (funcall callback (activity clan)))))
        (cffi:with-foreign-objects ((online :int)
                                    (in-game :int)
                                    (chatting :int))
          (steam::friends-get-clan-activity-counts friends (handle clan) online in-game chatting)
          (list :online (cffi:mem-ref online :int)
                :in-game (cffi:mem-ref in-game :int)
                :chatting (cffi:mem-ref chatting :int))))))

(defmethod display-name ((clan clan))
  (let ((name (steam::friends-get-clan-name (iface* clan) (handle clan))))
    (when (string/= name "") name)))

(defmethod tag-name ((clan clan))
  (let ((name (steam::friends-get-clan-tag (iface* clan) (handle clan))))
    (when (string/= name "") name)))

(defmethod refresh-clan ((clan clan) &key (block T))
  (with-call-result (result :poll block)
      (steam::friends-request-clan-officer-list (iface* clan) (handle clan))
    (declare (ignore result))))

(defmethod officer ((clan clan) (index integer))
  (let ((result (steam::friends-get-clan-officer-by-index (iface* clan) (handle clan) index)))
    (when (= 0 result)
      (refresh-clan clan)
      (setf result (steam::friends-get-clan-officer-by-index (iface* clan) (handle clan) index))
      (when (= 0 result) (error 'no-such-user :user-handle index)))
    (ensure-iface-obj 'friend :interface (iface clan) :handle result)))

(defmethod list-officers ((clan clan))
  (let ((result (steam::friends-get-clan-officer-count (iface* clan) (handle clan))))
    (when (= 0 result)
      (refresh-clan clan)
      (setf result (steam::friends-get-clan-officer-count (iface* clan) (handle clan))))
    (loop for i from 0 below result
          collect (officer clan i))))

(defmethod owner ((clan clan))
  (let ((result (steam::friends-get-clan-owner (iface* clan) (handle clan))))
    (when (= 0 result)
      (refresh-clan clan)
      (setf result (steam::friends-get-clan-owner (iface* clan) (handle clan))))
    (ensure-iface-obj 'friend :interface (iface clan) :handle result)))

(defmethod get-message ((clan clan) (index integer))
  (cffi:with-foreign-objects ((buffer :uchar (+ 2048 1))
                              (type 'steam::echat-entry-type)
                              (user 'steam::steam-id))
    (let ((count (with-invalid-check 0 (steam::friends-get-clan-chat-message (iface* clan) (handle clan) index buffer (+ 2048 1) type user))))
      (list :type (cffi:mem-ref type 'steam::echat-entry-type)
            :user (ensure-iface-obj 'friend :interface (iface clan) :handle (cffi:mem-ref user 'steam::steam-id))
            :text (cffi:foreign-string-to-lisp buffer :count count :encoding :utf-8)))))
