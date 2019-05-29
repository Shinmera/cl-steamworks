#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamscreenshots (interface)
  ())

(defmethod initialize-instance :after ((interface steamscreenshots) &key version steamworks)
  (setf (handle interface) (get-interface-handle* steamworks 'steam::client-get-isteam-screenshots
                                                  (t-or version STEAM::STEAMSCREENSHOTS-INTERFACE-VERSION))))

(define-interface-method steamscreenshots trigger (steam::screenshots-trigger-screenshot))
(define-interface-method steamscreenshots hooked-p (steam::screenshots-is-screenshots-hooked))
(define-interface-method steamscreenshots (setf hooked-p) (value steam::screenshots-hook-screenshots))

(defmethod add-screenshot ((interface steamscreenshots) &key file thumbnail vr width height pixels)
  (let ((handle (cond (pixels
                       (cffi:with-pointer-to-vector-data (buffer pixels)
                         (steam::screenshots-write-screenshot
                          (handle interface) buffer (/ (length pixels) 3) width height)))
                      (vr
                       (destructuring-bind (type vrfile) vr
                         (steam::screenshots-add-vrscreenshot-to-library
                          (handle interface) type (uiop:native-namestring file) (uiop:native-namestring vrfile))))
                      (file
                       (steam::screenshots-add-screenshot-to-library
                        (handle interface) (uiop:native-namestring file)
                        (if thumbnail (uiop:native-namestring thumbnail) (cffi:null-pointer))
                        width height))
                      (T
                       (error 'argument-missing :argument '(or pixels vr file))))))
    (check-invalid 0 handle)
    (make-instance 'screenshot :interface interface :handle handle)))

(defclass screenshot (interface-object)
  ()
  (:default-initargs :interface 'steamscreenshots))

(define-interface-submethod screenshot (setf location) ((location string) steam::screenshots-set-location)
  (check-invalid NIL result 'steam::screenshots-set-location))

(defmethod add-tag ((user friend) (screenshot screenshot))
  (with-invalid-check NIL (steam::screenshots-tag-user (iface* screenshot) (handle screenshot) (steam-id user))))

(defmethod add-tag ((file workshop-file) (screenshot screenshot))
  (with-invalid-check NIL (steam::screenshots-tag-published-file (iface* screenshot) (handle screenshot) (handle file))))
