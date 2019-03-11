#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamuser (interface)
  ())

(defmethod initialize-instance :after ((interface steamuser) &key version steamworks)
  (setf (handle interface) (get-interface-handle steamworks 'cl-steamworks-cffi::client-get-isteam-user
                                                 (user steamworks) (pipe steamworks) version)))
