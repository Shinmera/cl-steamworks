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

(defmethod print-object ((c-object c-object) stream)
  (print-unreadable-object (c-object stream :type T)
    (format stream "@~d" (handle c-object))))

(defmethod handle (thing)
  (etypecase thing
    (integer thing)
    (cffi:foreign-pointer thing)))

(defgeneric allocate-handle (c-managed-object &key &allow-other-keys))
(defgeneric free-handle-function (c-managed-object handle))

(defclass c-registered-object (c-object)
  ())

(defmethod initialize-instance :after ((object c-registered-object) &key)
  (setf (pointer->object (handle object)) object))

(defmethod free-handle-function :around ((object c-registered-object) handle)
  (let ((next (call-next-method)))
    (lambda ()
      (setf (pointer->object handle) NIL)
      (funcall next))))

(defmethod free ((object c-registered-object))
  (when (slot-boundp object 'handle)
    (setf (pointer->object (handle object)) NIL)))

(defclass c-managed-object (c-object)
  ())

(defmethod initialize-instance ((object c-managed-object) &rest initargs &key free-on-gc)
  (call-next-method)
  (unless (handle object)
    (setf (handle object) (apply #'allocate-handle object initargs)))
  (when free-on-gc
    (tg:finalize object (free-handle-function object (handle object)))))

(defmethod initialize-instance :around ((object c-managed-object) &key handle)
  (if handle
      (call-next-method)
      (with-cleanup-on-failure (free object)
        (call-next-method))))

(defmethod free ((object c-managed-object))
  (let ((handle (when (slot-boundp object 'handle) (handle object))))
    (when handle
      (tg:cancel-finalization object)
      (setf (handle object) NIL)
      (funcall (free-handle-function object handle)))))

(defmacro with-c-objects (bindings &body body)
  (let ((gensyms (loop for binding in bindings
                       collect (gensym (string (first binding)))))
        (thunk (gensym "THUNK")))
    `(let ,gensyms
       (unwind-protect
            (flet ((,thunk ()
                     (let ,(loop for binding in bindings
                                 for var in gensyms
                                 collect `(,(first binding) ,var))
                       ,@body)))
              ,@(loop for binding in bindings
                      for var in gensyms
                      collect `(setf ,var ,(second binding)))
              (,thunk))
         ,@(loop for var in gensyms
                 collect `(when ,var (free ,var)))))))
