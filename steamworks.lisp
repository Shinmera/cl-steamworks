#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defvar *steamworks* NIL)
(defvar *default-interfaces* ; Does not include interfaces that need deallocation
  '(steamclient steamutils steamuser steamfriends steamapps steammatchmaking steammusic
    steamnetworking steamparties steamremotestorage steamscreenshots steamuserstats
    steamvideo steamworkshop))
(defvar *default-server-interfaces* ; Does not include interfaces that are client-only
  '(steamclient steamutils steamuser steamfriends steamapps steamgameserver steamnetworking
    steamremotestorage steamuserstats steamworkshop))

(defun steamworks (&optional container)
  (if container
      (%steamworks container)
      (or *steamworks*
          (error 'steamworks-not-initialized))))

(defclass pipe (c-object)
  ())

(defclass user (c-object)
  ((pipe :initarg :pipe :reader pipe)))

(defclass steamworks ()
  ((interfaces :initform (make-hash-table :test 'eq) :reader interfaces)
   (user :initform NIL :reader user)
   (pipe :initform NIL :reader pipe)))

(defmethod initialize-instance :before ((steamworks steamworks) &key app-id)
  (unless *low-level-present*
    (error 'low-level-not-loaded))
  (when *steamworks*
    (cerror "Replace the previous steamworks instance."
            'steamworks-already-initialized))
  (when app-id
    (setup-app-id app-id)))

(defmethod initialize-instance :after ((steamworks steamworks) &key (interfaces *default-interfaces*))
  (tg:finalize steamworks (free-handle-function steamworks NIL))
  (create-interfaces steamworks interfaces)
  (create-global-callbacks)
  (setf *steamworks* steamworks))

(defmethod free ((steamworks steamworks))
  (funcall (free-handle-function steamworks NIL)))

(defmethod create-interfaces ((steamworks steamworks) interfaces)
  (flet ((maybe-create (interface)
           (destructuring-bind (interface &optional (version T)) (enlist interface)
             (unless (interface interface steamworks)
               (setf (gethash interface (interfaces steamworks))
                     (make-instance interface :version version :steamworks steamworks))))))
    (maybe-create 'steamclient)
    (mapc #'maybe-create interfaces)
    (list-interfaces steamworks)))

(defmethod create-interfaces ((steamworks (eql T)) interfaces)
  (create-interfaces (steamworks) interfaces))

(defmethod interface ((name symbol) (steamworks steamworks))
  (gethash name (interfaces steamworks)))

(defmethod interface (name (steamworks (eql T)))
  (interface name (steamworks)))

(defmethod list-interfaces ((steamworks steamworks))
  (alexandria:hash-table-values (interfaces steamworks)))

(defmethod list-interfaces ((steamworks (eql T)))
  (list-interfaces (steamworks)))

(defmethod run-callbacks ((default (eql T)))
  (run-callbacks (steamworks)))

(defclass steamworks-client (steamworks)
  ())

(defmethod initialize-instance ((steamworks steamworks-client) &key app-id)
  (call-next-method)
  (unless (steam::init)
    (restart-case
        (error 'initialization-failed :api-call 'steam::init)
      (restart (&optional (app-id app-id) (exit-code 2))
        :report "Restart the application through Steam."
        (when (steam::restart-app-if-necessary app-id)
          (quit exit-code)))))
  (setf (slot-value steamworks 'pipe) (make-instance 'pipe :handle (with-invalid-check 0 (steam::get-hsteam-pipe))))
  (setf (slot-value steamworks 'user) (make-instance 'user :handle (steam::get-hsteam-user)
                                                           :pipe (pipe steamworks))))

(defmethod free-handle-function ((steamworks steamworks-client) handle)
  (lambda ()
    (setf (slot-value steamworks 'user) NIL)
    (setf (slot-value steamworks 'pipe) NIL)
    (steam::shutdown)
    (setf *steamworks* NIL)))

(defmethod run-callbacks ((steamworks steamworks-client))
  (steam::run-callbacks))

(defclass steamworks-server (steamworks)
  ((ip-address :initarg :ip-address :reader ip-address)
   (steam-port :initarg :steam-port :reader steam-port)
   (game-port :initarg :game-port :reader game-port)
   (query-port :initarg :query-port :reader query-port)
   (server-mode :initarg :server-mode :reader server-mode)
   (version-string :initarg :version-string :reader version-string)
   (server-depot :initarg :server-depot :reader server-depot))
  (:default-initargs :interfaces *default-server-interfaces*))

(defmethod initialize-instance ((steamworks steamworks-server) &key ip-address steam-port game-port query-port server-mode version-string server-depot)
  (call-next-method)
  (unless server-depot
    (error "You must pass the :SERVER-DEPOT."))
  (with-invalid-check NIL (steam::game-server-init ip-address steam-port game-port query-port server-mode version-string))
  (setf (slot-value steamworks 'pipe) (make-instance 'pipe :handle (with-invalid-check 0 (steam::game-server-get-hsteam-pipe))))
  (setf (slot-value steamworks 'user) (make-instance 'user :handle (steam::game-server-get-hsteam-user)
                                                           :pipe (pipe steamworks))))

(defmethod initialize-instance :after ((steamworks steamworks-server) &key directory)
  ;; KLUDGE: We do this here rather than in steamgameserver as this step is /mandatory/.
  (assert (string/= "" directory) (directory))
  (check-utf8-size 32 directory)
  (steam::game-server-set-mod-dir (handle (interface 'steamgameserver steamworks)) directory))

(defmethod free-handle-function ((steamworks steamworks-server) handle)
  (lambda ()
    (setf (slot-value steamworks 'user) NIL)
    (setf (slot-value steamworks 'pipe) NIL)
    (steam::game-server-shutdown)
    (setf *steamworks* NIL)))

(defmethod run-callbacks ((steamworks steamworks-server))
  (steam::game-server-run-callbacks))
