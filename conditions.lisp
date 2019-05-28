#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

;; FIXME: Implement all missing conditions

(define-condition steamworks-condition (condition)
  ())

(defmacro define-simple-condition (name direct-superclasses format-string &rest format-args)
  (let ((condition (gensym "CONDITION"))
        (stream (gensym "STREAM")))
    `(define-condition ,name (,@direct-superclasses steamworks-condition)
       ,(loop for arg in format-args
              for (name . default) = (enlist arg)
              for initarg = (intern (string name) "KEYWORD")
              collect (list name
                            :initarg initarg
                            :initform (if default
                                          (car default)
                                          `(error 'argument-missing :argument ',initarg))
                            :reader name))
       (:report (lambda (,condition ,stream)
                  (format ,stream ,format-string
                          ,@(loop for arg in format-args
                                  collect `(,(delist arg) ,condition))))))))

(define-simple-condition argument-missing (error)
  "The argument ~s is required, but was not passed."
  argument)

(define-simple-condition api-call-failed (error)
  "The SteamWorks API call ~@[~%  ~s~%~]did not succeed~:[ for an unknown reason.~;: ~:*~a~]"
  (api-call NIL) (error-code NIL))

(define-simple-condition string-too-long (error)
  "The string~%  ~s~%is too long.~@[ The API has a limit of ~s UTF-8 octets.~]"
  oversized-string (octet-limit NIL))

(define-simple-condition no-such-callback (error)
  "There is no callback named ~s."
  callback-name)

(define-simple-condition no-such-file (file-error)
  "The file~%  ~a~%does not exist."
  file-handle)

(define-simple-condition buffer-too-short (error)
  "The buffer needs to be able to hold at least ~d bytes."
  required-bytes)
