#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks.cffi)

(cffi:defcstruct callback
  (vtable :pointer)
  (flags :uint8)
  (id :int))

#+windows
(cffi:defcstruct vtable
  (b :pointer)
  (a :pointer)
  (size :pointer))

#-windows
(cffi:defcstruct vtable
  (a :pointer)
  (b :pointer)
  (size :pointer))

(defparameter calling-convention
  #+(and x86 windows) :stdcall
  #-(and x86 windows) :cdecl)
