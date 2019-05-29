#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamhttp (interface)
  ())

(defmethod initialize-instance :after ((interface steamhttp) &key version steamworks)
  (setf (handle interface) (get-interface-handle* steamworks 'steam::client-get-isteam-http
                                                  (t-or version STEAM::STEAMHTTP-INTERFACE-VERSION))))

(defclass cookie-container (c-managed-object interface-object)
  ()
  (:default-initargs :interface 'steamhttp
                     :free-on-gc T))

(defmethod allocate-handle ((container cookie-container) &key allow-modification)
  (steam::http-create-cookie-container (iface* container) allow-modification))

(defmethod free-handle-function ((container cookie-container) handle)
  (let ((interface (iface* container)))
    (lambda () (steam::http-release-cookie-container interface handle))))

(defmethod (setf cookie) ((value string) (container cookie-container) (host string) (key string) &key (path "/") (expires 0) secure http-only)
  (declare (ignore path expires secure http-only))
  ;; WTF: The parameter is named "URL" instead of key. Huh??
  (steam::http-set-cookie (iface* container) (handle container) host key value))

(defclass http-request (c-managed-object interface-object)
  ((cookie-container :initform NIL :reader cookie-container))
  (:default-initargs :interface 'steamhttp
                     :free-on-gc T))

(defmethod allocate-handle ((request http-request) &key (method :get) url)
  (check-type url string)
  (steam::http-create-httprequest (iface* request) method url))

(defmethod free-handle-function ((request http-request) handle)
  (let ((interface (iface* request)))
    (lambda () (steam::http-release-httprequest interface handle))))

(define-interface-submethod http-request defer (steam::http-defer-httprequest))
(define-interface-submethod http-request stream-request-body (steam::http-get-httpstreaming-response-body-data (offset integer) buffer (size integer)))
(define-interface-submethod http-request prioritize (steam::http-prioritize-httprequest)
  (check-invalid NIL result 'steam::http-prioritize-httprequest))
(define-interface-submethod http-request (setf context-value) ((value integer) steam::http-set-httprequest-context-value)
  (check-invalid NIL result 'steam::http-set-httprequest-context-value))
(define-interface-submethod http-request (setf parameter) ((value string) steam::http-set-httprequest-get-or-post-parameter (key string))
  (check-invalid NIL result 'steam::http-set-httprequest-get-or-post-parameter))
(define-interface-submethod http-request (setf header) ((value string) steam::http-set-httprequest-header-value (key string))
  (check-invalid NIL result 'steam::http-set-httprequest-header-value))
(define-interface-submethod http-request (setf soft-timeout) ((timeout integer) steam::http-set-httprequest-network-activity-timeout)
  (check-invalid NIL result 'steam::http-set-httprequest-network-activity-timeout))
(define-interface-submethod http-request (setf valid-certificate-required-p) (value steam::http-set-httprequest-requires-verified-certificate)
  (check-invalid NIL result 'steam::http-set-httprequest-requires-verified-certificate))
(define-interface-submethod http-request (setf user-agent) ((value string) steam::http-set-httprequest-user-agent-info))

(defmethod download-status ((request http-request))
  (list :downloaded (with-foreign-value (percentage :float)
                      (with-invalid-check NIL (steam::http-get-httpdownload-progress-pct (iface* request) (handle request) percentage)))
        :total 100.0))

(defmethod timed-out-p ((request http-request))
  (with-foreign-value (timed-out :bool)
    (with-invalid-check NIL (steam::http-get-httprequest-was-timed-out (iface* request) (handle request) timed-out))))

(defmethod request-body ((request http-request))
  (let* ((size (with-foreign-value (size :uint32)
                 (with-invalid-check NIL (steam::http-get-httpresponse-body-size (iface* request) (handle request) size))))
         (data (cffi:make-shareable-byte-vector size)))
    (cffi:with-pointer-to-vector-data (buffer data)
      (with-invalid-check NIL (steam::http-get-httpresponse-body-data (iface* request) (handle request) buffer size)))
    data))

(defmethod (setf request-body) ((value vector) (request http-request) (content-type string))
  (cffi:with-pointer-to-vector-data (buffer value)
    (with-invalid-check NIL (steam::http-set-httprequest-raw-post-body (iface* request) (handle request) content-type buffer (length value)))
    value))

(defmethod (setf request-body) ((value string) (request http-request) (content-type string))
  (cffi:with-foreign-string (buffer value :encoding :utf-8)
    (with-invalid-check NIL (steam::http-set-httprequest-raw-post-body (iface* request) (handle request) content-type buffer (length value)))
    value))

(defmethod header ((header string) (request http-request))
  (let* ((size (with-foreign-value (size :uint32)
                 (with-invalid-check NIL (steam::http-get-httpresponse-header-size (iface* request) (handle request) header size)))))
    (cffi:with-foreign-object (data :uchar size)
      (with-invalid-check NIL (steam::http-get-httpresponse-header-value (iface* request) (handle request) header data size))
      (cffi:foreign-string-to-lisp data :encoding :utf-8))))

(defmethod send ((request http-request) &key (block T) stream)
  (let ((handle (with-foreign-value (call-result 'steam::steam-apicall-t)
                  (if stream
                      (with-invalid-check NIL (steam::http-send-httprequest-and-stream-response (iface* request) (handle request) call-result))
                      (with-invalid-check NIL (steam::http-send-httprequest (iface* request) (handle request) call-result))))))
    (if block
        (let ((result (poll-for-result 'steam::httprequest-completed handle)))
          (with-invalid-check NIL (steam::httprequest-completed-request-successful result))
          (steam::httprequest-completed-status-code result))
        handle)))

(defmethod (setf timeout) (timeout (request http-request))
  (with-invalid-check NIL (steam::http-set-httprequest-absolute-timeout-ms (iface* request) (handle request) (millisecs timeout)))
  timeout)

(defmethod (setf cookie-container) ((container cookie-container) (request http-request))
  (with-invalid-check NIL (steam::http-set-httprequest-cookie-container (iface* request) (handle request) (handle container)))
  (setf (slot-value request 'cookie-container) container))
