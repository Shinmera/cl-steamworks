#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defmacro define-callback-class (name direct-superclasses direct-slots &body methods)
  (flet ((structfun (func)
           (intern (format NIL "~a-~a" name func))))
    `(progn
       (cffi:defcstruct (,name :conc-name ,(intern (format NIL "~a-" name)))
         (vtable-ptr :pointer)
         ,@(loop for (func ret args . body) in methods
                 collect `(,func :pointer)))
       
       (defclass ,name (,@direct-superclasses c-managed-object)
         ,direct-slots)
       
       (defmethod allocate-handle ((,name ,name) &key)
         (let ((handle (calloc '(:struct ,name))))
           (setf (,(structfun 'vtable-ptr) handle)
                 (cffi:foreign-slot-pointer handle '(:struct ,name) ',(caar methods)))
           ,@(loop for (func ret args . body) in methods
                   collect `(setf (cffi:foreign-slot-value handle '(:struct ,name) ',func)
                                  (cffi:callback ,(structfun func))))))
       
       (defmethod free-handle-function ((,name ,name) handle)
         (lambda () (cffi:foreign-free handle)))
       
       ,@(loop for (func ret args . body) in methods
               for callback = (intern (format NIL "~a-~a" func 'callback))
               collect `(defmethod ,callback ((,name ,name) ,@(mapcar #'first args))
                          ,@body)
               collect `(cffi:defcallback ,(structfun func) ,ret
                            ((this :pointer) ,@args)
                          (let ((callback (pointer->object this)))
                            (if callback
                                (,callback callback ,@(mapcar #'first args))
                                (warn* "Callback for unregistered pointer ~a" this))))))))

(defclass response-object ()
  ((status :initform :pending :accessor status)))

(defmethod response-failed :before ((object response-object))
  (setf (status object) :failed))

(defmethod response-failed ((object response-object)))

(defmethod response-completed :before ((object response-object))
  (setf (status object) :complete))

(defmethod response-completed ((object response-object)))

(defclass results-response-object (response-object)
  ((results :initform () :accessor results)))

(define-callback-class server-list-response (results-response-object)
  ()
  (server-list :void ((request steam::hserver-list-request) (server :int)))
  (server-list-failed :void ((request steam::hserver-list-request) (server :int)))
  (server-list-completed :void ((request steam::hserver-list-request) (response steam::ematch-making-server-response))
    (response-completed list)))

(define-callback-class ping-response (response-object)
  ()
  (ping-received :void ((server :pointer))
    (response-completed response))
  (response-failed :void ()))

(define-callback-class player-details-response (results-response-object)
  ()
  (player-details :void ((name :string) (score :int) (time-played :float))
    (push (list :name name :score score :time-played time-played)
          (results response)))
  (response-failed :void ())
  (response-completed :void ()))

(define-callback-class rules-response (results-response-object)
  ()
  (rule :void ((rule :string) (value :string))
    (push (cons rule value) (results response)))
  (response-failed :void ())
  (response-completed :void ()))
