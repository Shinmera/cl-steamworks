#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamworkshop (interface)
  ())

(defmethod initialize-instance :after ((interface steamworkshop) &key version steamworks content-directory)
  (setf (handle interface) (get-interface-handle steamworks 'steam::client-get-isteam-ugc
                                                 (handle (user steamworks)) (handle (pipe steamworks))
                                                 (t-or version steam::steamugc-interface-version)))
  (when content-directory
    (unless (steam::ugc-binit-workshop-for-game-server (handle interface) (server-depot steamworks)
                                                       (namestring content-directory))
      (error "FIXME: failed to set workshop content folder."))))

(defmethod query ((workshop steamworkshop) (app integer) &key exclude require values (type :all) (page 1)
                                                              (sort :ranked-by-publication-date)
                                                              (on :target))
  ;; FIXME: userugcrequest
  (assert (<= 1 page) (page))
  (let ((workshop (handle workshop))
        (handle (steam::ugc-create-query-all-ugcrequest
                 (handle workshop) sort type
                 (ecase on (:creator (handle app)) (:target 0))
                 (ecase on (:creator 0) (:target (handle app)))
                 page)))
    ;; FIXME...
    (dolist (tag exclude)
      (unless (steam::ugc-add-excluded-tag workshop handle tag)
        (error "FIXME: could not add excluded tag.")))

    (dolist (tag require)
      (unless (steam::ugc-add-required-tag workshop handle tag)
        (error "FIXME: could not add excluded tag.")))
    
    (loop for (key . value) in values
          do (unless (steam::ugc-add-required-key-value-tag workshop handle key value)
               (error "FIXME: could not add required tag.")))))

(defclass workshop-file (c-object)
  ((steamworkshop :initarg :steamworkshop :reader steamworkshop)))

(defmethod initialize-instance :after ((file workshop-file) &key steamworkshop app type)

  (unless (handle file)
    (with-call-result (result :poll T) (steam::ugc-create-item (handle steamworkshop) (handle app) type)
      (when (steam::create-item-user-needs-to-accept-workshop-legal-agreement result)
        (warn "FIXME: user needs to accept agreement."))
      (with-error-on-failure (steam::create-item-result result))
      (setf (handle file) (steam::create-item-published-file-id result)))))

(define-interface-submethod steamworkshop workshop-file download (steam::ugc-download-item &key high-priority))

(defmethod dependencies ((file workshop-file))
  ;; FIXME: should cache
  ;; FIXME...
  (with-call-result (result :poll T) (steam::ugc-get-app-dependencies (handle (steamworkshop file)) (handle file))
    (with-error-on-failure (steam::get-app-dependencies-result result))
    ;; TODO: there's a "total num" field. Does this mean it can return less than
    ;;       everything? If so, how do I get the rest? There's no explicit pagination.
    ;;       does it split it across multiple call results? If so that's real bad...
    (loop with ptr = (cffi:foreign-slot-pointer (steam::_handle result) '(:struct steam::get-app-dependencies) 'steam::app-ids)
          for i from 0 below (steam::get-app-dependencies-num-app-dependencies result)
          collect (make-instance 'app :steamapps (interface 'steamapps (steamworks (steamworkshop file)))
                                      :handle (cffi:mem-aref ptr 'steam::app-id-t i)))))

(defmethod (setf dependencies) (values (file workshop-file))
  (let ((workshop (handle (steamworkshop file)))
        (to-add ()))
    ;; FIXME...
    (dolist (dependency to-add)
      (etypecase dependency
        (app
         (steam::ugc-add-app-dependency workshop (handle file) (handle dependency)))
        (workshop-file
         (steam::ugc-add-dependency workshop (handle file) (handle dependency)))))))

(defmethod update ((file workshop-file) &key values previews)
  (let ((workshop (handle (steamworkshop file))))
    ;; FIXME...
    (loop for (type . value) in previews
          do (case type
               (:you-tube-video
                (steam::ugc-add-item-preview-video workshop handle value))
               (:image
                (steam::ugc-add-item-preview-file workshop handle (namestring value) :image))
               (T
                (steam::ugc-add-item-preview-file workshop handle (princ-to-string value) type))))
    
    (loop for (key . value) in values
          do (when (< 255 (length key))
               (error "FIXME: key too long."))
             (when (< 255 (length value))
               (error "FIXME: value too long."))
             (when (loop for c across key
                         thereis (not (or (alphanumericp c)
                                          (char= #\_ c))))
               (error "FIXME: invalid key"))
             (steam::ugc-add-item-key-value-tag workshop handle key value))))

(defmethod favorite ((file workshop-file))
  (steam::ugc-add-item-to-favorites (handle (steamworkshop file)) (app-id file) (handle file)))

(defmethod app-id ((file workshop-file))
  ;; FIXME...
  )

(defmethod destroy ((file workshop-file))
  (with-call-result (result :poll T) (steam::ugc-delete-item (handle (steamworkshop file)) (handle file))
    (with-error-on-failure (steam::delete-item-result result))))

(defmethod download-status ((file workshop-file))
  (cffi:with-foreign-objects ((downloaded :uint64)
                              (total :uint64))
    (when (steam::ugc-get-item-download-info (handle (steamworkshop file)) (handle file) downloaded total)
      (list :downloaded (cffi:mem-ref downloaded :uint64)
            :total (cffi:mem-ref total :uint64)))))

(defmethod installation-info ((file workshop-file))
  (cffi:with-foreign-objects ((size :uint64)
                              (folder :char 256)
                              (last-update :uint32))
    (when (steam::ugc-get-item-install-info (handle (steamworkshop file)) (handle file) size folder 256 last-update)
      (values :size (cffi:mem-ref size :uint64)
              ;; KLUDGE: I'm actually unsure that parsing with UTF-8 is correct here.
              ;;         The code page on windows might be different for the FS...
              :directory (parse-namestring (cffi:foreign-string-to-lisp folder :count 256 :encoding :utf-8))
              :last-update (unix->universal (cffi:mem-ref last-update :uint32))))))
