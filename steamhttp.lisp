#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamhttp (interface)
  ())

(defmethod initialize-instance :after ((interface steamhttp) &key version steamworks)
  (setf (handle interface) (get-interface-handle* steamworks 'steam::client-get-isteam-http
                                                  (t-or version steam::steamhttp-interface-version))))
