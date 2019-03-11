#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(eval-when (:compile-toplevel :load-toplevel :execute)
  (unless (find-package '#:org.shirakumo.fraf.steamworks.cffi)
    (make-package '#:org.shirakumo.fraf.steamworks.cffi :use ())))

(defpackage #:cl-steamworks
  (:nicknames #:org.shirakumo.fraf.steamworks)
  (:local-nicknames (#:steam #:org.shirakumo.fraf.steamworks.cffi))
  (:use #:cl)
  (:export))
