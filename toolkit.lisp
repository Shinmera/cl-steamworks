#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (unless (maybe-load-low-level)
    (alexandria:simple-style-warning "No low-level file present.
Please follow the instructions in the documentation to set up this library properly.")
    ;; KLUDGE: stub out types that are required to compile the library without the low-level file
    (macrolet ((define-stub-types (&body body)
                 `(progn ,@(loop for name in body collect
                                 (if (listp name)
                                     `(cffi:defcstruct ,(second name) ,@(cddr name))
                                     `(cffi:defctype ,name :int))))))
      (define-stub-types
        steam::hserver-list-request
        steam::hsteam-pipe
        steam::depot-id
        steam::app-id
        steam::published-file-id
        steam::controller-handle
        steam::controller-action-set-handle
        steam::steam-apicall
        steam::steam-inventory-result
        steam::steam-item-def
        steam::steam-item-instance-id
        steam::ematch-making-server-response
        steam::echat-entry-type
        steam::eitem-preview-type
        steam::econtroller-action-origin
        (:struct steam::gameserveritem)
        (:struct steam::match-making-key-value-pair)
        (:struct steam::p2psession-state)
        (:struct steam::leaderboard-entry)
        (:struct steam::steam-party-beacon-location
                 (steam::type :int)
                 (steam::location-id :int))
        (:struct steam::steam-item-details)
        (:struct steam::friend-game-info)
        (:struct steam::steam-param-string-array
                 (steam::strings :pointer)
                 (steam::num-strings :int))
        (:struct steam::steam-ugcdetails)
        (:struct steam::input-digital-action-data)
        (:struct steam::input-analog-action-data)
        (:struct steam::input-motion-data)))))

(defmacro with-cleanup-on-failure (cleanup &body body)
  (let ((err (gensym "ERROR")))
    `(let ((,err T))
       (unwind-protect
            (multiple-value-prog1 (progn ,@body)
              (setf ,err NIL))
         (when ,err
           ,cleanup)))))

(defun calloc (type &optional (count 1))
  (let ((ptr (cffi:foreign-alloc type :count count)))
    (dotimes (i (* count (cffi:foreign-type-size type)) ptr)
      (setf (cffi:mem-aref ptr :uchar i) 0))))

(defun warn* (datum &rest args)
  (let ((condition (etypecase datum
                     (string (make-condition 'simple-warning :format-control datum :format-arguments args))
                     (symbol (apply #'make-condition 'datum args))
                     (condition datum))))
    (format *error-output* "~&WARNING: ~a~%" condition)
    (warn condition)))

;; This fucking sucks man
(defun foreign-type-p (type)
  (handler-bind ((warning #'muffle-warning))
    (not (null (ignore-errors (cffi:foreign-type-size type))))))

(defun env-var (x)
  #+(or abcl clasp clisp ecl xcl) (ext:getenv x)
  #+allegro (sys:getenv x)
  #+clozure (ccl:getenv x)
  #+cmucl (unix:unix-getenv x)
  #+scl (cdr (assoc x ext:*environment-list* :test #'string=))
  #+gcl (system:getenv x)
  #+lispworks (lispworks:environment-variable x)
  #+mkcl (#.(or (find-symbol* 'getenv :si nil) (find-symbol* 'getenv :mk-ext nil)) x)
  #+sbcl (sb-ext:posix-getenv x))

(defun cwd ()
  #+(or abcl genera mezzano) (truename *default-pathname-defaults*)
  #+allegro (excl::current-directory)
  #+clisp (ext:default-directory)
  #+clozure (ccl:current-directory)
  #+(or cmucl scl) (#+cmucl parse-unix-namestring* #+scl lisp::parse-unix-namestring
                    (strcat (nth-value 1 (unix:unix-current-directory)) "/"))
  #+(or clasp ecl) (ext:getcwd)
  #+gcl (let ((*default-pathname-defaults* #p"")) (truename #p""))
  #+lispworks (hcl:get-working-directory)
  #+mkcl (mk-ext:getcwd)
  #+sbcl (sb-ext:parse-native-namestring (sb-unix:posix-getcwd/))
  #+xcl (extensions:current-directory))

(defun chdir (x)
  #+(or abcl xcl) (setf *default-pathname-defaults* (truename x))
  #+allegro (excl:chdir x)
  #+clisp (ext:cd x)
  #+clozure (setf (ccl:current-directory) x)
  #+(or cmucl scl) (unix:unix-chdir (ext:unix-namestring x))
  #+(or clasp ecl) (ext:chdir x)
  #+gcl (system:chdir x)
  #+lispworks (hcl:change-directory x)
  #+mkcl (mk-ext:chdir x)
  #+sbcl (sb-posix:chdir (sb-ext:native-namestring x)))

(defun quit (&optional (code 0))
  (finish-output *standard-output*)
  (finish-output *error-output*)
  #+(or abcl xcl) (ext:quit :status code)
  #+allegro (excl:exit code :quiet t)
  #+(or clasp ecl) (si:quit code)
  #+clisp (ext:quit code)
  #+clozure (ccl:quit code)
  #+(or cmucl scl) (unix:unix-exit code)
  #+gcl (system:quit code)
  #+lispworks (lispworks:quit :status code :confirm nil :return nil :ignore-errors-p t)
  #+mkcl (mk-ext:quit :exit-code code)
  #+sbcl (sb-ext:exit :code code))

(defun temp-directory ()
  #+windows (parse-namestring (format NIL "~a\\" (env-var "TEMP")))
  #-windows #p"/tmp/")

(defun setup-app-id (app-id)
  (unless (probe-file (merge-pathnames #p"steam_appid.txt" (cwd)))
    (let ((directory (merge-pathnames "cl-steamworks/" (temp-directory))))
      (chdir (ensure-directories-exist directory))
      (with-open-file (stream (merge-pathnames #p"steam_appid.txt" directory)
                              :direction :output
                              :if-exists :supersede
                              :element-type 'character)
        (format stream "~a~%" app-id)))))

(defun enlist (a &rest items)
  (if (listp a) a (list* a items)))

(defun delist (a)
  (if (listp a) (first a) a))

(defmacro t-or (&rest clauses)
  (when clauses
    (let ((result (gensym "RESULT")))
      `(let ((,result ,(first clauses)))
         (if (eql T ,result)
             (t-or ,@(rest clauses))
             ,result)))))

(defun ipv4->int (ipstring)
  (let* ((d1 (position #\. ipstring))
         (d2 (position #\. ipstring :start (1+ d1)))
         (d3 (position #\. ipstring :start (1+ d2)))
         (x 0))
    (setf (ldb (byte 8 24) x) (parse-integer ipstring :start 0 :end d1))
    (setf (ldb (byte 8 16) x) (parse-integer ipstring :start (1+ d1) :end d2))
    (setf (ldb (byte 8  8) x) (parse-integer ipstring :start (1+ d2) :end d3))
    (setf (ldb (byte 8  0) x) (parse-integer ipstring :start (1+ d3)))
    x))

(defun int->ipv4 (ipint)
  (format NIL "~d.~d.~d.~d"
          (ldb (byte 8 24) ipint)
          (ldb (byte 8 16) ipint)
          (ldb (byte 8  8) ipint)
          (ldb (byte 8  0) ipint)))

(defun remove-all (sequence &rest items)
  (remove-if (lambda (i) (find i items)) sequence))

(defun flags (enum &rest flags)
  (flet ((flag-value (flag)
           (if (integerp flag)
               flag
               (cffi:foreign-enum-value enum flag))))
    (reduce #'logior flags :key #'flag-value)))

(defun decode-flags (enum flags)
  (loop for flag in (cffi:foreign-enum-keyword-list enum)
        when (< 0 (logand flags (cffi:foreign-enum-value enum flag)))
        collect flag))

(defun struct-slot-ptr (struct slot)
  (cffi:foreign-slot-pointer (steam::_handle struct) (list :struct (type-of struct)) slot))

(defun struct-string (struct slot count)
  (cffi:foreign-string-to-lisp (struct-slot-ptr struct slot) :count count :encoding :utf-8))

(defun unix->universal (unix)
  (+ unix (encode-universal-time 0 0 0 1 1 1970 0)))

(defun universal->unix (universal)
  (- universal (encode-universal-time 0 0 0 1 1 1970 0)))

(defun account-id (id)
  (logand id #xFFFFFFFF))

(defun split-string (string split &optional (start 0))
  (let ((parts ())
        (buffer (make-string-output-stream)))
    (flet ((commit ()
             (let ((string (get-output-stream-string buffer)))
               (when (string/= "" string)
                 (push string parts)))))
      (loop for i from start below (length string)
            for char = (aref string i)
            do (if (char= char split)
                   (commit)
                   (write-char char buffer))
            finally (commit))
      (nreverse parts))))

(defun printable-char-p (char)
  ;; According to https://en.cppreference.com/w/c/string/byte/isprint
  ;; which is in the steam api for some reason.
  (find char "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"))

(declaim (inline microsecs))
(defun microsecs (s)
  (floor (* s 1000000)))

(declaim (inline millisecs))
(defun millisecs (s)
  (floor (* s 1000)))

(defun url-encode (thing &key stream (external-format :utf-8) (allowed "-._~"))
  (if stream
      (loop for octet across (babel:string-to-octets thing :encoding external-format)
            for char = (code-char octet)
            do (cond ((or (char<= #\0 char #\9)
                          (char<= #\a char #\z)
                          (char<= #\A char #\Z)
                          (find char allowed :test #'char=))
                      (write-char char stream))
                     (T (format stream "%~2,'0x" (char-code char)))))
      (with-output-to-string (stream)
        (url-encode thing :stream stream :external-format external-format :allowed allowed))))

(defun url-decode (string &key (external-format :utf-8) start end)
  (let ((out (make-array (length string) :element-type '(unsigned-byte 8) :fill-pointer 0)))
    (loop for i from (or start 0) below (or end (length string))
          for char = (aref string i)
          do (case char
               (#\% (vector-push (parse-integer string :start (+ i 1) :end (+ i 3) :radix 16) out)
                (incf i 2))
               (#\+ (vector-push (char-code #\Space) out))
               (T (vector-push (char-code char) out)))
          finally (return (babel:octets-to-string out :encoding external-format)))))

(defun format-query (stream arg &rest args)
  (declare (ignore args))
  (loop for cons on arg
        for (key . val) = (car cons)
        do (url-encode key :stream stream)
           (when (string/= "" val)
             (write-char #\= stream)
             (url-encode val :stream stream))
           (when (cdr cons)
             (write-char #\& stream))))

(defun destructure-query (query)
  (loop for part in (split-string query #\&)
        for sep = (position #\= part)
        collect (cons (url-decode part :end sep)
                      (url-decode part :start (1+ sep)))))

(defun merge-query (url get)
  (let* ((fragment-p (position #\# url))
         (query-p (position #\? url))
         (fragment (when fragment-p (subseq url fragment-p)))
         (query (when query-p (subseq url query-p (or fragment-p (length url))))))
    (with-output-to-string (stream)
      (write-string url stream :end (min (or fragment-p (length url)) (or query-p (length url))))
      (cond (query
             (write-string query stream)
             (when get
               (format stream "&~/cl-steamworks::format-query/" get)))
            (get
             (format stream "?~/cl-steamworks::format-query/" get)))
      (when fragment
        (write-string fragment stream)))))

(defmacro with-foreign-value ((var type) &body body)
  `(cffi:with-foreign-objects ((,var ,type))
     ,@body
     (cffi:mem-ref ,var ,type)))

(defmacro with-foreign-values (bindings &body body)
  `(cffi:with-foreign-objects ,bindings
     ,@body
     (values ,@(loop for (var type) in bindings
                     collect `(cffi:mem-ref ,var ,type)))))

(defun check-invalid (invalid value &optional call)
  (if (equal invalid value)
      (error 'api-call-failed :api-call call)
      value))

(defun check-valid (valid value &optional call)
  (if (equal valid value)
      value
      (error 'api-call-failed :api-call call)))

(defun check-empty-string (string &optional call)
  (check-invalid "" string call))

(defun check-utf8-size (length string)
  (when (<= length (babel:string-size-in-octets string :encoding :utf-8))
    (error 'string-too-long :oversized-string string :octet-limit length)))

(defun check-result (result &optional call)
  (unless (eql :ok result)
    (error 'api-call-failed :api-call call :error-code result)))

(defmacro with-valid-check (valid (call &rest args))
  `(check-valid ,valid (,call ,@args) ',call))

(defmacro with-invalid-check (invalid (call &rest args))
  `(check-invalid ,invalid (,call ,@args) ',call))

(defun fill-foreign-ascii (pointer string &optional length)
  (dotimes (i (max (or length 0) (length string)))
    (setf (cffi:mem-aref pointer :uchar) (char-code (aref string i)))))

(defun read-file-to-sharable-byte-vector (path)
  (with-open-file (stream path :direction :input :element-type '(unsigned-byte 8))
    (let ((buffer (cffi:make-shareable-byte-vector (file-length stream))))
      (loop with offset = 0
            while (< offset (length buffer))
            do (incf offset (read-sequence buffer stream :start offset)))
      buffer)))
