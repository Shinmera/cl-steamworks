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

(defmethod list-subscribed-files ((workshop steamworkshop))
  (let ((count (steam::ugc-get-num-subscribed-items (handle workshop))))
    (cffi:with-foreign-object (buffer 'steam::published-file-id-t count)
      (loop for i from 0 below (steam::ugc-get-subscribed-items (handle workshop) buffer count)
            for handle = (cffi:mem-aref buffer 'steam::published-file-id-t i)
            collect (make-instance 'workshop-file :steamworkshop workshop
                                                  :app (app (interface 'steamapps (steamworks workshop)))
                                                  :handle handle)))))

(defmethod query ((workshop steamworkshop) (app app) &rest args &key user list type sort on page exclude require key-value-tags request search any-tay rank-by-trend-days)
  (declare (ignore list type sort on page exclude require key-value-tags request search any-tay rank-by-trend-days))
  (let ((query (apply #'make-instance
                      (if user
                          'workshop-user-query
                          'workshop-global-query)
                      :steamworkshop workshop
                      :app app
                      args)))
    (multiple-value-bind (count total) (execute query)
      (loop for i from 0 below count
            collect (make-instance )))))

(defclass workshop-query (c-managed-object)
  ((steamworkshop :initarg :steamworkshop :reader steamworkshop)
   (app :initarg app :reader app)))

(defmethod initialize-instance :after ((query workshop-query) &key app exclude require key-value-tags request search any-tag rank-by-trend-days)
  (dolist (tag exclude)
    (unless (add-excluded-tag tag query)
      (error "FIXME: could not add excluded tag.")))
  (dolist (tag require)
    (unless (add-required-tag tag query)
      (error "FIXME: could not add excluded tag.")))
  (loop for (key . value) in key-value-tags
        do (unless (add-key-value-tag key value query)
             (error "FIXME: could not add required tag.")))
  (set-match-any-tag query any-tag)
  (set-ranked-by-trend-days query rank-by-trend-days)
  (set-request-all-previews query (find :all-previews request))
  (set-request-children query (find :children request))
  (set-request-key-value-tags query (find :key-value-tags request))
  (set-request-full-description query (find :full-description request))
  (set-request-metadata query (find :metadata request))
  (set-request-ids-only query (find :ids-only request))
  (set-request-playtime-stats query (find :playtime-stats request))
  (set-request-total-only query (find :total-only request))
  (when search
    (set-search-text query search)))

(defmethod free-handle-function ((query workshop-query) handle)
  (let ((workshop (steamworkshop query)))
    (lambda ()
      (steam::ugc-release-query-ugcrequest (handle workshop) handle))))

(define-interface-submethod steamworkshop workshop-query add-excluded-tag ((tag string) steam::ugc-add-excluded-tag))
(define-interface-submethod steamworkshop workshop-query add-required-tag ((tag string) steam::ugc-add-required-tag))
(define-interface-submethod steamworkshop workshop-query add-key-value-tag ((key string) (value string) steam::ugc-add-required-key-value-tag))
(define-interface-submethod steamworkshop workshop-query set-match-any-tag (steam::ugc-set-match-any-tag value))
(define-interface-submethod steamworkshop workshop-query set-ranked-by-trend-days (steam::ugc-set-ranked-by-trend-days value))
(define-interface-submethod steamworkshop workshop-query set-request-all-previews (steam::ugc-set-return-additional-previews value))
(define-interface-submethod steamworkshop workshop-query set-request-children (steam::ugc-set-return-children value))
(define-interface-submethod steamworkshop workshop-query set-request-key-value-tags (steam::ugc-set-return-key-value-tags value))
(define-interface-submethod steamworkshop workshop-query set-request-full-description (steam::ugc-set-return-long-description value))
(define-interface-submethod steamworkshop workshop-query set-request-metadata (steam::ugc-set-return-metadata value))
(define-interface-submethod steamworkshop workshop-query set-request-ids-only (steam::ugc-set-return-only-ids value))
(define-interface-submethod steamworkshop workshop-query set-request-playtime-stats (steam::ugc-set-return-playtime-stats value))
(define-interface-submethod steamworkshop workshop-query set-request-total-only (steam::ugc-set-return-total-only value))
(define-interface-submethod steamworkshop workshop-query set-search-text (steam::ugc-set-return-search-text value))

(defmethod execute ((query workshop-query) &key callback)
  (flet ((default-callback (result)
           (with-error-on-failure (steam::steam-ugcquery-completed-result result))
           (values (steam::steam-ugcquery-completed-num-results-returned result)
                   (steam::steam-ugcquery-completed-total-matching-results result))))
    (with-call-result (result :poll (not (null callback)))
        (steam::ugc-send-query-ugcrequest (handle (steamworkshop query)) (handle query))
      (funcall (or callback #'default-callback) result))))

(defmethod get-previews ((query workshop-query) (index integer))
  (cffi:with-foreign-objects ((source :char 256)
                              (original :char 256)
                              (kind 'steam::eitem-preview-type))
    (loop with workshop = (handle (steamworkshop query))
          with handle = (handle query)
          for i from 0 below (steam::ugc-get-query-ugcnum-additional-previews workshop handle index)
          when (steam::ugc-get-query-ugcadditional-preview workshop handle index i source 256 original 256 kind)
          collect (list :kind (cffi:mem-ref kind 'steam::eitem-preview-type)
                        :source (cffi:foreign-string-to-lisp source :count 256 :encoding :utf-8)
                        :original (cffi:foreign-string-to-lisp original :count 256 :encoding :utf-8)))))

(defmethod get-children ((query workshop-query) (index integer) count)
  (cffi:with-foreign-object (buffer 'steam::published-file-id-t count)
    (unless (steam::ugc-get-query-ugcchildren (handle (steamworkshop query)) (handle query) index buffer count)
      (error "FIXME: failed to get children."))
    (loop for i from 0 below count
          collect (make-instance 'workshop-file :steamworkshop (steamworkshop query)
                                                :handle (cffi:mem-aref buffer 'steam::published-file-id-t i)
                                                :app (app query)))))

(defmethod get-key-value-tags ((query workshop-query) (index integer))
  (cffi:with-foreign-objects ((key :char 256)
                              (value :char 256))
    (loop with workshop = (handle (steamworkshop query))
          with handle = (handle query)
          for i from 0 below (steam::ugc-get-query-ugcnum-key-value-tags workshop handle index)
          when (steam::ugc-get-query-ugckey-value-tag workshop handle index i key 256 value 256)
          collect (cons (cffi:foreign-string-to-lisp key :count 256 :encoding :utf-8)
                        (cffi:foreign-string-to-lisp value :count 256 :encoding :utf-8)))))

(defmethod get-metadata ((query workshop-query) (index integer))
  (cffi:with-foreign-object (buffer :char 256)
    (unless (steam::ugc-get-query-ugcmetadata (handle (steamworkshop query)) (handle query) index buffer 256)
      (error "FIXME: failed to get metadata."))
    (cffi:foreign-string-to-lisp buffer :count 256 :encoding :utf-8)))

(defmethod get-statistics ((query workshop-query) (index integer))
  (cffi:with-foreign-object (buffer :uint64)
    (loop with workshop = (handle (steamworkshop query))
          with handle = (handle query)
          for type in (cffi:foreign-enum-keyword-list 'steam::eitem-statistic)
          when (steam::ugc-get-query-ugcstatistic workshop handle index type buffer)
          collect type and collect (cffi:mem-ref buffer :uint64))))

(defmethod get-details ((query workshop-query) (index integer))
  (cffi:with-foreign-object (buffer 'cffi:steam-ugcdetails)
    (unless (steam::ugc-get-query-ugcresult (handle (steamworkshop query)) (handle query) index buffer)
      (error "FIXME: failed to get details."))
    (cffi:mem-ref buffer 'cffi:steam-ugcdetails)))

(defmethod get-workshop-file ((query workshop-query) (index integer))
  (let* ((id (steam::steam-ugcdetails-published-file-id (get-details query index)))
         (file (make-instance 'workshop-file :steamworkshop (steamworkshop query)
                                             :app (app query)
                                             :handle id)))
    (complete-from-query file query)
    file))

(defclass workshop-global-query (workshop-query)
  ())

(defmethod allocate-handle ((query workshop-global-query) &key steamworkshop app
                                                               (type :all)
                                                               (sort :ranked-by-publication-date)
                                                               (on :target)
                                                               (page 1))
  (steam::ugc-create-query-all-ugcrequest
   (handle steamworkshop) sort type
   (ecase on (:creator (handle app)) (:target 0))
   (ecase on (:creator 0) (:target (handle app)))
   page))

(defclass workshop-user-query (workshop-query)
  ())

(defmethod allocate-handle ((query workshop-user-query) &key steamworkshop app user
                                                             (list :subscribed)
                                                             (type :all)
                                                             (sort :creation-order-desc)
                                                             (on :target)
                                                             (page 1))
  (steam::ugc-create-query-user-ugcrequest
   (handle steamworkshop) (account-id (handle user)) list type sort
   (ecase on (:creator (handle app)) (:target 0))
   (ecase on (:creator 0) (:target (handle app)))
   page))

;; details-request

(defclass workshop-file (c-object)
  ((app :initarg :app :reader app)
   (steamworkshop :initarg :steamworkshop :reader steamworkshop)))

(defmethod initialize-instance :after ((file workshop-file) &key steamworkshop app type)
  (unless app (error "APP required."))
  (unless (handle file)
    (with-call-result (result :poll T) (steam::ugc-create-item (handle steamworkshop) (handle app) type)
      (when (steam::create-item-user-needs-to-accept-workshop-legal-agreement result)
        (warn "FIXME: user needs to accept agreement."))
      (with-error-on-failure (steam::create-item-result result))
      (setf (handle file) (steam::create-item-published-file-id result)))))

(define-interface-submethod steamworkshop workshop-file download (steam::ugc-download-item &key high-priority))
(define-interface-submethod steamworkshop workshop-file state (steam::ugc-get-item-state)
  (decode-flags 'steam::eitem-state result))

(defmethod file-dependencies ((file workshop-file))
  ;; FIXME...
  )

(defmethod (setf file-dependencies) (values (file workshop-file))
  (let ((workshop (handle (steamworkshop file)))
        (previous (dependencies file))
        (to-add (set-difference values previous))
        (to-remove (set-difference previous values))))
  (dolist (dependency to-add)
    (steam::ugc-add-dependency workshop (handle file) (handle dependency)))
  (dolist (dependency to-remove)
    (steam::ugc-remove-dependency workshop (handle file) (handle dependency)))
  values)

(defmethod app-dependencies ((file workshop-file))
  ;; FIXME: cache
  (with-call-result (result :poll T) (steam::ugc-get-app-dependencies (handle (steamworkshop file)) (handle file))
    (with-error-on-failure (steam::get-app-dependencies-result result))
    ;; TODO: there's a "total num" field. Does this mean it can return less than
    ;;       everything? If so, how do I get the rest? There's no explicit pagination.
    ;;       does it split it across multiple call results? If so that's real bad...
    (loop with ptr = (cffi:foreign-slot-pointer (steam::_handle result) '(:struct steam::get-app-dependencies) 'steam::app-ids)
          for i from 0 below (steam::get-app-dependencies-num-app-dependencies result)
          collect (make-instance 'app :steamapps (interface 'steamapps (steamworks (steamworkshop file)))
                                      :handle (cffi:mem-aref ptr 'steam::app-id-t i)))))

(defmethod (setf app-dependencies) (values (file workshop-file))
  (let ((workshop (handle (steamworkshop file)))
        (previous (app-dependencies file))
        (to-add (set-difference values previous))
        (to-remove (set-difference previous values)))
    ;; FIXME...
    (dolist (dependency to-add)
      (steam::ugc-add-app-dependency workshop (handle file) (handle dependency)))
    (dolist (dependency to-remove)
      (steam::ugc-remove-app-dependency workshop (handle file) (handle dependency)))
    values))

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

;; get-item-update-status

(defmethod favorite ((file workshop-file))
  (steam::ugc-add-item-to-favorites (handle (steamworkshop file)) (app-id (app file)) (handle file)))

(defmethod unfavorite ((file workshop-file))
  (steam::ugc-remove-item-from-favorites (handle (steamworkshop file)) (app-id (app file)) (handle file)))

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

(defmethod vote ((file workshop-file))
  (with-call-result (result :poll T) (steam::ugc-get-user-item-vote (handle (steamworkshop file)) (handle file))
    (with-error-on-failure (steam::get-user-item-vote-result result))
    (cond ((steam::get-user-item-vote-voted-up result) :up)
          ((steam::get-user-item-vote-voted-down result) :down)
          ((steam::get-user-item-vote-voted-skipped result) :skipped)
          (T :unknown))))

(defmethod complete-from-query ((file workshop-file) (query workshop-query))
  ;; FIXME...
  )
