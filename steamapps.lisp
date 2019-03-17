#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamapps (interface)
  ((applist-handle :initarg :applist-handle :accessor applist-handle)))

(defmethod initialize-instance :after ((interface steamapps) &key version steamworks)
  (setf (handle interface) (get-interface-handle steamworks 'steam::client-get-isteam-apps
                                                 (handle (user steamworks)) (handle (pipe steamworks))
                                                 (t-or version steam::steamapps-interface-version)))
  (setf (applist-handle interface) (get-interface-handle steamworks 'steam::client-get-isteam-app-list
                                                         (handle (user steamworks)) (handle (pipe steamworks))
                                                         (t-or version steam::steamapplist-interface-version))))

(define-interface-method steamapps low-violence-p (steam::apps-bis-low-violence))
(define-interface-method steamapps subscribed-p (steam::apps-bis-subscribed))
(define-interface-method steamapps family-shared-p (steam::apps-bis-subscribed-from-family-sharing))
(define-interface-method steamapps free-weekend-p (steam::apps-bis-subscribed-from-free-weekend))
(define-interface-method steamapps cybercafe-p (steam::apps-bis-cybercafe))
(define-interface-method steamapps vac-banned-p (steam::apps-bis-vacbanned))
(define-interface-method steamapps build-id (steam::apps-get-app-build-id))
(define-interface-method steamapps owner (steam::apps-get-app-owner)
  (make-instance 'friend :steamfriends (interface 'steamfriends (steamworks steamapps)) :handle result))
(define-interface-method steamapps languages (steam::apps-get-available-game-languages)
  (split-string result #\,))
(define-interface-method steamapps language (steam::apps-get-current-game-language))
(define-interface-method steamapps launch-parameter (parameter steam::apps-get-launch-query-param)
  (when (string/= "" result) result))
(define-interface-method steamapps mark-as-corrupt (steam::apps-mark-content-corrupt &key missing-only))

(defmethod dlc ((apps steamapps) (index integer))
  (make-instance 'dlc :steamapps apps :index index))

(defmethod list-dlcs ((apps steamapps))
  (loop for i from 0 below (steam::apps-get-dlccount (handle apps))
        collect (make-instance 'dlc :steamapps apps :index i)))

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
            collect (make-instance 'app :steamapps apps :handle (cffi:mem-aref buffer 'steam::app-id-t i))))))

(defmethod find-app ((apps steamapps) (handle integer))
  (make-instance 'app :steamapps apps :handle handle))

(defmethod find-app ((apps steamapps) (handle (eql T)))
  (app apps (app-id (interface 'steamutils (steamworks apps)))))

(defmethod app ((apps steamapps))
  (find-app apps T))

(defclass app (c-object)
  ((steamapps :initarg :steamapps :reader steamapps)))

(define-interface-submethod steamapps app installed-p (steam::apps-bis-app-installed))
(define-interface-submethod steamapps app subscribed-p (steam::apps-bis-subscribed-app))
(define-interface-submethod steamapps app purchase-time (steam::apps-get-earliest-purchase-unix-time)
  (unix->universal result))

(defmethod app-id ((app app))
  (handle app))

(defmethod install-directory ((app app))
  (cffi:with-foreign-object (buffer :char 256)
    (let ((count (steam::apps-get-app-install-dir (handle (steamapps app)) (handle app) buffer 256)))
      ;; KLUDGE: I'm actually unsure that parsing with UTF-8 is correct here.
      ;;         The code page on windows might be different for the FS...
      (cffi:foreign-string-to-lisp buffer :count count :encoding :utf-8))))

(defmethod list-installed-depots ((app app))
  (cffi:with-foreign-object (buffer 'steam::depot-id-t 256)
    (loop for i from 0 below (steam::apps-get-installed-depots (handle (steamapps app)) (handle app) buffer 256)
          for handle = (cffi:mem-aref buffer 'steam::depot-id-t i)
          collect (make-instance 'depot :handle handle))))

(defclass dlc (app)
  ((available :initform NIL :reader available-p)
   (display-name :initform NIL :reader display-name)))

(defmethod initialize-instance :after ((dlc dlc) &key steamapps index)
  (when index
    (cffi:with-foreign-objects ((id 'steam::app-id-t)
                                (available :bool)
                                (name :char 256))
      (unless (steam::apps-bget-dlcdata-by-index (handle steamapps) index id available name 256)
        (error "FIXME: could not retrieve dlc."))
      (setf (handle dlc) (cffi:mem-ref id 'steam::app-id-t))
      (setf (slot-value dlc 'available) (cffi:mem-ref available :bool))
      (setf (slot-value dlc 'display-name) (cffi:foreign-string-to-lisp name :count 256 :encoding :utf-8)))))

(define-interface-submethod steamapps dlc installed-p (steam::apps-bis-dlc-installed))
(define-interface-submethod steamapps dlc install (steam::apps-install-dlc))
(define-interface-submethod steamapps dlc uninstall (steam::apps-uninstall-dlc))

(defmethod download-status ((dlc dlc))
  (cffi:with-foreign-objects ((downloaded :uint64)
                              (total :uint64))
    (when (steam::apps-get-dlc-download-progress (handle (steamapps dlc)) (handle dlc) downloaded total)
      (list :downloaded (cffi:mem-ref downloaded :uint64)
            :total (cffi:mem-ref total :uint64)))))

(defclass depot (c-object)
  ())
