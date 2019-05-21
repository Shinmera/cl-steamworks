#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamuserstats (interface)
  ())

(defmethod initialize-instance :after ((interface steamuserstats) &key version steamworks)
  (setf (stats-handle interface) (get-interface-handle* steamworks 'steam::client-get-isteam-user-stats
                                                        (t-or version steam::steamuserstats-interface-version))))

(defmethod list-achievemetns ((interface steamuserstats))
  (loop for i from 0 below (steam::user-stats-get-num-achievements (handle interface))
        for handle = (steam::user-stats-get-achievement-name (handle interface) i)
        collect (make-instance 'achievement :interface interface :handle handle)))

(define-interface-method steamuserstats player-count (steam::user-stats-get-number-of-current-players))

;; FIXME: global achievement
;; FIXME: Stats

(defclass achievement (interface-object)
  ()
  (:default-initargs :interface 'steamuserstats))

(define-interface-submethod achievement icon (steam::user-stats-get-achievement-icon)
  (check-invalid 0 result "FIXME: failed")
  (make-instance 'image :handle result))

(defmethod display-name ((achievement achievement))
  (check-empty-string (steam::user-stats-get-achievement-display-attribute (iface* achievement) (handle achievement) "name")
                      "FIXME: failed"))

(defmethod description ((achievement achievement))
  (check-empty-string (steam::user-stats-get-achievement-display-attribute (iface* achievement) (handle achievement) "desc")
                      "FIXME: failed"))

(defmethod hidden-p ((achievement achievement))
  (string= (check-empty-string (steam::user-stats-get-achievement-display-attribute (iface* achievement) (handle achievement) "hidden")
                               "FIXME: failed")
           "1"))

(defmacro define-achievement-method (name (method &rest args) &body body)
  `(defmethod ,name ((achievement achievement))
     (cffi:with-foreign-objects ,args
       (unless (,method (iface* achievement) (handle achievement) ,@(mapcar #'first args))
         (error "FIXME: failed"))
       (let ,(loop for (var type) in args
                   collect `(,var (cffi:mem-ref ,var ,type)))
         ,@(or body (list (car (first args))))))))

(defmethod achieved-p ((achievement achievement) &optional user)
  (cffi:with-foreign-object (achieved-p :bool)
    (unless (if user
                (steam::user-stats-get-user-achievement (iface* achievement) (steam-id user) (handle achievement) achieved-p)
                (steam::user-stats-get-achievement (iface* achievement) (handle achievement) achieved-p))
      (error "FIXME: failed"))
    (cffi:mem-ref achieved-p :bool)))

(defmethod (setf achieved-p) (value (achievement achievement))
  (unless (if value
              (steam::user-stats-set-achievement (iface* achievement) (handle achievement))
              (steam::user-stats-clear-achievement (iface* achievement) (handle achievement)))
    (error "FIXME: failed"))
  value)

(defmethod unlock-time ((achievement achievement) &optional user)
  (cffi:with-foreign-object ((achieved-p :bool)
                             (time :uint32))
    (unless (if user
                (steam::user-stats-get-user-achievement-and-unlock-time (iface* achievement) (steam-id user) (handle achievement) achieved-p time)
                (steam::user-stats-get-achievement-and-unlock-time (iface* achievement) (handle achievement) achieved-p time))
      (error "FIXME: failed"))
    (unix->universal (cffi:mem-ref time :uint32))))

(define-achievement-method completion (steam::user-stats-get-achievement-achieved-percent (percentage :float)))
;; WTF: There's no per-user completion percentage getter.
(define-achievement-method show-progress (steam::user-stats-indicate-achievement-progress progress max))

(defclass leaderboard (interface-object)
  ()
  (:default-initargs :interface 'steamuserstats))

(defmethod initialize-instance :after ((leaderboard leaderboard) &key name
                                                                      (if-does-not-exist :error)
                                                                      (sort-method :ascending)
                                                                      (display-type :nubmeric))
  (unless (handle leaderboard)
    (ecase if-does-not-exist
      (:error
       (with-call-result (result :poll T) (steam::user-stats-find-leaderboard (iface* leaderboard) name)
         (check-invalid 0 (steam::leaderboard-find-leaderboard-found result))
         (setf (handle leaderboard) (steam::leaderboard-find-steam-leaderboard result))))
      (:create
       (with-call-result (result :poll T) (steam::user-stats-find-or-create-leaderboard (iface* leaderboard) name sort display)
         (setf (handle leaderboard) (steam::leaderboard-find-steam-leaderboard result)))))))

(define-interface-submethod leaderboard display-type (steam::user-stats-get-leaderboard-display-type))
(define-interface-submethod leaderboard entry-count (steam::user-stats-get-leaderboard-entry-count))
(define-interface-submethod leaderboard display-name (steam::user-stats-get-leaderboard-name))
(define-interface-submethod leaderboard sort-method (steam::user-stats-get-leaderboard-sort-method))

(defmethod (setf ugc) ((ugc ugc) (leaderboard leaderboard))
  (with-call-result (result :poll T) (steam::user-stats-attach-leaderboard-ugc (iface* leaderboard) (handle leaderboard) (handle ugc))
    (with-error-on-failure (steam::leaderboard-ugcset-result result))))

(defun decode-leaderboard-entries (iface result)
  (cffi:with-foreign-object (entry '(:struct steam::leaderboard-entry))
    (loop with entries = (steam::leaderboard-scores-downloaded-steam-leaderboard-entries result)
          for i from 0 below (steam::leaderboard-scores-downloaded-entry-count result)
          do (unless (steam::user-stats-get-downloaded-leaderboard-entry iface entries i entry (cffi:null-pointer) 0)
               (error "FIXME: failed"))
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
    (check-invalid 0 (steam::leaderboard-score-uploaded-success result))
    (values score
            (steam::leaderboard-score-uploaded-score-changed result)
            (steam::leaderboard-score-uploaded-global-rank-previous result)
            (steam::leaderboard-score-uploaded-global-rank-new result))))
