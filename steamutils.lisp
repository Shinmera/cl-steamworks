#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamutils (interface)
  ())

(defmethod initialize-instance :after ((interface steamutils) &key version steamworks)
  (setf (handle interface) (get-interface-handle steamworks 'cl-steamworks-cffi::client-get-isteam-utils
                                                 (pipe steamworks) version)))
