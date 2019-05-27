#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamapps (interface)
  ((applist-handle :initarg :applist-handle :accessor applist-handle)
   (appticket-handle :initarg :appticket-handle :accessor appticket-handle)))

(defmethod initialize-instance :after ((interface steamapps) &key version applist-version appticket-version steamworks)
  (setf (handle interface) (get-interface-handle* steamworks 'steam::client-get-isteam-apps
                                                 (t-or version STEAM::STEAMAPPS-INTERFACE-VERSION)))
  (setf (applist-handle interface) (get-interface-handle* steamworks 'steam::client-get-isteam-app-list
                                                         (t-or applist-version STEAM::STEAMAPPLIST-INTERFACE-VERSION)))
  (setf (appticket-handle interface) (get-interface-handle* steamworks 'steam::client-get-isteam-app-ticket
                                                            (t-or appticket-version STEAM::STEAMAPPTICKET-INTERFACE-VERSION))))

(define-interface-method steamapps low-violence-p (steam::apps-bis-low-violence))
(define-interface-method steamapps subscribed-p (steam::apps-bis-subscribed))
(define-interface-method steamapps family-shared-p (steam::apps-bis-subscribed-from-family-sharing))
(define-interface-method steamapps free-weekend-p (steam::apps-bis-subscribed-from-free-weekend))
(define-interface-method steamapps cybercafe-p (steam::apps-bis-cybercafe))
(define-interface-method steamapps vac-banned-p (steam::apps-bis-vacbanned))
(define-interface-method steamapps build-id (steam::apps-get-app-build-id))
(define-interface-method steamapps owner (steam::apps-get-app-owner)
  (ensure-iface-obj 'friend :interface (interface 'steamfriends steamapps) :handle result))
(define-interface-method steamapps languages (steam::apps-get-available-game-languages)
  (split-string result #\,))
(define-interface-method steamapps language (steam::apps-get-current-game-language))
(define-interface-method steamapps launch-parameter (parameter steam::apps-get-launch-query-param)
  (when (string/= "" result) result))
(define-interface-method steamapps mark-as-corrupt (steam::apps-mark-content-corrupt &key missing-only))

(defmethod list-dlcs ((apps steamapps))
  (loop for i from 0 below (steam::apps-get-dlccount (handle apps))
        collect (cffi:with-foreign-objects ((id 'steam::app-id-t)
                                            (available :bool)
                                            (name :char 256))
                  (unless (steam::apps-bget-dlcdata-by-index (handle apps) i id available name 256)
                    (error "FIXME: could not retrieve dlc."))
                  (ensure-iface-obj 'dlc :interface apps
                                         :handle (cffi:mem-ref id 'steam::app-id-t)
                                         :available (cffi:mem-ref available :bool)
                                         :display-name (cffi:foreign-string-to-lisp name :count 256 :encoding :utf-8)))))

(defmethod beta-name ((apps steamapps))
  (cffi:with-foreign-object (buffer :char 256)
    (when (steam::apps-get-current-beta-name (handle apps) buffer 256)
      (cffi:foreign-string-to-lisp buffer :count 256 :encoding :utf-8))))

(defmethod file-details ((apps steamapps) file)
  (with-call-result (result :poll T) (steam::apps-get-file-details (namestring file))
    (with-error-on-failure (steam::file-details-result result))
    (list :size (steam::file-details-file-size result)
          :sha (steam::file-details-file-sha result)
          :flags (steam::file-details-flags result))))

(defmethod launch-command-line ((apps steamapps))
  (cffi:with-foreign-object (buffer :char 1024)
    (let ((count (steam::apps-get-launch-command-line (handle apps) buffer 256)))
      (cffi:foreign-string-to-lisp buffer :count count :encoding :utf-8))))

(defmethod list-apps ((apps steamapps))
  (let ((count (steam::app-list-get-num-installed-apps (applist-handle apps))))
    (cffi:with-foreign-object (buffer 'steam::app-id-t count)
      (loop for i from 0 below (steam::app-list-get-installed-apps (applist-handle apps) buffer count)
            collect (ensure-iface-obj 'app :interface apps :handle (cffi:mem-aref buffer 'steam::app-id-t i))))))

(defmethod find-app ((apps steamapps) (handle integer))
  (ensure-iface-obj 'app :interface apps :handle handle))

(defmethod find-app ((apps steamapps) (handle (eql T)))
  (app apps (app-id (interface 'steamutils (steamworks apps)))))

(defmethod app ((apps steamapps))
  (find-app apps T))

(defclass app (interface-object)
  ()
  (:default-initargs :interface 'steamapps))

(define-interface-submethod app installed-p (steam::apps-bis-app-installed))
(define-interface-submethod app subscribed-p (steam::apps-bis-subscribed-app))
(define-interface-submethod app purchase-time (steam::apps-get-earliest-purchase-unix-time)
  (unix->universal result))

(defmethod app-id ((app app))
  (handle app))

(defmethod install-directory ((app app))
  (cffi:with-foreign-object (buffer :char 256)
    (let ((count (steam::apps-get-app-install-dir (iface* app) (handle app) buffer 256)))
      ;; KLUDGE: I'm actually unsure that parsing with UTF-8 is correct here.
      ;;         The code page on windows might be different for the FS...
      (cffi:foreign-string-to-lisp buffer :count count :encoding :utf-8))))

(defmethod list-installed-depots ((app app))
  (cffi:with-foreign-object (buffer 'steam::depot-id-t 256)
    (loop for i from 0 below (steam::apps-get-installed-depots (iface* app) (handle app) buffer 256)
          for handle = (cffi:mem-aref buffer 'steam::depot-id-t i)
          collect handle)))

(defmethod ticket-data ((app app))
  (cffi:with-foreign-objects ((buffer :uint8 256)
                              (app-id :uint32)
                              (steam-id :uint32)
                              (signature :uint32)
                              (signature-len :uint32))
    (let ((copied (steam::app-ticket-get-app-ownership-ticket-data (appticket-handle (iface app)) (handle app)
                                                                   buffer 256 app-id steam-id signature signature-len))
          (steam-id (cffi:mem-ref steam-id :uint32))
          (signature (cffi:mem-ref signature :uint32))
          (signature-len (cffi:mem-ref signature-len :uint32)))
      (when (= 0 copied)
        (error "FIXME: failed to retrieve ticket data."))
      (values (cffi:mem-aref (cffi:inc-pointer buffer steam-id) :unsigned-long)
              (cffi:foreign-array-to-lisp (cffi:inc-pointer buffer signature) (list :array :uint8 signature-len)
                                          :element-type '(unsigned-byte 8))))))

(defclass dlc (app)
  ((available :initform NIL :initarg :available :reader available-p)
   (display-name :initform NIL :initarg :display-name :reader display-name)))

(define-interface-submethod dlc installed-p (steam::apps-bis-dlc-installed))
(define-interface-submethod dlc install (steam::apps-install-dlc))
(define-interface-submethod dlc uninstall (steam::apps-uninstall-dlc))

(defmethod download-status ((dlc dlc))
  (cffi:with-foreign-objects ((downloaded :uint64)
                              (total :uint64))
    (when (steam::apps-get-dlc-download-progress (iface* dlc) (handle dlc) downloaded total)
      (list :downloaded (cffi:mem-ref downloaded :uint64)
            :total (cffi:mem-ref total :uint64)))))
