(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamclient (interface)
  ())

(defmethod initialize-instance :after ((client steamclient) &key (version T))
  (let ((handle (steam::create-interface (t-or version STEAM::STEAMCLIENT-INTERFACE-VERSION))))
    (when (cffi:null-pointer-p handle)
      (error 'api-call-failed :api-call 'steam::create-interface))
    (setf (handle client) handle)
    (steam::client-set-warning-message-hook handle (cffi:callback warning-message))))

(cffi:defcallback warning-message :void ((severity :int) (debug-text :string))
  (format *error-output* "~&[~[INFO~;WARN~;ERR ~]] Steam: ~a~%"
          severity debug-text))

(defmethod ipc-call-count ((client steamclient))
  (steam::client-get-ipccall-count (handle client)))

(defmethod make-pipe ((client steamclient))
  (make-instance 'client-pipe :interface client))

(defmethod make-user ((client steamclient) (pipe pipe) &key (account-type :global))
  (make-instance 'client-user :interface client :pipe pipe :account-type account-type))

(defclass client-pipe (pipe c-managed-object interface-object)
  ()
  (:default-initargs :free-on-gc T))

(defmethod allocate-handle ((pipe client-pipe) &key)
  (steam::client-create-steam-pipe (iface* pipe)))

(defmethod free-handle-function ((pipe client-pipe) handle)
  (let ((interface (iface* pipe)))
    (lambda ()
      (steam::client-brelease-steam-pipe interface handle))))

(defclass client-user (user c-managed-object interface-object)
  ((pipe :initarg :pipe :initform (error "PIPE required") :reader pipe)
   (account-type :initarg :account-type :initform :global :reader account-type))
  (:default-initargs :free-on-gc T))

(defmethod allocate-handle ((user client-user) &key)
  (if (eql :global (account-type user))
      (steam::client-connect-to-global-user (iface* user) (handle (pipe user)))
      (cffi:with-foreign-object (var 'steam::hsteam-pipe)
        (setf (cffi:mem-ref var 'steam::hsteam-pipe) (handle (pipe user)))
        (steam::client-create-local-user (iface* user) var (account-type user)))))

(defmethod free-handle-function ((user client-user) handle)
  (let ((interface (iface* user))
        (pipe (handle (pipe user))))
    (lambda ()
      (steam::client-release-user interface pipe handle))))
