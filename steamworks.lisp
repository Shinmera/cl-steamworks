#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defvar *steamworks* NIL)

(defun steamworks ()
  (or *steamworks*
      (error "FIXME: steamworks is not initialised.")))

(defun most-recent-interface-version (interface)
  (let ((name (format NIL "~:@(steam~a-interface-version~)" (remove #\- (string interface)))))
    (symbol-value (or (find-symbol name '#:org.shirakumo.fraf.steamworks.cffi)
                      (error "FIXME: No such interface ~s" interface)))))

(defclass steamworks ()
  ((interfaces :initform (make-hash-table :test 'eq) :reader interfaces)
   (server-p :initform NIL :reader server-p)
   (user :initform NIL :reader user)
   (pipe :initform NIL :reader pipe)))

(defmethod initialize-instance :after ((steamworks steamworks) &key (interfaces '(:client T)))
  (unless (cl-steamworks-cffi::init)
    (error "FIXME: Failed to call INIT."))
  (tg:finalize steamworks (free-handle-function steamworks))
  (setf (slot-value steamworks 'user) (cl-steamworks-cffi::get-hsteam-user))
  (setf (slot-value steamworks 'pipe) (cl-steamworks-cffi::get-hsteam-pipe))
  (when (= 0 (pipe steamworks))
    (error "FIXME: could not retrieve valid steam pipe."))
  (create-interfaces steamworks interfaces)
  (setf *steamworks* steamworks))

(defmethod free ((steamworks steamworks))
  (funcall (free-handle-function steamworks NIL)))

(defmethod free-handle-function ((steamworks steamworks) handle)
  (let ((interfaces (interfaces steamworks)))
    (lambda ()
      (loop for key being the hash-keys of interfaces
            for val being the hash-values of interfaces
            do (with-simple-restart (continue "Ignore the failure and carry on freeing.")
                 (free val))
               (remhash val interfaces))
      (setf (slot-value steamworks 'user) NIL)
      (setf (slot-value steamworks 'pipe) NIL)
      (cl-steamworks-cffi::shutdown)
      (setf *steamworks* NIL))))

(defmethod create-interfaces ((steamworks steamworks) &rest interfaces &key (client T) &allow-other-keys)
  (unless client
    (error "FIXME: must create at least the client interface."))
  (flet ((maybe-create (interface version)
           (unless (gethash (interfaces steamworks) interface)
             (when (eql T version)
               (setf version (most-recent-interface-version interface)))
             (setf (gethash (interfaces steamworks) interface)
                   (make-instance interface :version version :steamworks steamworks)))))
    (maybe-create 'client client)
    (loop for (interface version) on interfaces by #'cddr
          do (maybe-create interface version))
    (alexandria:hash-table-values (interfaces steamworks))))

(defclass steamworks-server (steamworks)
  ((ip-address :initarg :ip-address :reader ip-address)
   (port :initarg :port :reader port)
   (game-port :initarg :game-port :reader game-port)
   (query-port :initarg :query-port :reader query-port)
   (server-mode :initarg :server-mode :reader server-mode)
   (version-string :initarg :version-string :reader version-string)))

(defmethod initialize-instance :after ((steamworks steamworks-server) &key)
  (unless (cl-steamworks-cffi::steam-internal-game-server-init
           (ip-address steamworks) (port steamworks) (game-port steamworks)
           (query-port steamworks) (server-mode steamworks) (version-string steamworks))
    (error "FIXME: failed to init game server."))
  (setf (slot-value steamworks 'server-p) T))

(defmethod free-handle-function ((steamworks steamworks-server) handle)
  (let ((interfaces (interfaces steamworks)))
    (lambda ()
      (loop for key being the hash-keys of interfaces
            for val being the hash-values of interfaces
            do (with-simple-restart (continue "Ignore the failure and carry on freeing.")
                 (free val))
               (remhash val interfaces))
      (setf (slot-value steamworks 'user) NIL)
      (setf (slot-value steamworks 'pipe) NIL)
      (cl-steamworks-cffi::steam-game-server-shutdown)
      (setf *steamworks* NIL))))
