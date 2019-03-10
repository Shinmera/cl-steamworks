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

;; This fucking sucks man
(defun foreign-type-p (type)
  (not (null (ignore-errors (cffi:foreign-type-size type)))))

(defun maybe-load-low-level (&optional file)
  (let ((file (or file (make-pathname :name "low-level" :type "lisp" :defaults cl-steamworks-cffi::*this*))))
    (when (probe-file file)
      (cffi:load-foreign-library 'cl-steamworks-cffi::steamworks)
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
