#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamremotestorage (interface)
  ())

(defmethod initialize-instance :after ((interface steamremotestorage) &key version steamworks)
  (setf (handle interface) (get-interface-handle* steamworks 'steam::client-get-isteam-remote-storage
                                                  (t-or version steam::steamremotestorage-interface-version))))

(define-interface-method steamremotestorage (setf cloud-enabled-p) (value steam::remote-storage-set-cloud-enabled-for-app))

(defmethod cloud-enabled-p ((interface steamremotestorage))
  (let ((account (steam::remote-storage-is-cloud-enabled-for-account (handle interface)))
        (app (steam::remote-storage-is-cloud-enabled-for-app (handle interface))))
    (values (and account app)
            (cond ((null account) :account)
                  ((null app) :app)))))

(defmethod list-cached-ugc ((interface steamremotestorage))
  (loop for i from 0 below (steam::remote-storage-get-cached-ugccount (handle interface))
        for handle = (steam::remote-storage-get-cached-ugchandle (handle interface) i)
        collect (make-instance 'ugc :interface interface :handle handle)))

(defmethod list-files ((interface steamremotestorage))
  (cffi:with-foreign-object (size :int32)
    (loop for i from 0 below (steam::remote-storage-get-file-count (handle interface))
          for handle = (check-empty-string (steam::remote-storage-get-file-name-and-size (handle interface) i size))
          collect (make-instance 'file :interface interface :handle handle))))

(defmethod quota ((interface steamremotestorage))
  (cffi:with-foreign-objects ((total :uint64)
                              (available :uint64))
    (steam::remote-storage-get-quota (handle interface) total available)
    (list :available (cffi:mem-ref available :uint64)
          :total (cffi:mem-ref total :uint64))))

(defclass file (interface-object)
  ()
  (:default-initargs :interface 'steamremotestorage))

(define-interface-submethod file destroy (steam::remote-storage-file-delete)
  (unless (error "FIXME: file did not exist.")))
(define-interface-submethod file exists-p (steam::remote-storage-file-exists))
(define-interface-submethod file forget (steam::remote-storage-file-forget)
  (unless (error "FIXME: file did not exist.")))
(define-interface-submethod file persisted-p (steam::remote-storage-file-persisted))
(define-interface-submethod file share (steam::remote-storage-file-share)
  (let ((result (poll-for-result 'steam::remote-storage-file-share result)))
    (with-error-on-failure (steam::remote-storage-file-share-result result))
    (make-instance 'ugc :interface (iface file)
                        :handle (steam::remote-storage-file-share-file result))))
(define-interface-submethod file size (steam::remote-storage-get-file-size)
  (check-invalid 0 result "FIXME: failed"))
(define-interface-submethod file last-modified (steam::remote-storage-get-file-timestamp)
  (unix->universal result))
(define-interface-submethod file sync-platforms (steam::remote-storage-get-sync-platforms)
  (decode-flags 'steam::eremote-storage-platform result))

(defmethod name ((file file))
  (handle file))

(defmethod (setf sync-platforms) ((platforms cons) (file file))
  (unless (steam::remote-storage-set-sync-platforms (iface* file) (handle file) (apply #'flags 'steam::eremote-storage-platform platforms))
    (error "FIXME: failed"))
  platforms)

(defgeneric read-file (file vector &key start end &allow-other-keys))
(defmethod read-file ((file file) (vector vector) &key start end)
  (unless (= 0 start) (error "FIXME: cannot seek in file."))
  (cffi:with-pointer-to-vector-data (buffer vector)
    (let ((end (or end (size file))))
      (when (< (length vector) end) "FIXME: vector too short.")
      (check-invalid 0 (steam::remote-storage-file-read (iface* file) (handle file) buffer end)
                     "FIXME: failed"))))

(defmethod start-async-read ((file file) &key start end)
  (let ((start (or start 0))
        (end (or end (size file))))
    (check-invalid 0 (steam::remote-storage-file-read-async (iface* file) (handle file) start (- end start))
                   "FIXME: failed")))

(defmethod complete-async-read ((file file) (vector vector) read)
  (cffi:with-pointer-to-vector-data (buffer vector)
    (unless (steam::remote-storage-file-read-async-complete (iface* file) (handle file) buffer read)
      (error "FIXME: failed"))))

(defmethod write-file ((file file) (vector vector))
  (cffi:with-pointer-to-vector-data (buffer vector)
    (unless (steam::remote-storage-file-write (iface* file) (handle file) buffer (length vector))
      (error "FIXME: failed"))))

(defmethod start-async-write ((file file) buffer length)
  (check-invalid 0 (steam::remote-storage-file-write-async (iface* file) (handle file) buffer length)
                 "FIXME: failed"))

(defmethod write-stream ((file file))
  (make-instance 'file-write-stream :interface (iface file) :file file))

(defmacro with-write-stream ((stream file) &body body)
  `(let ((,stream (write-stream ,file)))
     (unwind-protect (progn ,@body)
       (close ,stream))))

(defclass file-write-stream (c-managed-object interface-object trivial-gray-streams:fundamental-binary-output-stream)
  ())

(defmethod allocate-handle ((stream file-write-stream) &key file)
  (check-invalid #xffffffffffffffff (steam::remote-storage-file-write-stream-open (iface* stream) (handle file))))

(defmethod free-handle-function ((stream file-write-stream) handle)
  (let ((interface (iface* stream)))
    (lambda () (steam::remote-storage-file-write-stream-cancel interface handle))))

(defmethod trivial-gray-streams:stream-write-sequence ((stream file-write-stream) (vector vector) start end &key)
  (cffi:with-pointer-to-vector-data (buffer vector)
    (unless (steam::remote-storage-file-write-stream-write-chunk (iface* stream) (handle stream) (cffi:inc-pointer buffer start) (- start end))
      (error "FIXME: failed"))))

(defmethod cl:open-stream-p ((stream file-write-stream))
  (not (null (handle stream))))

(defmethod cl:stream-element-type ((stream file-write-stream))
  '(unsigned-byte 8))

(defmethod cl:close ((stream file-write-stream) &key abort)
  (when (handle stream)
    (unless (if abort
                (steam::remote-storage-file-write-stream-cancel (iface* stream) (handle stream))
                (steam::remote-storage-file-write-stream-close (iface* stream) (handle stream)))
      (error "FIXME: failed"))
    (tg:cancel-finalization stream)
    (setf (handle stream) NIL)))

(defclass ugc (interface-object)
  ((app :reader app)
   (name :reader name)
   (size :reader size)
   (owner :reader owner))
  (:default-initargs :interface 'steamremotestorage))

(defmethod initialize-instance :after ((ugc ugc) &key)
  (cffi:with-foreign-objects ((app 'steam::app-id-t)
                              (name :pointer)
                              (size :int32)
                              (owner 'steam::steam-id))
    (unless (steam::remote-storage-get-ugcdetails (iface* ugc) (handle ugc) app name size owner)
      (error "FIXME: failed"))
    (setf (slot-value ugc 'app) (make-instance 'app :handle (cffi:mem-ref app 'steam::app-id-t)))
    (setf (slot-value ugc 'name) (cffi:foreign-string-to-lisp (cffi:mem-ref name :pointer) :encoding :utf-8))
    (setf (slot-value ugc 'app) (cffi:mem-ref app :int32))
    (setf (slot-value ugc 'app) (make-instance 'friend :handle (cffi:mem-ref app 'steam::steam-id)))))

(defmethod download ((ugc ugc) &key (priority 0) location)
  (if location
      (with-call-result (result :poll T) (steam::remote-storage-ugcdownload-to-location (iface* ugc) (handle ugc) location priority)
        (with-error-on-failure (steam::remote-storage-download-ugc-result result)))
      (with-call-result (result :poll T) (steam::remote-storage-ugcdownload (iface* ugc) (handle ugc) priority)
        (with-error-on-failure (steam::remote-storage-download-ugc-result result)))))

(defmethod read-file ((ugc ugc) (vector vector) &key start end read-action)
  (cffi:with-pointer-to-vector-data (buffer vector)
    (let ((start (or start 0))
          (end (or end (size ugc))))
      (when (< (length vector) (- end start))
        (error "FIXME: vector too short"))
      (check-invalid 0 (steam::remote-storage-ugcread (iface* ugc) (handle ugc) buffer (- end start) start read-action)
                     "FIXME: failed"))))

(defmethod download-status ((ugc ugc))
  (cffi:with-foreign-objects ((downloaded :int32)
                              (total :int32))
    (when (steam::ugc-get-item-download-info (iface* ugc) (handle ugc) downloaded total)
      (list :downloaded (cffi:mem-ref downloaded :int32)
            :total (cffi:mem-ref total :int32)))))
