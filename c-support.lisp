#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks.cffi)

(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (cl:defvar *this* #.(cl:or cl:*compile-file-pathname* cl:*load-pathname*
                             (cl:error "COMPILE-FILE or LOAD this file.")))
  (cl:defvar *static*
    (cl:make-pathname :name cl:NIL :type cl:NIL
                      :defaults (cl:merge-pathnames "static/" *this*))))

(cffi:define-foreign-library steamworks
  ((:and :darwin :x86)
   "libsteam_api.dylib"
   :search-path #.(cl:merge-pathnames "osx32/" *static*))
  ((:and :unix :x86)
   "libsteam_api.so"
   :search-path #.(cl:merge-pathnames "linux32/" *static*))
  ((:and :unix :x86-64)
   "libsteam_api.so"
   :search-path #.(cl:merge-pathnames "linux64/" *static*))
  ((:and :windows :x86)
   "steam_api.dll"
   :search-path #.(cl:merge-pathnames "/" *static*))
  ((:and :windows :x86-64)
   "steam_api.dll"
   :search-path #.(cl:merge-pathnames "win64/" *static*)))

#+windows
(cffi:defcstruct (vtable :class vtable :conc-name vtable-)
  (result-with-info :pointer)
  (result :pointer)
  (size :pointer))

#-windows
(cffi:defcstruct (vtable :class vtable :conc-name vtable-)
  ;; void (pointer this, pointer param)
  (result :pointer)
  ;; void (pointer this, pointer param, bool failed, steam-apicall-t api-call)
  (result-with-info :pointer)
  ;; int (pointer this)
  (size :pointer))

(cffi:defcstruct (callback :class callback :conc-name callback-)
  ;; Pointer to vtable instance.
  (vtable-ptr :pointer)
  ;; Should be 2 on a game server, 0 otherwise?
  (flags :uint8)
  ;; Identifier of the type of callback to register.
  (id :int)
  ;; Identifier for the callresult token.
  (token :uint64)
  ;; Self pointer used when calling back.
  (this :pointer)
  ;; Function pointer to call for callresult
  (function :pointer)
  ;; vtable alloc
  (vtable (:struct vtable)))
