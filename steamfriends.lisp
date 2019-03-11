#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamfriends (interface)
  ())

(defmethod initialize-instance :after ((interface steamfriends) &key version steamworks)
  (setf (handle interface) (get-interface-handle steamworks 'steam::client-get-isteam-friends
                                                 (user steamworks) (pipe steamworks) version)))
