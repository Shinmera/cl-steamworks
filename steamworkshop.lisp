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

(define-interface-method steamworkshop (setf downloads-suspended-p) (value steam::ugc-suspend-downloads))

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
      (declare (ignore total))
      (loop for i from 0 below count
            collect (complete-from-query
                     (make-instance 'workshop-file :steamworkshop workshop
                                                   :app app
                                                   :handle T)
                     query)))))

(defmethod stop-tracking ((workshop steamworkshop))
  (with-call-result (result :poll T) (steam::ugc-stop-playtime-tracking-for-all-items (handle workshop))
    (with-error-on-failure (steam::stop-playtime-tracking-result result))))

(defclass workshop-query (c-managed-object)
  ((steamworkshop :initarg :steamworkshop :reader steamworkshop)
   (app :initarg app :reader app)))

(defmethod initialize-instance :after ((query workshop-query) &key exclude require key-value-tags request search any-tag rank-by-trend-days)
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
(define-interface-submethod steamworkshop workshop-query set-allow-cached-response (steam::ugc-set-allow-cached-response max-age-in-seconds))
(define-interface-submethod steamworkshop workshop-query set-cloud-file-name-filter (steam::ugc-set-cloud-file-name-filter file-name))
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
(define-interface-submethod steamworkshop workshop-query set-search-text (steam::ugc-set-search-text value))
(define-interface-submethod steamworkshop workshop-query set-language (steam::ugc-set-language language))

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
          collect (list :index i
                        :kind (cffi:mem-ref kind 'steam::eitem-preview-type)
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
  (cffi:with-foreign-object (buffer '(:struct steam::steam-ugcdetails))
    (unless (steam::ugc-get-query-ugcresult (handle (steamworkshop query)) (handle query) index buffer)
      (error "FIXME: failed to get details."))
    (cffi:mem-ref buffer '(:struct steam::steam-ugcdetails))))

(defmethod get-workshop-file ((query workshop-query) (index integer))
  (let* ((id (steam::steam-ugcdetails-published-file-id (get-details query index)))
         (file (make-instance 'workshop-file :steamworkshop (steamworkshop query)
                                             :app (app query)
                                             :handle id)))
    (complete-from-query file query index)
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

(defclass workshop-detail-query (workshop-query)
  ())

(defmethod allocate-handle ((query workshop-detail-query) &key steamworkshop files)
  (cffi:with-foreign-object (buffer 'steam::published-file-id-t (length files))
    (loop for file in files
          for i from 0
          do (setf (cffi:mem-aref buffer 'steam::published-file-id-t i) (handle file)))
    (steam::ugc-create-query-ugcdetails-request
     (handle steamworkshop) buffer (length files))))

(defclass workshop-update (c-managed-object)
  ((steamworkshop :initarg :steamworkshop :reader steamworkshop)
   (workshop-file :initarg :workshop-file :reader workshop-file)
   (change-note :initarg :change-node :reader change-note :writer set-change-note)))

(defmethod initialize-instance :after ((update workshop-update) &key description metadata display-name language visibility preview content
                                                                     (previews () previews-p) (tags () tags-p) (key-value-tags () key-value-tags-p))
  (when description (set-description update description))
  (when metadata (set-metadata update metadata))
  (when display-name (set-display-name update display-name))
  (when language (set-language update language))
  (when visibility (set-visibility update visibility))
  (when preview (set-preview update preview))
  (when content (set-content update content))
  (when previews-p (set-previews update previews))
  (when tags-p (set-tags update tags))
  (when key-value-tags-p (set-key-value-tags update key-value-tags)))

(defmethod allocate-handle ((update workshop-update) &key steamworkshop workshop-file)
  (steam::ugc-start-item-update (handle steamworkshop) (handle (app workshop-file)) (handle workshop-file)))

(defmethod free-handle-function ((update workshop-update) handle)
  (let ((workshop (steamworkshop update)))
    (lambda () ;; WTF: There seems to be no equivalent release function?
      )))

(define-interface-submethod steamworkshop workshop-update set-metadata (steam::ugc-set-item-metadata metadata))
(define-interface-submethod steamworkshop workshop-update set-language (steam::ugc-set-item-update-language language))
(define-interface-submethod steamworkshop workshop-update set-visibility (steam::ugc-set-item-visibility visibility))

(defmethod set-display-name ((update workshop-update) display-name)
  (when (< steam::published-document-title-max (length display-name))
    (error "FIXME: new display name is too long."))
  (steam::ugc-set-item-title (handle (steamworkshop update)) (handle update) display-name))

(defmethod set-description ((update workshop-update) description)
  (when (< steam::published-document-description-max (length description))
    (error "FIXME: new description is too long."))
  (steam::ugc-set-item-description (handle (steamworkshop update)) (handle update) description))

(defmethod set-preview ((update workshop-update) file)
  (unless (find (pathname-type file) '("png" "jpg" "jpeg" "gif" "svg") :test #'string=)
    (error "FIXME: preview file must be an image."))
  (steam::ugc-set-item-preview (handle (steamworkshop update)) (handle update) file))

(defmethod set-tags ((update workshop-update) tags)
  (let ((tagcount (length thags)))
    (dolist (tag tags)
      (when (< 255 (length tag))
        (error "FIXME: The tag ~s is too long." tag))
      (when (loop for char across tag
                  thereis (or (char= char #\,)
                              (not (printable-char-p char))))
        (error "FIXME: The tag ~s contains prohibited characters." tag)))
    (cffi:with-foreign-objects ((stringptr :pointer tagcount)
                                (strings :char (* 255 tagcount))
                                (struct '(:struct steam::steam-param-string-array)))
      (setf (cffi:foreign-slot-value struct '(:struct steam::steam-param-string-array) 'steam::strings) strings)
      (setf (cffi:foreign-slot-value struct '(:struct steam::steam-param-string-array) 'steam::num-strings) tagcount)
      (loop for tag in tags
            for i from 0
            for foreign-string = (cffi:inc-pointer strings (* i 255))
            do (cffi:lisp-string-to-foreign tag foreign-string 255 :encoding :utf-8)
               (setf (cffi:mem-aref stringptr :pointer i) foreign-string))
      (steam::ugc-set-item-tags (handle (steamworkshop update)) (handle update) struct))))

(defmethod set-content ((update workshop-update) directory)
  (let ((directory (pathname directory)))
    (when (or (pathname-name directory) (pathname-type directory))
      (error "FIXME: need to pass a directory."))
    (steam::ugc-set-item-content (handle (steamworkshop update)) (handle update) (namestring directory))))

(defmethod set-previews ((update workshop-update) previews)
  (let* ((workshop (handle (steamworkshop update)))
         (handle (handle update))
         (previous-previews (previews (workshop-file update))))
    (flet ((index (list) (getf list :index)))
      (loop for preview in previews
            for value = (getf preview :source)
            for type = (getf preview :type)
            unless (getf preview :index)
            do (case type
                 (:you-tube-video
                  (steam::ugc-add-item-preview-video workshop handle value))
                 (:image
                  (steam::ugc-add-item-preview-file workshop handle (namestring value) :image))
                 (T
                  (steam::ugc-add-item-preview-file workshop handle (princ-to-string value) type))))
      (loop for preview in previews
            for index = (getf preview :index)
            for value = (getf preview :source)
            for type = (getf preview :type)
            when (and (getf preview :index)
                      (not (equal value (getf (find index previous-previews :key #'index) :source))))
            do (case type
                 (:you-tube-video
                  (steam::ugc-update-item-preview-video workshop handle index value))
                 (T
                  (steam::ugc-update-item-preview-file workshop handle index (namestring value)))))
      (loop for preview in previous-previews
            for index = (getf preview :index)
            when (not (find index previews :key #'index))
            do (steam::ugc-remove-item-preview workshop handle (getf preview :index))))))

(defmethod set-key-value-tags ((update workshop-update) key-value-tags)
  (let* ((workshop (handle (steamworkshop update)))
         (handle (handle update))
         (previous (key-value-tags (workshop-file update)))
         (to-add (set-difference key-value-tags previous :test #'equal))
         (to-remove (set-difference previous key-value-tags :test #'equal)))
    (when (< 100 (length to-remove))
      (error "FIXME: cannot remove more than 100 in one update."))
    (loop for (key . value) in to-add
          do (when (< 255 (length key))
               (error "FIXME: key too long."))
             (when (< 255 (length value))
               (error "FIXME: value too long."))
             (when (loop for c across key
                         thereis (not (or (alphanumericp c)
                                          (char= #\_ c))))
               (error "FIXME: invalid key"))
             (steam::ugc-add-item-key-value-tag workshop handle key value))
    (loop for (key . value) in to-remove
          do (steam::ugc-remove-item-key-value-tags workshop handle key))))

(defmethod execute ((update workshop-update) &key callback)
  (flet ((complete (result)
           (with-error-on-failure (steam::submit-item-update-result result))
           (steam::submit-item-update-user-needs-to-accept-workshop-legal-agreement result)))
    (with-call-result (result :poll (null callback))
        (steam::ugc-submit-item-update (handle (steamworkshop update)) (handle update)
                                       (or (change-note update) (cffi:null-pointer)))
      (funcall (or callback #'complete) result))))

(defmethod update-status ((update workshop-update))
  (cffi:with-foreign-objects ((processed :uint64)
                              (total :uint64))
    (when (steam::ugc-get-item-update-progress (handle (steamworkshop update)) (handle update) processed total)
      (list :processed (cffi:mem-ref processed :uint64)
            :total (cffi:mem-ref total :uint64)))))

(defclass file (c-object)
  ((display-name :initarg :display-name :reader display-name)
   (size :initarg :size :reader size)))

(defclass workshop-file (c-object)
  ((app :initarg :app :reader app)
   (steamworkshop :initarg :steamworkshop :reader steamworkshop)
   ;; caches
   kind consumer display-name description owner created updated added visibility
   banned-p accepted-for-use-p tags file preview url votes-up votes-down score
   previews metadata statistics app-dependencies file-dependencies key-value-tags))

(defmethod initialize-instance :after ((file workshop-file) &key steamworkshop app kind)
  (unless app (error "APP required."))
  (unless (handle file)
    (with-call-result (result :poll T) (steam::ugc-create-item (handle steamworkshop) (handle app) kind)
      (when (steam::create-item-user-needs-to-accept-workshop-legal-agreement result)
        (warn "FIXME: user needs to accept agreement."))
      (with-error-on-failure (steam::create-item-result result))
      (setf (handle file) (steam::create-item-published-file-id result)))))

(macrolet ((make-cache-filled (slot)
             `(defmethod ,slot ((file workshop-file))
                (unless (slot-boundp file ',slot)
                  (complete-from-query file T))
                (slot-value file ',slot)))
           (make-all-cache-filled (&rest slots)
             `(progn ,@(loop for slot in slots collect `(make-cache-filled ,slot)))))
  (make-all-cache-filled kind consumer display-name description owner created updated added visibility
                         banned-p accepted-for-use-p tags file preview url votes-up votes-down score
                         previews metadata statistics file-dependencies key-value-tags))

(macrolet ((make-updatable (slot)
             `(defmethod (setf ,slot) (value (file workshop-file))
                (let ((update (make-instance 'workshop-update :steamworkshop (steamworkshop file)
                                                              :workshop-file file
                                             ,(intern (string slot) "KEYWORD") value)))
                  (execute update)
                  (setf (slot-value file ',slot) value))))
           (make-all-updatable (&rest slots)
             `(progn ,@(loop for slot in slots collect `(make-updatable ,slot)))))
  (make-all-updatable display-name description visibility tags preview content previews metadata
                      key-value-tags))

(defmethod clear-cache ((file workshop-file))
  (dolist (slot '(kind consumer display-name description owner created updated added visibility
                  banned-p accepted-for-use-p tags file preview url votes-up votes-down score
                  metadata statistics app-dependencies file-dependencies key-value-tags))
    (slot-makunbound file slot)))

(define-interface-submethod steamworkshop workshop-file download (steam::ugc-download-item &key high-priority))
(define-interface-submethod steamworkshop workshop-file state (steam::ugc-get-item-state)
  (decode-flags 'steam::eitem-state result))

(defmethod start-tracking ((files list))
  (cffi:with-foreign-object (buffer 'steam::published-file-id-t 100)
    (loop while files
          for batch = (min 100 (length files))
          for workshop = (handle (steamworkshop (first files)))
          do (loop for i from 0 below batch
                   for file = (pop files)
                   do (setf (cffi:mem-aref buffer 'steam::published-file-id-t i) (handle file)))
             (with-call-result (result :poll T) (steam::ugc-start-playtime-tracking workshop buffer batch)
               (with-error-on-failure (steam::start-playtime-tracking-result result))))))

(defmethod stop-tracking ((files list))
  (cffi:with-foreign-object (buffer 'steam::published-file-id-t 100)
    (loop while files
          for batch = (min 100 (length files))
          for workshop = (handle (steamworkshop (first files)))
          do (loop for i from 0 below batch
                   for file = (pop files)
                   do (setf (cffi:mem-aref buffer 'steam::published-file-id-t i) (handle file)))
             (with-call-result (result :poll T) (steam::ugc-stop-playtime-tracking workshop buffer batch)
               (with-error-on-failure (steam::stop-playtime-tracking-result result))))))

(defmethod start-tracking ((file workshop-file))
  (start-tracking (list file)))

(defmethod stop-tracking ((file workshop-file))
  (stop-tracking (list file)))

(defmethod (setf file-dependencies) (values (file workshop-file))
  (let* ((workshop (handle (steamworkshop file)))
         (previous (file-dependencies file))
         (to-add (set-difference values previous))
         (to-remove (set-difference previous values)))
    (dolist (dependency to-add)
      (steam::ugc-add-dependency workshop (handle file) (handle dependency)))
    (dolist (dependency to-remove)
      (steam::ugc-remove-dependency workshop (handle file) (handle dependency)))
    (setf (slot-value file 'file-dependencies) values)))

(defmethod app-dependencies ((file workshop-file))
  (unless (slot-boundp file 'app-dependencies)
    (with-call-result (result :poll T) (steam::ugc-get-app-dependencies (handle (steamworkshop file)) (handle file))
      (with-error-on-failure (steam::get-app-dependencies-result result))
      ;; TODO: there's a "total num" field. Does this mean it can return less than
      ;;       everything? If so, how do I get the rest? There's no explicit pagination.
      ;;       does it split it across multiple call results? If so that's real bad...
      (loop with ptr = (struct-slot-ptr result 'steam::app-ids)
            for i from 0 below (steam::get-app-dependencies-num-app-dependencies result)
            collect (make-instance 'app :steamapps (interface 'steamapps (steamworks (steamworkshop file)))
                                        :handle (cffi:mem-aref ptr 'steam::app-id-t i))
            into results
            finally (setf (slot-value file 'app-dependencies) results))))
  (slot-value file 'app-dependencies))

(defmethod (setf app-dependencies) (values (file workshop-file))
  (let* ((workshop (handle (steamworkshop file)))
         (previous (app-dependencies file))
         (to-add (set-difference values previous))
         (to-remove (set-difference previous values)))
    (dolist (dependency to-add)
      (steam::ugc-add-app-dependency workshop (handle file) (handle dependency)))
    (dolist (dependency to-remove)
      (steam::ugc-remove-app-dependency workshop (handle file) (handle dependency)))
    (setf (slot-value file 'app-dependencies) values)))

(defmethod favorite ((file workshop-file))
  (with-call-result (result :poll T) (steam::ugc-add-item-to-favorites (handle (steamworkshop file)) (app-id (app file)) (handle file))
    (with-error-on-failure (steam::user-favorite-items-list-changed-result result))))

(defmethod unfavorite ((file workshop-file))
  (with-call-result (result :poll T) (steam::ugc-remove-item-from-favorites (handle (steamworkshop file)) (app-id (app file)) (handle file))
    (with-error-on-failure (steam::user-favorite-items-list-changed-result result))))

(defmethod destroy ((file workshop-file))
  (with-call-result (result :poll T) (steam::ugc-delete-item (handle (steamworkshop file)) (handle file))
    (with-error-on-failure (steam::delete-item-result result))))

(defmethod subscribe ((file workshop-file))
  (with-call-result (result :poll T) (steam::ugc-subscribe-item (handle (steamworkshop file)) (handle file))
    (with-error-on-failure (steam::remote-storage-subscribe-published-file-result result))))

(defmethod unsubscribe ((file workshop-file))
  (with-call-result (result :poll T) (steam::ugc-unsubscribe-item (handle (steamworkshop file)) (handle file))
    (with-error-on-failure (steam::remote-storage-unsubscribe-published-file-result result))))

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
          ((steam::get-user-item-vote-vote-skipped result) :skipped)
          (T :unknown))))

(defmethod complete-from-query ((file workshop-file) (query workshop-query) &optional (index 0))
  (let ((steamapps (interface 'steamapps (steamworks (steamworkshop file))))
        (steamfriends (interface 'steamfriends (steamworks (steamworkshop file)))))
    (let ((details (get-details query index)))
      (macrolet ((sets (slot function &optional (transform 'result))
                   `(setf (slot-value file ',slot)
                          (let ((result (,function details)))
                            ,transform))))
        (sets handle steam::steam-ugcdetails-published-file-id)
        (sets kind steam::steam-ugcdetails-file-type)
        (sets consumer steam::steam-ugcdetails-consumer-app-id
              (make-instance 'app :steamapps steamapps :handle result))
        (sets display-name steam::steam-ugcdetails-title)
        (sets description steam::steam-ugcdetails-description)
        (sets owner steam::steam-ugcdetails-steam-idowner
              (make-instance 'friend :steamfriends steamfriends :handle result))
        (sets created steam::steam-ugcdetails-created
              (unix->universal result))
        (sets updated steam::steam-ugcdetails-updated
              (unix->universal result))
        (sets added steam::steam-ugcdetails-added-to-user-list
              (unix->universal result))
        (sets visibility steam::steam-ugcdetails-visibility)
        (sets banned-p steam::steam-ugcdetails-banned)
        (sets accepted-for-use-p steam::steam-ugcdetails-accepted-for-use)
        (sets tags steam::steam-ugcdetails-tags
              (split-string result #\,))
        (sets file steam::steam-ugcdetails-file
              (make-instance 'file :handle result
                                   :name (steam::steam-ugcdetails-file-name details)
                                   :size (steam::steam-ugcdetails-file-size details)))
        (sets preview steam::steam-ugcdetails-preview-file
              (make-instance 'file :handle result
                                   :size (steam::steam-ugcdetails-preview-file-size details)))
        (sets url steam::steam-ugcdetails-url)
        (sets votes-up steam::steam-ugcdetails-votes-up)
        (sets votes-down steam::steam-ugcdetails-votes-down)
        (sets score steam::steam-ugcdetails-score))
      (let ((previews (get-previews query index)))
        (setf (slot-value file 'previews) previews))
      (let ((children (get-children query index (steam::steam-ugcdetails-num-children details))))
        (setf (slot-value file 'file-dependencies) children))
      (let ((key-value-tags (get-key-value-tags query index)))
        (setf (slot-value file 'key-value-tags) key-value-tags))
      (let ((metadata (get-metadata query index)))
        (setf (slot-value file 'metadata) metadata))
      (let ((statistics (get-statistics query index)))
        (setf (slot-value file 'statistics) statistics))))
  file)

(defmethod complete-from-query ((file workshop-file) (query (eql T)) &optional (index 0))
  (declare (ignore index))
  (let ((query (make-instance 'workshop-detail-query :steamworkshop (steamworkshop file)
                                                     :app (app file)
                                                     :files (list file))))
    (execute query)
    (complete-from-query file query)))
