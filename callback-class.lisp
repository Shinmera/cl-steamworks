#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defmacro define-callback-class (name &body methods)
  (flet ((structfun (func)
           (intern (format NIL "~a-~a" name func))))
    `(progn
       (cffi:defcstruct (,name :conc-name ,(intern (format NIL "~a-" name)))
         (vtable-ptr :pointer)
         ,@(loop for (func ret args) in methods
                 collect `(,func :pointer)))
       
       (defclass ,name (c-managed-object)
         ())
       
       (defmethod allocate-handle ((,name ,name))
         (let ((handle (calloc '(:struct ,name))))
           (setf (,(structfun 'vtable-ptr) handle)
                 (cffi:foreign-slot-pointer handle '(:struct ,name) ',(caar methods)))
           ,@(loop for (func ret args) in methods
                   collect `(setf (cffi:foreign-slot-value handle '(:struct ,name) ',func)
                                  (cffi:callback ,(structfun func))))))
       
       (defmethod free-handle-function ((,name ,name) handle)
         (lambda () (cffi:foreign-free handle)))
       
       ,@(loop for (func ret args) in methods
               for callback = (intern (format NIL "~a-~a" func 'callback))
               collect `(defmethod ,callback
                            ((,name ,name) ,@(mapcar #'first args)))
               collect `(cffi:defcallback ,(structfun func) ,ret
                            ((this :pointer) ,@args)
                          (let ((callback (pointer->object this)))
                            (if callback
                                (,callback callback ,@(mapcar #'first args))
                                (warn* "Callback for unregistered pointer ~a" this))))))))

(define-callback-class server-list-response
  (server-list :void ((request steam::hserver-list-request) (server :int)))
  (server-list-failed :void ((request steam::hserver-list-request) (server :int)))
  (server-list-complete :void ((request steam::hserver-list-request) (response steam::ematch-making-server-response))))

(define-callback-class ping-response
  (ping :void ((server :pointer)))
  (ping-failed :void ()))

(define-callback-class player-details-response
  (player-details :void ((name :string) (score :int) (time-played :float)))
  (players-failed :void ())
  (players-complete :void ()))

(define-callback-class rules-response
  (rule :void ((rule :string) (value :string)))
  (rules-failed :void ())
  (rules-complete :void ()))
