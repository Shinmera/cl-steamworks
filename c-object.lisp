#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defvar *c-object-table* (make-hash-table :test 'eql))

(defun pointer->object (pointer)
  (let ((address (etypecase pointer
                   (cffi:foreign-pointer (cffi:pointer-address pointer))
                   (integer pointer))))
    (gethash address *c-object-table*)))

(defun (setf pointer->object) (object pointer)
  (let ((address (etypecase pointer
                   (cffi:foreign-pointer (cffi:pointer-address pointer))
                   (integer pointer))))
    (if object
        (setf (gethash address *c-object-table*) object)
        (remhash address *c-object-table*))))

(defclass c-object ()
  ((handle :initarg :handle :initform NIL :accessor handle)))

(defclass c-managed-object (c-object)
  ())

(defmethod initialize-instance ((object c-managed-object) &key free-on-gc)
  (call-next-method)
  (unless (handle object)
    (let ((handle (allocate-handle object)))
      (when free-on-gc
        (tg:finalize object (free-handle-function object handle)))
      (setf (handle object) handle)
      (setf (pointer->object handle) object))))

(defmethod initialize-instance :around ((object c-managed-object) &key handle)
  (if handle
      (call-next-method)
      (with-cleanup-on-error (free object)
        (call-next-method))))

(defgeneric allocate-handle (c-managed-object))
(defgeneric free-handle-function (c-managed-object handle))

(defmethod free ((object c-managed-object))
  (let ((handle (when (slot-boundp object 'handle) (handle object))))
    (when handle
      (tg:cancel-finalization object)
      (setf (handle object) NIL)
      (funcall (free-handle-function object handle)))))
