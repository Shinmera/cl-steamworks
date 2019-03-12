#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

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

(defun maybe-load-low-level (&optional file)
  (let ((file (or file (make-pathname :name "low-level" :type "lisp" :defaults steam::*this*))))
    (when (probe-file file)
      (cffi:load-foreign-library 'steam::steamworks)
      #+asdf
      (let ((component (make-instance 'asdf:cl-source-file
                                      :parent (asdf:find-system :cl-steamworks)
                                      :name "low-level"
                                      :pathname file)))
        (asdf:perform 'asdf:compile-op component)
        (asdf:perform 'asdf:load-op component))
      #-asdf
      (load (compile-file file :verbose NIL :print NIL) :verbose NIL :print NIL)
      T)))

(or (maybe-load-low-level)
    (alexandria:simple-style-warning "No low-level file present. Please install the SteamWorks SDK:
Load cl-steamworks-generator and then run (cl-steamworks-generator:setup)"))

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
  #+windows (parse-namestring (env-var "TEMP"))
  #-windows #p"/tmp/")

(defun setup-app-id (app-id)
  (let ((directory (merge-pathnames "cl-steamworks/" (temp-directory))))
    (chdir (ensure-directories-exist directory))
    (with-open-file (stream (merge-pathnames #p"steam_appid.txt" directory)
                            :direction :output
                            :if-exists :supersede
                            :element-type 'character)
      (format stream "~a~%" app-id))))

(defun enlist (a &rest items)
  (if (listp a) a (list* a items)))
