#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamhtmlsurface (c-managed-object interface)
  ())

(defmethod initialize-instance :after ((interface steamhtmlsurface) &key version steamworks)
  (setf (handle interface) (get-interface-handle* steamworks 'steam::client-get-isteam-htmlsurface
                                                  (t-or version steam::steamhtmlsurface-interface-version)))
  (steam::htmlsurface-init (handle interface)))

(defmethod free-handle-function ((htmlsurface steamhtmlsurface) handle)
  (lambda () (steam::htmlsurface-shutdown handle)))

(defmethod make-browser ((htmlsurface steamhtmlsurface) &key user-agent css)
  (make-instance 'browser :interface htmlsurface :user-agent user-agent :css css))

;; WTF: Why is this not on a per-browser basis?
(defmethod (setf cookie) ((htmlsurface steamhtmlsurface) (host string) (key string) (value string) &key (path "/") (expires 0) secure http-only)
  (steam::htmlsurface-set-cookie (handle htmlsurface) host key value path expires secure http-only))

(defclass browser (c-managed-object interface-object)
  ((find-string :initform NIL :accessor find-string))
  (:default-initargs :interface 'steamhtmlsurface))

(defmethod initialize-instance :after ((browser browser) &key user-agent css)
  (unless (handle browser)
    (with-call-result (result :poll T) (steam::htmlsurface-create-browser (iface* browser) (or user-agent (cffi:null-pointer)) (or css (cffi:null-pointer)))
      ;; Apparently this cannot fail. Weird. At least, there's no failure result or anything.
      (setf (handle browser) (steam::html-browser-ready-browser-handle result)))))

(defmethod free-handle-function ((browser browser) handle)
  (let ((interface (iface* browser)))
    (lambda () (steam::htmlsurface-remove-browser interface handle))))

(define-interface-submethod browser add-header (steam::htmlsurface-add-header (key string) (value string)))
(define-interface-submethod browser (setf request-allowed-p) (value steam::htmlsurface-allow-start-request))
(define-interface-submethod browser (setf dialog-allowed-p) (result steam::htmlsurface-jsdialog-response))
(define-interface-submethod browser copy-to-clipboard (steam::htmlsurface-copy-to-clipboard))
(define-interface-submethod browser paste-from-clipboard (steam::htmlsurface-paste-from-clipboard))
(define-interface-submethod browser eval-js (steam::htmlsurface-execute-javascript (script string)))
(define-interface-submethod browser request-link (steam::htmlsurface-get-link-at-position (x integer) (y integer)))
(define-interface-submethod browser go-back (steam::htmlsurface-go-back))
(define-interface-submethod browser go-forward (steam::htmlsurface-go-forward))
(define-interface-submethod browser reload (steam::htmlsurface-reload))
(define-interface-submethod browser (setf backgrounded) (value steam::htmlsurface-set-background-mode))
(define-interface-submethod browser (setf focused) (value steam::htmlsurface-set-key-focus))
(define-interface-submethod browser stop (steam::htmlsurface-stop-load))
(define-interface-submethod browser view-page-source (steam::htmlsurface-view-source))

(defmethod find-in-page ((browser browser) &key (string NIL string-p) reverse)
  (cond ((or (null (find-string browser))
             (and string (string/= string (find-string browser))))
         (when (find-string browser)
           (steam::htmlsurface-stop-find (iface* browser) (handle browser)))
         (setf (find-string browser) string)
         (steam::htmlsurface-find (iface* browser) (handle browser) string NIL reverse))
        ((and string-p (null string))
         (steam::htmlsurface-stop-find (iface* browser) (handle browser)))
        ((find-string browser)
         (steam::htmlsurface-find (iface* browser) (handle browser) (find-string browser) T reverse))))

(defmethod (setf selected-files) (value (browser browser))
  (cffi:with-foreign-object (list :pointer (length value))
    (let ((strings (map 'vector #'cffi:lisp-string-to-foreign value)))
      (loop for i from 0 below (length strings)
            do (setf (cffi:mem-aref list :pointer i) (aref strings i)))
      (steam::htmlsurface-file-load-dialog-response (iface* browser) (handle browser) list)
      (map NIL #'cffi:foreign-free strings)))
  value)

(defgeneric cause-event (type arg browser &key &allow-other-keys))

(defmethod cause-event ((type (eql :char)) char (browser browser) &key modifiers)
  (steam::htmlsurface-key-char (iface* browser) (handle browser) (char-code char)
                               (apply #'flags 'steam::isteam-htmlsurface-ehtmlkey-modifiers modifiers)))

(defmethod cause-event ((type (eql :key-down)) key (browser browser) &key modifiers)
  (steam::htmlsurface-key-down (iface* browser) (handle browser) key
                               (apply #'flags 'steam::isteam-htmlsurface-ehtmlkey-modifiers modifiers)))

(defmethod cause-event ((type (eql :key-up)) key (browser browser) &key modifiers)
  (steam::htmlsurface-key-up (iface* browser) (handle browser) key
                             (apply #'flags 'steam::isteam-htmlsurface-ehtmlkey-modifiers modifiers)))

(defmethod cause-event ((type (eql :dblclick)) button (browser browser) &key)
  (steam::htmlsurface-mouse-double-click (iface* browser) (handle browser) button))

(defmethod cause-event ((type (eql :mouse-down)) button (browser browser) &key)
  (steam::htmlsurface-mouse-down (iface* browser) (handle browser) button))

(defmethod cause-event ((type (eql :mouse-up)) button (browser browser) &key)
  (steam::htmlsurface-mouse-up (iface* browser) (handle browser) button))

(defmethod cause-event ((type (eql :move)) pos (browser browser) &key)
  (steam::htmlsurface-mouse-move (iface* browser) (handle browser)
                                 (round (car pos)) (round (cdr pos))))

(defmethod cause-event ((type (eql :scroll)) delta (browser browser) &key)
  (steam::htmlsurface-mouse-wheel (iface* browser) (handle browser) delta))

(defmethod scroll ((browser browser) &key x y)
  (when x (steam::htmlsurface-set-horizontal-scroll (iface* browser) (handle browser) x))
  (when y (steam::htmlsurface-set-horizontal-scroll (iface* browser) (handle browser) y)))

(defmethod zoom ((browser browser) (factor real) &key x y)
  (steam::htmlsurface-set-page-scale-factor (iface* browser) (handle browser) (coerce factor 'single-float) (or x 0) (or y 0)))

(defmethod (setf size) ((value cons) (browser browser))
  (steam::htmlsurface-set-size (iface* browser) (handle browser) (car value) (cdr value)))

(defmethod open-page ((url string) (browser browser) &key get post)
  (let ((url (format NIL "~a~@[?~/cl-steamworks::format-query/~]" url get))
        (post (format NIL "~/cl-steamworks::format-query/" post)))
    (steam::htmlsurface-load-url (iface* browser) (handle browser) url post)))

;; FIXME: handle callbacks
