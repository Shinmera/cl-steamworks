#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks.cffi)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defvar *this* #.(or *compile-file-pathname* *load-pathname*
                       (error "COMPILE-FILE or LOAD this file.")))
  (defvar *static* (make-pathname :name NIL :type NIL :defaults (merge-pathnames "static/" *this*))))

(defparameter calling-convention
  #+(and x86 windows) :stdcall
  #-(and x86 windows) :cdecl)

(cffi:define-foreign-library steamworks
  ((:and :darwin :x86)
   "libsteam_api.dylib"
   :search-path #.(merge-pathnames "osx32/" *static*))
  ((:and :unix :x86)
   "libsteam_api.so"
   :search-path #.(merge-pathnames "linux32/" *static*))
  ((:and :unix :x86-64)
   "libsteam_api.so"
   :search-path #.(merge-pathnames "linux64/" *static*))
  ((:and :windows :x86)
   "steam_api.dll"
   :convention :stdcall
   :search-path #.(merge-pathnames "/" *static*))
  ((:and :windows :x86-64)
   "steam_api.dll"
   :search-path #.(merge-pathnames "win64/" *static*)))

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
  ;; vtable alloc
  (vtable (:struct vtable)))

(defun maybe-load-low-level (&optional (file (make-pathname :name "low-level" :type "lisp" :defaults *this*)))
  (when (probe-file file)
    (cffi:load-foreign-library 'steamworks)
    #+asdf
    (let ((component (make-instance 'asdf:cl-source-file
                                    :parent (asdf:find-system :cl-steamworks)
                                    :name "low-level"
                                    :pathname file)))
      (asdf:perform 'asdf:compile-op component)
      (asdf:perform 'asdf:load-op component))
    #-asdf
    (load (compile-file file :verbose NIL :print NIL) :verbose NIL :print NIL)
    T))

(or (maybe-load-low-level)
    (alexandria:simple-style-warning "No low-level file present. Please install the SteamWorks SDK:
Load cl-steamworks-generator and then run (cl-steamworks-generator:setup)"))
