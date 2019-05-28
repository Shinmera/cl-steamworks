#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

;; c-object.lisp
(docs:define-docs
  (type c-object
    "Low-level wrapper object for a C-land resource.

See HANDLE")

  (function handle
    "Accesses the handle of the c-object.

This could either be a foreign memory pointer, or some other kind of
structure that serves as the identifier for the foreign object.

See C-OBJECT")

  (type c-registered-object
    "A foreign object that is registered on the Lisp-side.

This means that, given the HANDLE of the object, you will be able to
retrieve it again using POINTER->OBJECT. As the name implies, this
requires the handle to be a foreign-memory pointer.

See POINTER->OBJECT")

  (function pointer->object
    "Translates a foreign pointer or address to the associated lisp object, if any.

This is a SETFable place. If set to NIL, the association with the
pointer is removed. Note that this hash table is /not/ weak, meaning
that it will cause objects to be retained if they are associated. If
the associated C resource the pointer is pointing to is freed, you
MUST set its value of this function to NIL to allow the corresponding
lisp object to be freed as well.

See C-REGISTERED-OBJECT")

  (type c-managed-object
    "")

  (function allocate-handle
    "")

  (function free-handle-function
    "")

  (function free
    "")

  (function with-c-objects
    ""))

;; c-support.lisp
(docs:define-docs
  (function callback-type-id
    "")

  (function function-callresult
    ""))

;; callback-class.lisp
(docs:define-docs
  (type response-object
    "")

  (function status
    "")

  (function response-failed
    "")

  (function response-completed
    "")

  (type results-response-object
    "")

  (function results
    ""))

;; callback.lisp
(docs:define-docs
  (function global-callback
    "")

  (function remove-global-callback
    "")

  (function define-callback
    "")

  (function struct-type
    "")

  (function callback
    "")

  (type callback
    "")

  (type closure-callback
    "")

  (function closure
    "")

  (type callresult
    "")

  (function token
    "")

  (function maybe-result
    "")

  (function result
    "")

  (type closure-callresult
    "")

  (function poll-for-result
    "")

  (function with-call-result
    ""))

;; interface.lisp
(docs:define-docs
  (type interface
    "")

  (function ensure-iface-obj
    "")

  (function interface
    "")

  (function interface-object
    "")

  (function remove-interface-object
    "")

  (function get-interface-handle
    "")

  (function get-interface-handle*
    "")

  (function call-with
    "")

  (function define-interface-method
    "")

  (function define-interface-submethod
    "")

  (type interface-object
    "")

  (function iface
    "")

  (function iface*
    ""))

;; steamapps.lisp
(docs:define-docs)

;; steamclient.lisp
(docs:define-docs)

;; steamcontroller.lisp
(docs:define-docs)

;; steamfriends.lisp
(docs:define-docs)

;; steamgameserver.lisp
(docs:define-docs)

;; steamhtmlsurface.lisp
(docs:define-docs)

;; steamhttp.lisp
(docs:define-docs)

;; steaminventory.lisp
(docs:define-docs)

;; steammatchmaking.lisp
(docs:define-docs)

;; steammusic.lisp
(docs:define-docs)

;; steammusicremote.lisp
(docs:define-docs)

;; steamnetworking.lisp
(docs:define-docs)

;; steamparties.lisp
(docs:define-docs)

;; steamremotestorage.lisp
(docs:define-docs)

;; steamscreenshots.lisp
(docs:define-docs)

;; steamuser.lisp
(docs:define-docs)

;; steamuserstats.lisp
(docs:define-docs)

;; steamutils.lisp
(docs:define-docs)

;; steamvideo.lisp
(docs:define-docs)

;; steamworks.lisp
(docs:define-docs)

;; steamworkshop.lisp
(docs:define-docs
  (variable *default-interfaces*
    "")

  (variable *default-server-interfaces*
    "")
  
  (function steamworks
    "")

  (type pipe
    "")

  (type user
    "")

  (function pipe
    "")

  (type steamworks
    "")

  (function user
    "")

  (function create-interfaces
    "")

  (function list-interfaces
    "")

  (type steamworks-client
    "")

  (function run-callbacks
    "")

  (type steamworks-server
    "")

  (function ip-address
    "")

  (function steam-port
    "")

  (function game-port
    "")

  (function query-port
    "")

  (function server-mode
    "")

  (function version-string
    "")

  (function server-depot
    ""))

;; toolkit.lisp
(docs:define-docs)
