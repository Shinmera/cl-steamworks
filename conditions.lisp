#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(define-condition steamworks-condition (condition)
  ())

(defmacro define-simple-condition (name direct-superclasses format-string &rest format-args)
  (let ((condition (gensym "CONDITION"))
        (stream (gensym "STREAM")))
    `(define-condition ,name (,@direct-superclasses steamworks-condition)
       ,(loop for arg in format-args
              for (name . default) = (if (listp arg) arg (list arg))
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
                                  collect `(,(if (listp arg) (car arg) arg) ,condition))))))))

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

(define-simple-condition no-such-user (error)
  "The user~%  ~a~%does not exist."
  user-handle)

(define-simple-condition buffer-too-short (error)
  "The buffer needs to be able to hold at least ~d bytes."
  required-bytes)

(define-simple-condition voice-data-corrupted (warning)
  "The voice data was corrupted and has been lost.")

(define-simple-condition interface-creation-failed (error)
  "Failed to create a handle ~:[for an interface.~;~:*to the ~a interface~]."
  (interface-name NIL))

(define-simple-condition not-an-image-file (error)
  "The given file ~a does not appear to be an image (PNG, JPG, GIF, SVG) file."
  file-handle)

(define-simple-condition string-malformed (error)
  "The string~%  ~s~%contains invalid characters."
  malformed-string)

(define-simple-condition pathname-not-a-directory (error)
  "The pathname~%  ~a~%does not designate a directory."
  file-handle)

(define-simple-condition too-many-requests (error)
  "The function call would incur too many requests.~@[ The limit is at ~d~]"
  (request-limit NIL))

(define-simple-condition workshop-agreement-not-accepted (warning)
  "The user has not yet accepted the Steam Workshop agreement.")

(define-simple-condition file-seeking-impossible (error)
  "Cannot seek when reading the entire file.")

(define-simple-condition request-denied (error)
  "You do not have permission to perform the request.")

(define-simple-condition cannot-set-member-data-for-others (request-denied)
  "You cannot set the member data for users other than the local user.")

(define-simple-condition steamworks-not-initialized (error)
  "The SteamWorks API has not yet been initialized.")

(define-simple-condition steamworks-already-initialized (error)
  "The SteamWorks API has already been initialized before.")

(define-simple-condition initialization-failed (api-call-failed)
  "SteamWorks initialization failed.
Is Steam running and the app-id set up properly?")

(define-simple-condition user-stats-not-ready (warning)
  "The stats for the current user have been requested but are not yet ready.
You might need to call (run-callbacks T)")

(define-simple-condition low-level-not-loaded (error)
  "The low-level file is not present.
Please follow the instructions in the documentation to set up this library properly.")
