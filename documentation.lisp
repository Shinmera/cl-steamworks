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
    "A foreign object that may be managed by the Lisp GC.

When subclassing, you must provide implementations for the generic
functions ALLOCATE-HANDLE and FREE-HANDLE-FUNCTION.

If an instance of this object is passed :FREE-ON-GC T as initargs,
then the following sections apply:

  When the lisp-side object is deallocated by the garbage collector,
  the associated C object is freed as well, using whatever means
  appropriate to do so. This ensures that there is no memory leakage.
  Note that this will /not/ recognise if the associated C object is
  freed on the C side or by means that are not the GC or the FREE
  function. If this should happen, the Lisp object will refer to
  an illegal handle, possibly leading to the corruption of your system
  down the road.
  
  Despite these objects being managed by the GC, it is unpredictable
  when the system will collect your object and it is thus advisable to
  still manually call FREE when it is known that the object won't be
  used any longer.

If :FREE-ON-GC NIL is passed, then the referenced C object must be
freed manually, either directly or through FREE.

See ALLOCATE-HANDLE
See FREE-HANDLE-FUNCTION
See FREE
See WITH-C-OBJECTS")

  (function allocate-handle
    "Allocate the C-side object and return a fresh handle.

This function is called as part of the initialisation sequence
of C-MANAGED-OBJECTs. You should implement a method specialised
on your subclass and perform whatever fetching or allocating
necessary, then return the handle to be used.

You may specify additional keyword arguments that will be passed
along from the make-instance initargs.

See C-MANAGED-OBJECT")

  (function free-handle-function
    "Construct a destructor function for the given instance and handle.

The returned function MUST NOT hold a reference to the instance,
neither directly nor transitively. It is advised to retrieve all
necessary information for the destructor, and then create a
closure that only refers to that information.

The returned function may be used as a finalizer.

See C-MANAGED-OBJECT")

  (function free
    "Frees the associated C object.

After FREE is invoked, the HANDLE will be set to NIL and the
Lisp object becomes effectively useless. Any further attempt
to use the object in any way leads to undefined consequences,
except for calling FREE again, which is guaranteed to be safe.

See C-MANAGED-OBJECT")

  (function with-c-objects
    "Lexically binds new variables and frees their values upon exit.

This is like LET with automated free on unwind.
Note that if you change the value of a binding established by
this construct, upon unwinding only the original values of the
bindings are freed.

See FREE"))

;; c-support.lisp
(docs:define-docs
  (function callback-type-id
    "Returns the SteamWorks internal callback ID for the given callback type.

This signals an error if the callback does not exist.")

  (function function-callresult
    "Returns the associated callresult structure type for the given function.

This signals an error if the given function does not initiate
a callresult."))

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

;; conditions.lisp
(docs:define-docs
  (type steamworks-condition
    "")

  (type argument-missing
    "")

  (function argument
    "")

  (type api-call-failed
    "")

  (function api-call
    "")

  (function error-code
    "")

  (type string-too-long
    "")

  (function oversized-string
    "")

  (function octet-limit
    "")

  (type no-such-callback
    "")

  (function callback-name
    "")

  (type no-such-file
    "")

  (function file-handle
    "")

  (type no-such-user
    "")

  (function user-handle
    "")

  (type buffer-too-short
    "")

  (function required-bytes
    "")

  (type voice-data-corrupted
    "")

  (type interface-creation-failed
    "")

  (function interface-name
    "")

  (type not-an-image-file
    "")

  (type string-malformed
    "")

  (function malformed-string
    "")

  (type pathname-not-a-directory
    "")

  (type too-many-requests
    "")

  (function request-limit
    "")

  (type workshop-agreement-not-accepted
    "")

  (type file-seeking-impossible
    "")

  (type request-denied
    "")

  (type cannot-set-member-data-for-others
    "")

  (type steamworks-not-initialized
    "")

  (type steamworks-already-initialized
    "")

  (type initialization-failed
    "")

  (type user-stats-not-ready
    "")

  (type low-level-not-loaded
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
(docs:define-docs
  (variable *default-interfaces*
    "A list of class-names of interfaces that are instantiated when a steamworks-client is created.

The interfaces are created in the order of this list.
By default this list does not contain any interfaces that need
explicit initialisation and finalisation.

See CREATE-INTERFACES")

  (variable *default-server-interfaces*
    "A list of class-names of interfaces that are instantiated when a steamworks-server is created.

The interfaces are created in the order of this list.
By default this list does not contain any interfaces that need
explicit initialisation and finalisation, or are only useful for
clients.

See CREATE-INTERFACES")
  
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

;; steamworkshop.lisp
(docs:define-docs)

;; toolkit.lisp
(docs:define-docs)
