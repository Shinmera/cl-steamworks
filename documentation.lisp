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
    "Class used to represent callback response results as used in the steam matchmaking servers interface.

See STATUS
See RESPONSE-FAILED
See RESPONSE-COMPLETED")

  (function status
    "Returns the current status of the object

The returned value is a keyword describing the current status.
For a RESPONSE-OBJECT, the status can be one of
  :PENDING :FAILED :COMPLETE

See RESPONSE-OBJECT
See SERVER-QUERY
See INVENTORY-RESULT
See STEAMMUSIC")

  (function response-failed
    "Function called when it is known the callback request has failed.

This sets the STATUS of the RESPONSE-OBJECT and can be used
to attempt and respond to the failure somehow.

See RESPONSE-OBJECT")

  (function response-completed
    "Function called when ti is known the callback request has completed.

This sets the STATUS of the RESPONSE-OBJECT and can be used
to attempt and respond to it.

See RESPONSE-OBJECT")

  (type results-response-object
    "Superclass for a response that accumulates results it receives.

See RESPONSE-OBJECT
See RESULTS")

  (function results
    "Returns the list of accumulated results of the response.

See RESULTS-RESPONSE-OBJECT"))

;; callback.lisp
(docs:define-docs
  (function global-callback
    "Accessor for a globally registered callback.

The key must be a symbol naming the callback.
The value must be a list composed of a symbol and a function.
The symbol must name the struct-type to register the callback on.
The function must be a function of one argument: the callback struct
instance.

Callbacks registered through this mechanism will be instantiated and
registered when steamworks is initialised.

See REMOVE-GLOBAL-CALLBACK
See DEFINE-CALLBACK")

  (function remove-global-callback
    "Removes the global callback tied to the given name.

See GLOBAL-CALLBACK")

  (function define-callback
    "Defines a new global callback function.

STRUCT-TYPE should either be a symbol naming the struct-type to
register the callback for, or a list of the struct-type and the name
of the callback. When no name is explicitly given, the name is the
same as the struct-type.

RESULT will be bound to the callback result instance, which must be of
the same type as the given struct-type. SLOTS may be a list of
bindings to slots to establish. Each binding may either be the name of
a slot, or a list of a variable name and a slot name. If no variable
name is given, it is the same as the slot name.

Note that the slot names are automatically interned to the
ORG.SHIRAKUMO.FRAF.STEAMWORKS.CFFI package, so there is no need to
prefix the package.

See GLOBAL-CALLBACK
See REMOVE-GLOBAL-CALLBACK")

  (function struct-type
    "Accessor to the struct-type that the callback is registered on.

See CALLBACK")

  (function callback
    "Function called when a callback is triggered.

CALLBACK is a specific callback instance.
PARAMETER is the callback struct instance.
FAILED, if passed, indicates whether the callback failed. In that
case the PARAMETER may not be passed a useful value.
API-CALL, if passed, identifies the api-call that initiated the
callback.

See CALLBACK (type)")

  (type callback
    "Base class for global callbacks.

Global callbacks are callbacks from the SteamWorks API that may be
triggered at any time, even without an API call to initiate the
callback. When this callback is triggered, the CALLBACK function is
called.

Note that while this is a C-MANAGED-OBJECT, FREE-ON-GC is /not/ set
to T by default.

See C-REGISTERED-OBJECT
See C-MANAGED-OBJECT
See CALLBACK (function)")

  (type closure-callback
    "A global callback that invokes a closure on callback.

This allows easy runtime callback construction without having to
register a new class.

See CALLBACK (type)
See CLOSURE")

  (function closure
    "Returns the closure to invoke on callback.

The closure must take a single argument, the callback structure.
This structure may be NIL if the callback failed. Otherwise it must
be of the type registered as the STRUCT-TYPE.

See CLOSURE-CALLBACK
See CLOSURE-CALLRESULT")

  (type callresult
    "A one-time callresult that is tied to a specific API call.

Callresults are callbacks in the SteamWorks API that are tied to a
specific callresult token or handle. When creating an instance of this
class you must pass the token as returned by the API call function as
the :TOKEN initarg.

Note that while this is a C-MANAGED-OBJECT, FREE-ON-GC is /not/ set
to T by default. This is to prevent the object being freed before the
callresult hits.

See C-REGISTERED-OBJECT
See C-MANAGED-OBJECT
See MAYBE-RESULT
See RESULT
See TOKEN
See POLL-FOR-RESULT
See WITH-CALL-RESULT")

  (function token
    "Returns the specific callresult token the callresult is registered for.

This token cannot be re-used.

See CALLRESULT")

  (function maybe-result
    "If the callresult is ready, return the result structure.

See RESULT
See CALLRESULT")

  (function result
    "Returns the callresult structure.

If the callresult is not yet ready, an error of type API-CALL-FAILED
is signalled.

See CALLRESULT")

  (type closure-callresult
    "A callresult that invokes a closure on callback.

See CALLRESULT
See CLOSURE")

  (function poll-for-result
    "Polls for the callresult structure for the given type and handle.

This constructs a new closure-callresult, then repeatedly calls
MAYBE-RESULT with a pause of PAUSE between each try. Once MAYBE-RESULT
returns successfully, the result structure is returned.

This effectively turns the asynchronous callresult into a synchronous
operation.

See CLOSURE-CALLRESULT
See WITH-CALL-RESULT")

  (function with-call-result
    "Constructs the appropriate callresult structure for the SteamWorks API call.

METHOD must be a SteamWorks API function name that returns a
callresult handle. INTERFACE must be the instance of the respective
interface. RESULT will be bound to the result structure when the
callresult completes.

If POLL is non-NIL (at compile-time), WITH-CALL-RESULT becomes
synchronous and will block the current thread until the callresult
completes. The BODY is then invoked with the result bound. POLL
may also be set to a real number, designating the number of seconds to
wait between polling attempts.

If POLL is NIL, the body is bound as the callresult's closure, and the
callresult instance is returned instead. The body may then be invoked
at any time when the callresult completes. However, this can only
happen when RUN-CALLBACKS is invoked. In this case, you must also make
sure to call FREE on the returned callresult when you are done with
it.

See FREE
See POLL-FOR-RESULT
See RUN-CALLBACKS"))

;; conditions.lisp
(docs:define-docs
  (type steamworks-condition
    "Superclass for all steamworks related conditions.")

  (type argument-missing
    "Error signalled when a required argument is missing.

See ARGUMENT")

  (function argument
    "Returns the argument that was missing from the call.

See ARGUMENT-MISSING")

  (type api-call-failed
    "Error signalled when a call to a SteamWorks API fails.

See API-CALL
See ERROR-CODE")

  (function api-call
    "Returns the name of the API call that failed, if known.

See API-CALL-FAILED")

  (function error-code
    "Returns an error code or failure explanation for why the call failed, if known.

See API-CALL-FAILED")

  (type string-too-long
    "Error signalled when a string is too long for an API call.

Typically string length in the SteamWorks API is measured in UTF-8
octets rather than characters, so the length limit can be difficult to
estimate from random user input.

See OVERSIZED-STRING
See OCTET-LIMIT")

  (function oversized-string
    "Returns the oversized string that caused the error.

See STRING-TOO-LONG")

  (function octet-limit
    "Returns the maximum number of octets allowed for the API call, if known.

See STRING-TOO-LONG")

  (type no-such-callback
    "Error signalled when an inexistent callback is referenced.

See CALLBACK-NAME")

  (function callback-name
    "Returns the name of the callback that does not exist.

See NO-SUCH-CALLBACK")

  (type no-such-file
    "Error signalled when a file is referenced that does not exist.

See FILE-HANDLE")

  (function file-handle
    "Returns the name or pathname of the file that does not exist.

See NO-SUCH-FILE
See NOT-AN-IMAGE-FILE
See PATHNAME-NOT-A-DIRECTORY")

  (type no-such-user
    "Error signalled when a user is referenced that does not exist.

See USER-HANDLE")

  (function user-handle
    "The handle/reference to the inexistent user.

See NO-SUCH-USER")

  (type buffer-too-short
    "Error signalled when a data buffer is not long enough to receive the data.

See REQUIRED-BYTES")

  (function required-bytes
    "Returns the number of octets that are required to hold the data.

See BUFFER-TOO-SHORT")

  (type voice-data-corrupted
    "Warning signalled when the voice data could not be decoded as it is corrupted.")

  (type interface-creation-failed
    "Error signalled when the creation of a SteamWorks interface
    failed.

See INTERFACE-NAME")

  (function interface-name
    "Returns the name of the interface that failed to be created, if
    known.

See INTERFACE-CREATION-FAILED")

  (type not-an-image-file
    "Error signalled when a file does not designate a required image file.

See FILE-HANDLE")

  (type string-malformed
    "Error signalled when a string is malformed for an API.

This may be if the string has a bad structure, or contains illegal
characters that the API can't deal with.

See MALFORMED-STRING")

  (function malformed-string
    "Returns the malformed string that the API can't process.

See STRING-MALFORMED")

  (type pathname-not-a-directory
    "Error signalled when a pathname does not designate a required
    directory.

See FILE-HANDLE")

  (type too-many-requests
    "Error signalled when a function would invoke too many API calls at once.

See REQUEST-LIMIT")

  (function request-limit
    "Returns the maximum number of requests that can be sent.

See TOO-MANY-REQUESTS")

  (type workshop-agreement-not-accepted
    "Warning signalled if the user should accept the Steam Workshop agreement.")

  (type file-seeking-impossible
    "Error signalled when a seeking parameter is passed, but the file cannot be seeked.")

  (type request-denied
    "Error signalled when an API request was denied due to insufficient permissions.")

  (type cannot-set-member-data-for-others
    "Error signalled when an attempt is made to set user data for users other than the local one.")

  (type steamworks-not-initialized
    "Error signalled when a SteamWorks operation is attempted to be performed, but the API is not yet initialised.")

  (type steamworks-already-initialized
    "Error signalled when the SteamWorks API is attempted to be initialised again, but an old instance is still present.")

  (type initialization-failed
    "Error signalled when the SteamWorks API initialisation fails.

This usually happens when Steam is not running in the background
or the APP-ID file is not properly set up.")

  (type user-stats-not-ready
    "Warning signalled when the stats for the current user are not yet known.

This can be a problem, as other stats fetch requests must occur
after the current user stats are known.")

  (type low-level-not-loaded
    "Error signalled when the library has not yet been properly set up.

Please read the documentation on how to properly set up the
library."))

;; interface.lisp
(docs:define-docs
  (type interface
    "Superclass for all SteamWorks interface classes.

An interface will cache instances of objects related to it in order to
preserve object identity over instances that designate the same object
on the Steam side.

See C-OBJECT
See ENSURE-IFACE-OBJ
See INTERFACE-OBJECT (function)
See REMOVE-INTERFACE-OBJECT
See GET-INTERFACE-HANDLE
See GET-INTERFACE-HANDLE*
See CALL-WITH
See DEFINE-INTERFACE-METHOD
See DEFINE-INTERFACE-SUBMETHOD
See INTERFACE-OBJECT (type)
See INTERFACE (function)
See STEAMWORKS (function)")

  (function ensure-iface-obj
    "Ensures the given object is either returned from cache or created and stored.

The initargs HANDLE and INTERFACE must be passed.

See INTERFACE-OBJECT")

  (function interface
    "Returns the interface instance of the given name.

The container argument may be T for the global SteamWorks instance, or
another interface instance, or another interface-object instance.

If the interface does not exist, NIL is returned instead.

See INTERFACE (type)")

  (function interface-object
    "Accesses the interface object tied to the given handle.

See INTERFACE (type)
See REMOVE-INTERFACE-OBJECT")

  (function remove-interface-object
    "Removes the interface object tied to the given handle.

See INTERFACE (type)
See INTERFACE-OBJECT (function)")

  (function get-interface-handle
    "Returns the handle for an interface using the given SteamWorks function and args.

If the interface creation fails, an error of type
INTERFACE-CREATION-FAILED is signalled.")

  (function get-interface-handle*
    "Same as GET-INTERFACE-HANDLE but uses the common arguments.

Uses the SteamWorks USER, and PIPE, and the VERSION as arguments.

See GET-INTERFACE-HANDLE")

  (function call-with
    "Shorthand function to call the given function of the given interface.

See INTERFACE
See HANDLE")

  (function define-interface-method
    "Shorthand to define an interface method.

INTERFACE may either be the name of the interface to bind to, or a
list of that name and the function used to retrieve the interface's
handle.
METHOD should be the name of the lisp generic function to add a method
to.
CALL must be a list describing the API function and its arguments. If
the METHOD is a SETF function, the API function must be the second
item in the list, otherwise the first. The rest should be the
arguments of the method definition, which will be passed to the API
function in order, with the interface handle as the first argument.

If TRANSFORM is given, it should be a body of forms with RESULT bound
to the return value of the API function call. The return value of this
body is then returned from the method. Otherwise, if the METHOD is a
setf function, the first argument is returned again, and otherwise
RESULT is returned verbatim.

See INTERFACE (type)
See DEFINE-INTERFACE-SUBMETHOD")

  (function define-interface-submethod
    "Shorthand to define a method on an interface-object.

SUB may either be the name of the interface-object class to bind to,
or a list of that name and the function used to retrieve the
interface's handle.
METHOD should be the name of the lisp generic function to add a method
to.
CALL must be a list describing the API function and its arguments. If
the METHOD is a SETF function, the API function must be the second
item in the list, otherwise the first. The rest should be the
arguments of the method definition, which will be passed to the API
function in order, with the interface handle and the interface-object
handle as the first two arguments.

If TRANSFORM is given, it should be a body of forms with RESULT bound
to the return value of the API function call. The return value of this
body is then returned from the method. Otherwise, if the METHOD is a
setf function, the first argument is returned again, and otherwise
RESULT is returned verbatim.

See INTERFACE-OBJECT (type)
See DEFINE-INTERFACE-METHOD")

  (type interface-object
    "Superclass for classes representing SteamWorks objects tied to a certain interface.

See INTERFACE (type)
See IFACE
See IFACE*")

  (function iface
    "Returns the interface instance the object is tied to.

See INTERFACE-OBJECT")

  (function iface*
    "Returns the handle of the interface instance the object is tied
    to.

See IFACE
See INTERFACE-OBJECT"))

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
