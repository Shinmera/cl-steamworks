(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamworkshop (interface)
  ())

(defmethod initialize-instance :after ((interface steamworkshop) &key (version T) steamworks content-directory)
  (setf (handle interface) (get-interface-handle steamworks 'steam::client-get-isteam-ugc
                                                 (handle (user steamworks)) (handle (pipe steamworks))
                                                 (t-or version STEAM::STEAMUGC-INTERFACE-VERSION)))
  (when content-directory
    (with-invalid-check NIL (steam::ugc-binit-workshop-for-game-server (handle interface) (server-depot steamworks)
                                                                       (namestring content-directory)))))

(define-interface-method steamworkshop (setf downloads-suspended-p) (value steam::ugc-suspend-downloads))

(defmethod list-subscribed-files ((workshop steamworkshop))
  (let ((count (steam::ugc-get-num-subscribed-items (handle workshop))))
    (cffi:with-foreign-object (buffer 'steam::published-file-id count)
      (loop for i from 0 below (steam::ugc-get-subscribed-items (handle workshop) buffer count)
            for handle = (cffi:mem-aref buffer 'steam::published-file-id i)
            collect (ensure-iface-obj 'workshop-file :interface workshop
                                                     :app (app (interface 'steamapps (steamworks workshop)))
                                                     :handle handle)))))

(defmethod query ((workshop steamworkshop) (app app) &rest args &key user list type sort on page exclude require key-value-tags request search any-tag rank-by-trend-days)
  (declare (ignore list type sort on page exclude require key-value-tags request search any-tag rank-by-trend-days))
  (query workshop (apply #'make-instance
                         (if user
                             'workshop-user-query
                             'workshop-global-query)
                         :interface workshop
                         :app app
                         args)))

(defmethod query ((workshop steamworkshop) mod &rest args &key (app T) files list type sort on page exclude require key-value-tags request search any-tag rank-by-trend-days)
  (declare (ignore list type sort on page exclude require key-value-tags request search any-tag rank-by-trend-days))
  (query workshop (apply #'make-instance
                         'workshop-detail-query
                         :interface workshop
                         :app app
                         :files (list* mod files)
                         args)))

(defmethod stop-tracking ((workshop steamworkshop))
  (with-call-result (result :poll T) (steam::ugc-stop-playtime-tracking-for-all-items (handle workshop))
    (check-result (steam::stop-playtime-tracking-result result)
                  'steam::ugc-stop-playtime-tracking-for-all-items)))

(defclass workshop-query (interface-object c-managed-object)
  ((app :initarg app :reader app))
  (:default-initargs :interface 'steamworkshop
                     :free-on-gc T))

(defmethod initialize-instance :after ((query workshop-query) &key files app sort page user exclude require key-value-tags request search any-tag rank-by-trend-days allow-cache)
  (declare (ignore app sort page files user))
  (setf (any-tag-matches-p query) any-tag)
  (setf (ranked-by-trend-days-p query) rank-by-trend-days)
  (when search
    (setf (search-text query) search))
  (dolist (tag exclude)
    (add-excluded-tag tag query))
  (dolist (tag require)
    (add-required-tag tag query))
  (loop for (key . value) in key-value-tags
        do (add-key-value-tag key value query))
  (setf (cached-response-allowed-p query) allow-cache)
  (setf (all-previews-requested-p query) (find :all-previews request))
  (setf (children-requested-p query) (find :children request))
  (setf (key-value-tags-requested-p query) (find :key-value-tags request))
  (setf (full-description-requested-p query) (find :full-description request))
  (setf (metadata-requested-p query) (find :metadata request))
  (setf (ids-only-p query) (find :ids-only request))
  (setf (playtime-stats-requested-p query) (find :playtime-stats request))
  (setf (totals-only-p query) (find :total-only request)))

(defmethod free-handle-function ((query workshop-query) handle)
  (let ((workshop (iface* query)))
    (lambda ()
      (steam::ugc-release-query-ugcrequest workshop handle))))

(define-interface-submethod workshop-query add-excluded-tag ((tag string) steam::ugc-add-excluded-tag)
  (check-invalid NIL result 'steam::ugc-add-excluded-tag))
(define-interface-submethod workshop-query add-required-tag ((tag string) steam::ugc-add-required-tag)
  (check-invalid NIL result 'steam::ugc-add-required-tag))
(define-interface-submethod workshop-query add-key-value-tag ((key string) (value string) steam::ugc-add-required-key-value-tag)
  (check-invalid NIL result 'steam::ugc-add-required-key-value-tag))
(define-interface-submethod workshop-query (setf cached-response-allowed-p) (max-age-in-seconds steam::ugc-set-allow-cached-response))
(define-interface-submethod workshop-query (setf cloud-file-name-filter) ((file-name string) steam::ugc-set-cloud-file-name-filter))
(define-interface-submethod workshop-query (setf any-tag-matches-p) (value steam::ugc-set-match-any-tag))
(define-interface-submethod workshop-query (setf ranked-by-trend-days-p) (value steam::ugc-set-ranked-by-trend-days))
(define-interface-submethod workshop-query (setf all-previews-requested-p) (value steam::ugc-set-return-additional-previews))
(define-interface-submethod workshop-query (setf children-requested-p) (value steam::ugc-set-return-children))
(define-interface-submethod workshop-query (setf key-value-tags-requested-p) (value steam::ugc-set-return-key-value-tags))
(define-interface-submethod workshop-query (setf full-description-requested-p) (value steam::ugc-set-return-long-description))
(define-interface-submethod workshop-query (setf metadata-requested-p) (value steam::ugc-set-return-metadata))
(define-interface-submethod workshop-query (setf ids-only-p) (value steam::ugc-set-return-only-ids))
(define-interface-submethod workshop-query (setf playtime-stats-requested-p) (value steam::ugc-set-return-playtime-stats))
(define-interface-submethod workshop-query (setf totals-only-p) (value steam::ugc-set-return-total-only))
(define-interface-submethod workshop-query (setf search-text) ((text string) steam::ugc-set-search-text))
(define-interface-submethod workshop-query (setf language) ((language string) steam::ugc-set-language))

(defmethod (setf ranked-by-trend-days-p) ((value symbol) (query workshop-query))
  (setf (ranked-by-trend-days-p query) (if value 1 0)))
(defmethod (setf playtime-stats-requested-p) ((value symbol) (query workshop-query))
  (setf (playtime-stats-requested-p query) (if value 1 0)))
(defmethod (setf cached-response-allowed-p) ((value symbol) (query workshop-query))
  (setf (cached-response-allowed-p query) (if value 1 0)))

(defmethod execute ((query workshop-query) &key callback)
  (flet ((default-callback (result)
           (check-result (steam::steam-ugcquery-completed-result result)
                         'steam::ugc-send-query-ugcrequest)
           (values (steam::steam-ugcquery-completed-num-results-returned result)
                   (steam::steam-ugcquery-completed-total-matching-results result))))
    (with-call-result (result :poll T) (steam::ugc-send-query-ugcrequest (iface* query) (handle query))
      (setf (handle query) (steam::steam-ugcquery-completed-handle result))
      (funcall (or callback #'default-callback) result))))

(defmethod query ((workshop steamworkshop) (query workshop-query) &rest args)
  (declare (ignore args))
  (unwind-protect
       (multiple-value-bind (count total) (execute query)
         (values
          (loop for i from 0 below count
                for handle = (steam::steam-ugcdetails-published-file-id (get-details query i))
                for file = (ensure-iface-obj 'workshop-file :interface workshop :app (app query) :handle handle)
                collect (complete-from-query file query i))
          total))
    (free query)))

(defmethod get-previews ((query workshop-query) (index integer))
  (cffi:with-foreign-objects ((source :char 256)
                              (original :char 256)
                              (kind 'steam::eitem-preview-type))
    (loop with workshop = (iface* query)
          with handle = (handle query)
          for i from 0 below (steam::ugc-get-query-ugcnum-additional-previews workshop handle index)
          when (steam::ugc-get-query-ugcadditional-preview workshop handle index i source 256 original 256 kind)
          collect (list :index i
                        :kind (cffi:mem-ref kind 'steam::eitem-preview-type)
                        :source (cffi:foreign-string-to-lisp source :count 256 :encoding :utf-8)
                        :original (cffi:foreign-string-to-lisp original :count 256 :encoding :utf-8)))))

(defmethod get-children ((query workshop-query) (index integer) count)
  (cffi:with-foreign-object (buffer 'steam::published-file-id count)
    (with-invalid-check NIL (steam::ugc-get-query-ugcchildren (iface* query) (handle query) index buffer count))
    (loop for i from 0 below count
          collect (ensure-iface-obj 'workshop-file :interface (iface query)
                                                   :handle (cffi:mem-aref buffer 'steam::published-file-id i)
                                                   :app (app query)))))

(defmethod get-key-value-tags ((query workshop-query) (index integer))
  (cffi:with-foreign-objects ((key :char 256)
                              (value :char 256))
    (loop with workshop = (iface* query)
          with handle = (handle query)
          for i from 0 below (steam::ugc-get-query-ugcnum-key-value-tags workshop handle index)
          when (steam::ugc-get-query-ugckey-value-tag workshop handle index i key 256 value 256)
          collect (cons (cffi:foreign-string-to-lisp key :count 256 :encoding :utf-8)
                        (cffi:foreign-string-to-lisp value :count 256 :encoding :utf-8)))))

(defmethod get-metadata ((query workshop-query) (index integer))
  (cffi:with-foreign-object (buffer :char 256)
    (with-invalid-check NIL (steam::ugc-get-query-ugcmetadata (iface* query) (handle query) index buffer 256))
    (cffi:foreign-string-to-lisp buffer :count 256 :encoding :utf-8)))

(defmethod get-statistics ((query workshop-query) (index integer))
  (cffi:with-foreign-object (buffer :uint64)
    (loop with workshop = (iface* query)
          with handle = (handle query)
          for type in (cffi:foreign-enum-keyword-list 'steam::eitem-statistic)
          when (steam::ugc-get-query-ugcstatistic workshop handle index type buffer)
          collect type and collect (cffi:mem-ref buffer :uint64))))

(defmethod get-details ((query workshop-query) (index integer))
  (with-foreign-value (buffer '(:struct steam::steam-ugcdetails))
    (with-invalid-check NIL (steam::ugc-get-query-ugcresult (iface* query) (handle query) index buffer))))

(defmethod get-workshop-file ((query workshop-query) (index integer))
  (let* ((id (steam::steam-ugcdetails-published-file-id (get-details query index)))
         (file (ensure-iface-obj 'workshop-file :interface (iface query)
                                                :app (app query)
                                                :handle id)))
    (complete-from-query file query index)
    file))

(defclass workshop-global-query (workshop-query)
  ())

(defmethod allocate-handle ((query workshop-global-query) &key app
                                                               (type :all)
                                                               (sort :ranked-by-publication-date)
                                                               (on :target)
                                                               (page 1))
  (steam::ugc-create-query-all-ugcrequest-page
   (iface* query) sort type
   (ecase on (:creator (app-id app)) (:target (app-id app)))
   (ecase on (:creator 0) (:target (app-id app)))
   page))

(defclass workshop-user-query (workshop-query)
  ())

(defmethod allocate-handle ((query workshop-user-query) &key app user
                                                             (list :subscribed)
                                                             (type :all)
                                                             (sort :creation-order-desc)
                                                             (on :target)
                                                             (page 1))
  (steam::ugc-create-query-user-ugcrequest
   (iface* query) (account-id (handle user)) list type sort
   (ecase on (:creator (app-id app)) (:target (app-id app)))
   (ecase on (:creator 0) (:target (app-id app)))
   page))

(defclass workshop-detail-query (workshop-query)
  ())

(defmethod allocate-handle ((query workshop-detail-query) &key files)
  (cffi:with-foreign-object (buffer 'steam::published-file-id (length files))
    (loop for file in files
          for i from 0
          do (setf (cffi:mem-aref buffer 'steam::published-file-id i) (handle file)))
    (steam::ugc-create-query-ugcdetails-request
     (iface* query) buffer (length files))))

(defclass workshop-update (interface-object c-managed-object)
  ((workshop-file :initarg :workshop-file :reader workshop-file)
   (change-note :initarg :change-node :initform NIL :accessor change-note))
  (:default-initargs :interface 'steamworkshop
                     :free-on-gc T))

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

(defmethod allocate-handle ((update workshop-update) &key workshop-file)
  (steam::ugc-start-item-update (iface* update) (handle (app workshop-file)) (handle workshop-file)))

(defmethod free-handle-function ((update workshop-update) handle)
  (lambda () ;; WTF: There seems to be no equivalent release function?
    ))

(define-interface-submethod workshop-update (setf metadata) (metadata steam::ugc-set-item-metadata))
(define-interface-submethod workshop-update (setf language) (language steam::ugc-set-item-update-language))
(define-interface-submethod workshop-update (setf visibility) (visibility steam::ugc-set-item-visibility))

(defmethod (setf display-name) ((display-name string) (update workshop-update))
  (check-utf8-size STEAM::PUBLISHED-DOCUMENT-TITLE-MAX display-name)
  (steam::ugc-set-item-title (iface* update) (handle update) display-name))

(defmethod (setf description) ((description string) (update workshop-update))
  (check-utf8-size STEAM::PUBLISHED-DOCUMENT-DESCRIPTION-MAX description)
  (steam::ugc-set-item-description (iface* update) (handle update) description))

(defmethod (setf preview) ((file pathname) (update workshop-update))
  (unless (find (pathname-type file) '("png" "jpg" "jpeg" "gif" "svg") :test #'string=)
    (error 'not-an-image-file :file-handle file))
  (steam::ugc-set-item-preview (iface* update) (handle update) file))

(defmethod (setf tags) (tags (update workshop-update))
  (let ((tagcount (length tags)))
    (dolist (tag tags)
      (check-utf8-size 255 tag)
      (when (loop for char across tag
                  thereis (or (char= char #\,)
                              (not (printable-char-p char))))
        (error 'string-malformed :malformed-string tag)))
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
      (steam::ugc-set-item-tags (iface* update) (handle update) struct))))

(defmethod (setf content) (directory (update workshop-update))
  (let ((directory (pathname directory)))
    (when (or (pathname-name directory) (pathname-type directory))
      (error 'pathname-not-a-directory :file-handle directory))
    (steam::ugc-set-item-content (iface* update) (handle update) (namestring directory))))

(defmethod (setf previews) (previews (update workshop-update))
  (let* ((workshop (iface* update))
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

(defmethod (setf key-value-tags) (key-value-tags (update workshop-update))
  (let* ((workshop (iface* update))
         (handle (handle update))
         (previous (key-value-tags (workshop-file update)))
         (to-add (set-difference key-value-tags previous :test #'equal))
         (to-remove (set-difference previous key-value-tags :test #'equal)))
    (when (< 100 (length to-remove))
      (error 'too-many-requests :request-limit 100))
    (loop for (key . value) in to-add
          do (check-utf8-size 255 key)
             (check-utf8-size 255 value)
             (when (loop for c across key
                         thereis (not (or (alphanumericp c)
                                          (char= #\_ c))))
               (error 'string-malformed :malformed-string key))
             (steam::ugc-add-item-key-value-tag workshop handle key value))
    (loop for (key . value) in to-remove
          do (steam::ugc-remove-item-key-value-tags workshop handle key))))

(defmethod execute ((update workshop-update) &key callback)
  (flet ((complete (result)
           (check-result (steam::submit-item-update-result result)
                         'steam::ugc-submit-item-update)
           (steam::submit-item-update-user-needs-to-accept-workshop-legal-agreement result)))
    (with-call-result (result :poll T) (steam::ugc-submit-item-update (iface* update) (handle update)
                                                                      (or (change-note update) (cffi:null-pointer)))
      (funcall (or callback #'complete) result))))

(defmethod update-status ((update workshop-update))
  (cffi:with-foreign-objects ((processed :uint64)
                              (total :uint64))
    (when (steam::ugc-get-item-update-progress (iface* update) (handle update) processed total)
      (list :processed (cffi:mem-ref processed :uint64)
            :total (cffi:mem-ref total :uint64)))))

(defclass workshop-file (interface-object)
  ((app :initarg :app :reader app)
   ;; caches
   kind consumer display-name description owner created updated added visibility
   banned-p accepted-for-use-p tags file preview url votes-up votes-down score
   previews metadata statistics app-dependencies file-dependencies key-value-tags))

(defmethod initialize-instance :after ((file workshop-file) &key app (kind :community))
  (unless app
    (setf app (app (interface 'steamapps (steamworks file)))))
  (setf (slot-value file 'app) app)
  (unless (handle file)
    (with-call-result (result :poll T) (steam::ugc-create-item (iface* file) (app-id app) kind)
      (when (steam::create-item-user-needs-to-accept-workshop-legal-agreement result)
        (warn 'workshop-agreement-not-accepted))
      (check-result (steam::create-item-result result)
                    'steam::ugc-create-item)
      (setf (handle file) (steam::create-item-published-file-id result))
      (setf (interface-object (handle file) (iface file)) file)
      (setf (slot-value file 'key-value-tags) ())
      (setf (slot-value file 'app-dependencies) ())
      (setf (slot-value file 'file-dependencies) ())
      (setf (slot-value file 'previews) ()))))

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
                (let ((update (make-instance 'workshop-update :interface (iface file)
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

(defgeneric download (thing &key &allow-other-keys))
(define-interface-submethod workshop-file download (steam::ugc-download-item &key high-priority))
(define-interface-submethod workshop-file state (steam::ugc-get-item-state)
  (decode-flags 'steam::eitem-state result))

(defmethod start-tracking ((files list))
  (cffi:with-foreign-object (buffer 'steam::published-file-id 100)
    (loop while files
          for batch = (min 100 (length files))
          for workshop = (iface* (first files))
          do (loop for i from 0 below batch
                   for file = (pop files)
                   do (setf (cffi:mem-aref buffer 'steam::published-file-id i) (handle file)))
             (with-call-result (result :poll T) (steam::ugc-start-playtime-tracking workshop buffer batch)
               (check-result (steam::start-playtime-tracking-result result)
                             'steam::ugc-start-playtime-tracking)))))

(defmethod stop-tracking ((files list))
  (cffi:with-foreign-object (buffer 'steam::published-file-id 100)
    (loop while files
          for batch = (min 100 (length files))
          for workshop = (iface* (first files))
          do (loop for i from 0 below batch
                   for file = (pop files)
                   do (setf (cffi:mem-aref buffer 'steam::published-file-id i) (handle file)))
             (with-call-result (result :poll T) (steam::ugc-stop-playtime-tracking workshop buffer batch)
               (check-result (steam::stop-playtime-tracking-result result)
                             'steam::ugc-stop-playtime-tracking)))))

(defmethod start-tracking ((file workshop-file))
  (start-tracking (list file)))

(defmethod stop-tracking ((file workshop-file))
  (stop-tracking (list file)))

(defmethod (setf file-dependencies) (values (file workshop-file))
  (let* ((workshop (iface* file))
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
    (with-call-result (result :poll T) (steam::ugc-get-app-dependencies (iface* file) (handle file))
      (check-result (steam::get-app-dependencies-result result)
                    'steam::ugc-get-app-dependencies)
      ;; WTF: there's a "total num" field. Does this mean it can return less than
      ;;      everything? If so, how do I get the rest? There's no explicit pagination.
      ;;      does it split it across multiple call results? If so that's real bad...
      (loop with ptr = (struct-slot-ptr result 'steam::app-ids)
            for i from 0 below (steam::get-app-dependencies-num-app-dependencies result)
            collect (ensure-iface-obj 'app :interface (interface 'steamapps file)
                                           :handle (cffi:mem-aref ptr 'steam::app-id i))
            into results
            finally (setf (slot-value file 'app-dependencies) results))))
  (slot-value file 'app-dependencies))

(defmethod (setf app-dependencies) (values (file workshop-file))
  (let* ((workshop (iface* file))
         (previous (app-dependencies file))
         (to-add (set-difference values previous))
         (to-remove (set-difference previous values)))
    (dolist (dependency to-add)
      (steam::ugc-add-app-dependency workshop (handle file) (handle dependency)))
    (dolist (dependency to-remove)
      (steam::ugc-remove-app-dependency workshop (handle file) (handle dependency)))
    (setf (slot-value file 'app-dependencies) values)))

(defmethod favorite ((file workshop-file))
  (with-call-result (result :poll T) (steam::ugc-add-item-to-favorites (iface* file) (app-id (app file)) (handle file))
    (check-result (steam::user-favorite-items-list-changed-result result)
                  'steam::ugc-add-item-to-favorites)))

(defmethod unfavorite ((file workshop-file))
  (with-call-result (result :poll T) (steam::ugc-remove-item-from-favorites (iface* file) (app-id (app file)) (handle file))
    (check-result (steam::user-favorite-items-list-changed-result result)
                  'steam::ugc-remove-item-from-favorites)))

(defmethod destroy ((file workshop-file))
  (with-call-result (result :poll T) (steam::ugc-delete-item (iface* file) (handle file))
    (check-result (steam::delete-item-result result)
                  'steam::ugc-delete-item)))

(defmethod subscribe ((file workshop-file))
  (with-call-result (result :poll T) (steam::ugc-subscribe-item (iface* file) (handle file))
    (check-result (steam::remote-storage-subscribe-published-file-result result)
                  'steam::ugc-subscribe-item)))

(defmethod unsubscribe ((file workshop-file))
  (with-call-result (result :poll T) (steam::ugc-unsubscribe-item (iface* file) (handle file))
    (check-result (steam::remote-storage-unsubscribe-published-file-result result)
                  'steam::ugc-unsubscribe-item)))

(defmethod download-status ((file workshop-file))
  (cffi:with-foreign-objects ((downloaded :uint64)
                              (total :uint64))
    (when (steam::ugc-get-item-download-info (iface* file) (handle file) downloaded total)
      (list :downloaded (cffi:mem-ref downloaded :uint64)
            :total (cffi:mem-ref total :uint64)))))

(defmethod installation-info ((file workshop-file))
  (cffi:with-foreign-objects ((size :uint64)
                              (folder :char 256)
                              (last-update :uint32))
    (when (steam::ugc-get-item-install-info (iface* file) (handle file) size folder 256 last-update)
      (list :size (cffi:mem-ref size :uint64)
            ;; KLUDGE: I'm actually unsure that parsing with UTF-8 is correct here.
            ;;         The code page on windows might be different for the FS...
            :directory (parse-namestring (cffi:foreign-string-to-lisp folder :count 256 :encoding :utf-8))
            :last-update (unix->universal (cffi:mem-ref last-update :uint32))))))

(defmethod vote ((file workshop-file))
  (with-call-result (result :poll T) (steam::ugc-get-user-item-vote (iface* file) (handle file))
    (check-result (steam::get-user-item-vote-result result)
                  'steam::ugc-get-user-item-vote)
    (cond ((steam::get-user-item-vote-voted-up result) :up)
          ((steam::get-user-item-vote-voted-down result) :down)
          ((steam::get-user-item-vote-vote-skipped result) :skipped)
          (T :unknown))))

(defmethod complete-from-query ((file workshop-file) (query workshop-query) &optional (index 0))
  (let ((steamapps (interface 'steamapps file))
        (steamfriends (interface 'steamfriends file))
        (steamremotestorage (interface 'steamremotestorage file)))
    (let ((details (get-details query index)))
      (macrolet ((sets (slot function &optional (transform 'result))
                   `(setf (slot-value file ',slot)
                          (let ((result (,function details)))
                            ,transform))))
        (sets handle steam::steam-ugcdetails-published-file-id)
        (sets kind steam::steam-ugcdetails-file-type)
        (sets consumer steam::steam-ugcdetails-consumer-app-id
              (ensure-iface-obj 'app :interface steamapps :handle result))
        (sets display-name steam::steam-ugcdetails-title)
        (sets description steam::steam-ugcdetails-description)
        (sets owner steam::steam-ugcdetails-steam-idowner
              (ensure-iface-obj 'friend :interface steamfriends :handle result))
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
              (ensure-iface-obj 'ugc :interface steamremotestorage :handle result))
        (sets preview steam::steam-ugcdetails-preview-file
              (ensure-iface-obj 'ugc :interface steamremotestorage :handle result))
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
  (let ((query (make-instance 'workshop-detail-query :interface (iface file)
                                                     :app (app file)
                                                     :files (list file))))
    (unwind-protect
         (progn
           (execute query)
           (complete-from-query file query index))
      (free query))))
