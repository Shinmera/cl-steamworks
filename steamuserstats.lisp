#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamuserstats (interface)
  ((current-stats :initform NIL :accessor current-stats-available-p)
   (global-stats :initform 0 :accessor global-stats-days-available)
   (user-stats :initform (make-hash-table :test 'eql) :accessor user-stats-available-cache)
   (global-percentages :initform NIL :accessor global-percentages-available-p)))

(defmethod initialize-instance :after ((interface steamuserstats) &key (version T) steamworks)
  (setf (handle interface) (get-interface-handle* steamworks 'steam::client-get-isteam-user-stats
                                                  (t-or version STEAM::STEAMUSERSTATS-INTERFACE-VERSION))))

(define-interface-method steamuserstats player-count (steam::user-stats-get-number-of-current-players))
(define-interface-method steamuserstats store-stats (steam::user-stats-store-stats)
  (check-invalid NIL result 'steam::user-stats-store-stats))

(define-callback steam::user-stats-received (_ result)
  (when (eql :ok result)
    (setf (current-stats-available-p (interface 'steamuserstats T)) T)))

(defmethod list-achievements ((interface steamuserstats))
  (ensure-current-stats interface)
  (loop for i from 0 below (steam::user-stats-get-num-achievements (handle interface))
        for handle = (steam::user-stats-get-achievement-name (handle interface) i)
        collect (ensure-iface-obj 'achievement :interface interface :handle handle)))

;; FIXME: restarts that run callbacks and retry
(defun ensure-current-stats (interface &key force)
  ;; KLUDGE: FUCK, we can't poll for this, so the other ensure-* calls won't work right.
  (when (or force (null (current-stats-available-p interface)))
    (with-invalid-check NIL (steam::user-stats-request-current-stats (handle interface)))
    (warn 'user-stats-not-ready)))

(defun ensure-global-stats (interface &key force days)
  (when (or force (< (global-stats-days-available interface) days))
    (ensure-current-stats interface :force force)
    (with-call-result (result :poll T) (steam::user-stats-request-global-stats (handle interface) days)
      (check-result (steam::global-stats-received-result result)
                    'steam::user-stats-request-global-stats))
    (setf (global-stats-days-available interface) days)))

(defun ensure-global-percentages (interface &key force)
  (when (or force (null (global-percentages-available-p interface)))
    (ensure-current-stats interface :force force)
    (with-call-result (result :poll T) (steam::user-stats-request-global-achievement-percentages (handle interface))
      (check-result (steam::global-achievement-percentages-ready-result result)
                    'steam::user-stats-request-global-achievement-percentages))
    (setf (global-percentages-available-p interface) T)))

(defun ensure-user-stats (interface user &key force)
  (when (or force (null (gethash (steam-id user) (user-stats-available-cache interface))))
    (ensure-current-stats interface :force force)
    (with-call-result (result :poll T) (steam::user-stats-request-user-stats (handle interface) (steam-id user))
      (check-result (steam::user-stats-received-result result)
                    'steam::user-stats-request-user-stats))
    (setf (gethash (steam-id user) (user-stats-available-cache interface)) T)))

(defmethod most-achieved ((interface steamuserstats) &key (max 100))
  (ensure-global-percentages interface)
  (cffi:with-foreign-objects ((name :char 128)
                              (percent :float)
                              (achieved :bool))
    (let ((iterator (with-invalid-check -1 (steam::user-stats-get-most-achieved-achievement-info (handle interface) name 128 percent achieved)))
          (list ()))
      (flet ((commit ()
               (let ((handle (cffi:foreign-string-to-lisp name :count 128 :encoding :utf-8)))
                 (push (ensure-iface-obj 'achievement :interface interface :handle handle) list))))
        (loop while (/= -1 iterator)
              repeat max
              do (commit)
                 (steam::user-stats-get-next-most-achieved-achievement-info (handle interface) iterator name 128 percent achieved))
        (nreverse list)))))

(defmethod reset-stats ((interface steamuserstats) &key achievements)
  (with-invalid-check NIL (steam::user-stats-reset-all-stats (handle interface) achievements)))

(defmethod leaderboard ((name string) (interface steamuserstats) &key (if-does-not-exist :error)
                                                                      (sort-method :ascending)
                                                                      (display-type :nubmeric))
  (check-utf8-size STEAM::LEADERBOARD-NAME-MAX name)
  (ecase if-does-not-exist
    (:error
     (with-call-result (result :poll T) (steam::user-stats-find-leaderboard (handle interface) name)
       (check-invalid 0 (steam::leaderboard-find-leaderboard-found result) 'steam::user-stats-find-leaderboard)
       (ensure-iface-obj 'leaderboard :interface interface :handle (steam::leaderboard-find-steam-leaderboard result))))
    (:create
     (with-call-result (result :poll T) (steam::user-stats-find-or-create-leaderboard (handle interface) name sort-method display-type)
       (ensure-iface-obj 'leaderboard :interface interface :handle (steam::leaderboard-find-steam-leaderboard result))))))

(defclass stat (interface-object)
  ((stat-type :initarg :stat-type :initform 'integer :reader stat-type))
  (:default-initargs :interface 'steamuserstats))

(defmethod stat-history ((stat stat) &key (days 7))
  (ensure-global-stats (iface stat))
  (cffi:with-foreign-object (data :int64 days)
    (let ((count (ecase (stat-type stat)
                   (integer (steam::user-stats-get-global-stat-history (iface* stat) (handle stat) data (* days 8)))
                   (float (steam::user-stats-get-global-stat-history0 (iface* stat) (handle stat) data (* days 8))))))
      (check-invalid 0 count 'steam::user-stats-get-global-stat-history)
      (ecase (stat-type stat)
        (integer (loop for i from 0 below count
                       collect (cffi:mem-aref data :int64 i)))
        (float (loop for i from 0 below count
                     collect (cffi:mem-aref data :double i)))))))

(defmethod stat-value ((stat stat) &key (for :global))
  (etypecase for
    ((eql :global) (ensure-global-stats (iface stat)))
    ((eql :local) (ensure-current-stats (iface stat)))
    (friend (ensure-user-stats (iface stat) for)))
  (cffi:with-foreign-object (data :int64)
    (ecase (stat-type stat)
      (integer (etypecase for
                 ((eql :global)
                  (with-invalid-check NIL (steam::user-stats-get-global-stat (iface* stat) (handle stat) data)))
                 ((eql :local)
                  (with-invalid-check NIL (steam::user-stats-get-stat (iface* stat) (handle stat) data)))
                 (friend
                  (with-invalid-check NIL (steam::user-stats-get-user-stat (iface* stat) (steam-id for) (handle stat) data)))))
      (float (etypecase for
               ((eql :global)
                (with-invalid-check NIL (steam::user-stats-get-global-stat0 (iface* stat) (handle stat) data)))
               ((eql :local)
                (with-invalid-check NIL (steam::user-stats-get-stat0 (iface* stat) (handle stat) data)))
               (friend
                (with-invalid-check NIL (steam::user-stats-get-user-stat0 (iface* stat) (steam-id for) (handle stat) data))))))
    (case for
      (:global
       (ecase (stat-type stat)
         (integer (cffi:mem-ref data :int64))
         (float (cffi:mem-ref data :double))))
      (T
       (ecase (stat-type stat)
         (integer (cffi:mem-ref data :int32))
         (float (cffi:mem-ref data :float)))))))

(defmethod (setf stat-value) (value (stat stat) &key sync)
  (ensure-current-stats (iface stat))
  (check-invalid NIL (etypecase value
                       (integer (steam::user-stats-set-stat (iface* stat) (handle stat) value))
                       (float (steam::user-stats-set-stat0 (iface* stat) (handle stat) (coerce value 'single-float))))
                 'steam::user-stats-set-stat)
  (when sync
    (store-stats (iface stat)))
  value)

(defclass achievement (interface-object)
  ()
  (:default-initargs :interface 'steamuserstats))

(define-interface-submethod achievement icon (steam::user-stats-get-achievement-icon)
  (check-invalid 0 result 'steam::user-stats-get-achievement-icon)
  (make-instance 'image :interface (interface 'steamutils achievement) :handle result))
(define-interface-submethod achievement show-progress (steam::user-stats-indicate-achievement-progress progress total)
  (check-invalid NIL result 'steam::user-stats-indicate-achievement-progress))

(defmethod display-name ((achievement achievement))
  (with-invalid-check "" (steam::user-stats-get-achievement-display-attribute (iface* achievement) (handle achievement) "name")))

(defmethod description ((achievement achievement))
  (with-invalid-check "" (steam::user-stats-get-achievement-display-attribute (iface* achievement) (handle achievement) "desc")))

(defmethod hidden-p ((achievement achievement))
  (string= (with-invalid-check "" (steam::user-stats-get-achievement-display-attribute (iface* achievement) (handle achievement) "hidden"))
           "1"))

(defmacro define-achievement-method (name (method &rest args) &body body)
  `(defmethod ,name ((achievement achievement))
     (cffi:with-foreign-objects ,args
       (with-invalid-check NIL (,method (iface* achievement) (handle achievement) ,@(mapcar #'first args)))
       (let ,(loop for (var type) in args
                   collect `(,var (cffi:mem-ref ,var ,type)))
         ,@(or body (list (car (first args))))))))

(defmethod achieved-p ((achievement achievement) &optional user)
  (cffi:with-foreign-object (achieved-p :bool)
    (if user
        (with-invalid-check NIL (steam::user-stats-get-user-achievement (iface* achievement) (steam-id user) (handle achievement) achieved-p))
        (with-invalid-check NIL (steam::user-stats-get-achievement (iface* achievement) (handle achievement) achieved-p)))
    (cffi:mem-ref achieved-p :bool)))

(defmethod (setf achieved-p) (value (achievement achievement) &key sync)
  (if value
      (with-invalid-check NIL (steam::user-stats-set-achievement (iface* achievement) (handle achievement)))
      (with-invalid-check NIL (steam::user-stats-clear-achievement (iface* achievement) (handle achievement))))
  (when sync
    (store-stats (iface achievement)))
  value)

(defmethod (setf achieved-p) (value (string string) &key sync)
  (let ((interface (interface 'steamuserstats T)))
    (if value
        (with-invalid-check NIL (steam::user-stats-set-achievement (handle interface) string))
        (with-invalid-check NIL (steam::user-stats-clear-achievement (handle interface) string)))
    (when sync
      (store-stats interface))
    value))

(defmethod unlock-time ((achievement achievement) &optional user)
  (cffi:with-foreign-objects ((achieved-p :bool)
                              (time :uint32))
    (if user
        (with-invalid-check NIL (steam::user-stats-get-user-achievement-and-unlock-time (iface* achievement) (steam-id user) (handle achievement) achieved-p time))
        (with-invalid-check NIL (steam::user-stats-get-achievement-and-unlock-time (iface* achievement) (handle achievement) achieved-p time)))
    (unix->universal (cffi:mem-ref time :uint32))))

(defmethod achieved-percentage ((stat stat))
  (with-foreign-value (percentage :float)
    (with-invalid-check NIL (steam::user-stats-get-achievement-achieved-percent (iface* stat) (handle stat) percentage))))

(defclass leaderboard (interface-object)
  ()
  (:default-initargs :interface 'steamuserstats))

(define-interface-submethod leaderboard display-type (steam::user-stats-get-leaderboard-display-type))
(define-interface-submethod leaderboard entry-count (steam::user-stats-get-leaderboard-entry-count))
(define-interface-submethod leaderboard display-name (steam::user-stats-get-leaderboard-name))
(define-interface-submethod leaderboard sort-method (steam::user-stats-get-leaderboard-sort-method))

(defmethod (setf ugc) ((ugc ugc) (leaderboard leaderboard))
  (with-call-result (result :poll T) (steam::user-stats-attach-leaderboard-ugc (iface* leaderboard) (handle leaderboard) (handle ugc))
    (check-result (steam::leaderboard-ugcset-result result)
                  'steam::user-stats-attach-leaderboard-ugc)))

(defun decode-leaderboard-entries (iface result)
  (cffi:with-foreign-object (entry '(:struct steam::leaderboard-entry))
    (loop with entries = (steam::leaderboard-scores-downloaded-steam-leaderboard-entries result)
          for i from 0 below (steam::leaderboard-scores-downloaded-entry-count result)
          do (with-invalid-check NIL (steam::user-stats-get-downloaded-leaderboard-entry iface entries i entry (cffi:null-pointer) 0))
          collect (cffi:mem-aref entry '(:struct steam::leaderboard-entry)))))

(defmethod entries ((leaderboard leaderboard) type &key (start 0) (end 100) users)
  (case type
    (:users
     (cffi:with-foreign-object (array 'steam::steam-id (length users))
       (loop for i from 0
             for user in users
             do (setf (cffi:mem-aref array 'steam::steam-id i) (steam-id user)))
       (with-call-result (result :poll T) (steam::user-stats-download-leaderboard-entries-for-users (iface* leaderboard) (handle leaderboard) array (length users))
         (decode-leaderboard-entries (iface* leaderboard) result))))
    (T
     (with-call-result (result :poll T) (steam::user-stats-download-leaderboard-entries (iface* leaderboard) (handle leaderboard) type start end)
       (decode-leaderboard-entries (iface* leaderboard) result)))))

(defmethod (setf score) (score (leaderboard leaderboard) &key (replace :if-better))
  (with-call-result (result :poll T) (steam::user-stats-upload-leaderboard-score (iface* leaderboard) (handle leaderboard)
                                                                                 (ecase replace
                                                                                   (:if-better :keep-best)
                                                                                   (:always :force-update))
                                                                                 score (cffi:null-pointer) 0)
    (with-invalid-check 0 (steam::leaderboard-score-uploaded-success result))
    (values score
            (steam::leaderboard-score-uploaded-score-changed result)
            (steam::leaderboard-score-uploaded-global-rank-previous result)
            (steam::leaderboard-score-uploaded-global-rank-new result))))
