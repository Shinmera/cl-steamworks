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
(define-interface-method steamfriends follower-count (steam::friends-get-follower-count))

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

(defmethod coplay-friend ((friends steamfriends) (index integer))
  ;; FIXME: translate into friend/user
  (steam::friends-get-coplay-friend (handle friends) index))

(defmethod list-coplay-friends ((friends steamfriends))
  (loop for i from 0 below (steam::friends-get-coplay-friend-count (handle friends))
        collect (coplay-friend friends i)))

(defclass clan (c-object)
  ((steamfriends :initarg :steamfriends :reader steamfriends)))

(defmethod initialize-instance :after ((clan clan) &key steamfriends index)
  (unless (handle clan)
    (setf (handle clan) (steam::friends-get-clan-by-index (handle friends) index))))

(define-interface-submethod steamfriends clan member-count (steam::friends-get-clan-chat-member-count))
(define-interface-submethod steamfriends clan admin-p (steam::friends-is-clan-chat-admin (user index)))
(define-interface-submethod steamfriends clan public-p (steam::friends-is-clan-public))
(define-interface-submethod steamfriends clan official-p (steam::friends-is-clan-official-game-group))
(define-interface-submethod steamfriends clan chat-window-open-p (steam::friends-is-clan-chat-window-open-in-steam))
(define-interface-submethod steamfriends clan join (steam::friends-join-clan-chat-room))
(define-interface-submethod steamfriends clan leave (steam::friends-leave-clan-chat-room))
(define-interface-submethod steamfriends clan open-chat-window (steam::friends-open-clan-chat-window-in-steam))
(define-interface-submethod steamfriends clan send-message (message steam::friends-send-clan-chat-message))

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

(defmethod officer ((clan clan) (index integer))
  ;; FIXME turn into user object
  (steam::friends-get-clan-officer-by-index (handle (steamfriends clan)) (handle clan) index))

(defmethod list-officers ((clan clan) callback)
  ;; FIXME: ugly callback
  (with-call-result (result) (steam::friends-request-clan-officer-list (handle (steamfriends clan)) (handle clan))
    (when (< 0 (steam::clan-officer-list-response-t-success result))
      (funcall callback (loop for i from 0 below (steam::clan-officer-list-response-t-officers)
                              collect (officer clan i))))))

(defmethod owner ((clan clan))
  ;; FIXME: requires request-clan-officer-list first
  )
