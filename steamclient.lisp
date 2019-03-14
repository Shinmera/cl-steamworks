#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamclient (interface)
  ())

(defmethod initialize-instance :after ((client steamclient) &key version)
  (let ((handle (steam::create-interface (t-or version steam::steamclient-interface-version))))
    (when (cffi:null-pointer-p handle)
      (error "FIXME: failed to create steam client handle."))
    (setf (handle client) handle)
    (steam::client-set-warning-message-hook handle (cffi:callback warning-message))))

(cffi:defcallback warning-message :void ((severity :int) (debug-text :string))
  (format *error-output* "~&[~[INFO~;WARN~;ERR ~]] Steam: ~a~%"
          severity debug-text))

(defmethod ipc-call-count ((client steamclient))
  (steam::client-get-ipccall-count (handle client)))

(defmethod make-pipe ((client steamclient))
  (make-instance 'client-pipe :steamclient client))

(defmethod make-user ((client steamclient) (pipe pipe) &key (account-type :global))
  (make-instance 'client-user :steamclient client :pipe pipe :account-type account-type))

(defclass client-pipe (pipe c-managed-object)
  ((steamclient :initarg :steamclient :reader steamclient))
  (:default-initargs :free-on-gc T))

(defmethod allocate-handle ((pipe client-pipe))
  (steam::client-create-steam-pipe (handle (steamclient pipe))))

(defmethod free-handle-function ((pipe client-pipe) handle)
  (let ((client (handle (steamclient pipe))))
    (lambda ()
      (steam::client-brelease-steam-pipe client handle))))

(defclass client-user (user c-managed-object)
  ((steamclient :initarg :steamclient :reader steamclient)
   (account-type :initarg :account-type :initform :global :reader account-type))
  (:default-initargs :free-on-gc T))

(defmethod allocate-handle ((user client-user))
  (if (eql :global (account-type user))
      (steam::client-connect-to-global-user (handle (steamclient user)) (handle (pipe user)))
      (cffi:with-foreign-object (var 'steam::hsteam-pipe)
        (setf (cffi:mem-ref var 'steam::hsteam-pipe) (handle (pipe user)))
        (steam::client-create-local-user (handle (steamclient user)) var (account-type user)))))

(defmethod free-handle-function ((user client-user) handle)
  (let ((client (handle (steamclient user)))
        (pipe (handle (pipe user))))
    (lambda ()
      (steam::client-release-user client pipe handle))))
