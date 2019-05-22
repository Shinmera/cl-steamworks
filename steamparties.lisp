#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defclass steamparties (interface)
  ())

(defmethod initialize-instance :after ((interface steamparties) &key version steamworks)
  (setf (handle interface) (get-interface-handle* steamworks 'steam::client-get-isteam-parties
                                                  (t-or version steam::steamparties-interface-version))))

(defmethod beacon-locations ((interface steamparties))
  (let ((count (with-foreign-value (count :uint32)
                 (unless (steam::parties-get-num-available-beacon-locations (handle interface) count)
                   (error "FIXME: failed")))))
    (cffi:with-foreign-object (array '(:struct steam::steam-party-beacon-location) count)
      (unless (steam::parties-get-available-beacon-locations (handle interface) array count)
        (error "FIXME: failed"))
      (loop for i from 0 below count
            for struct = (cffi:mem-aref array '(:struct steam::steam-party-beacon-location) i)
            collect (ensure-iface-obj 'beacon-location :interface interface :handle struct)))))

(defmethod beacons ((interface steamparties))
  (loop for i from 0 below (steam::parties-get-num-active-beacons (handle interface))
        for struct = (steam::parties-get-beacon-by-index (handle interface) i)
        collect (ensure-iface-obj 'beacon :interface interface
                                          :type (steam::steam-party-beacon-location-type struct)
                                          :handle (steam::steam-party-beacon-location-location-id struct))))

(defclass beacon-location (interface-object)
  ((type :initarg :type :initform (error "FIXME: type required") :reader location-type))
  (:default-initargs :interface 'steamparties))

(defclass beacon (c-managed-object interface-object)
  ((owner :reader owner)
   (location :reader location)
   (metadata :reader metadata))
  (:default-initargs :interface 'steamparties))

(defmethod initialize-instance :after ((beacon beacon) &key)
  (cffi:with-foreign-objects ((owner 'steam::steam-id)
                              (location '(:struct steam::steam-party-beacon-location))
                              ;; We have no idea of knowing how big this should be.
                              (metadata :uchar 4096))
    (unless (steam::parties-get-beacon-details (iface* beacon) (handle beacon) owner location metadata 4096)
      (error "FIXME: failed"))
    (setf (slot-value beacon 'owner) (ensure-iface-obj 'friend :handle (cffi:mem-ref owner 'steam::steam-id)
                                                               :interface (interface 'steamfriends beacon)))
    (let ((struct (cffi:mem-ref location '(:struct steam::steam-party-beacon-location))))
      (setf (slot-value beacon 'location) (ensure-iface-obj 'beacon-location :type (steam::steam-party-beacon-location-type struct)
                                                                             :handle (steam::steam-party-beacon-location-location-id struct)
                                                                             :interface (iface beacon))))
    (setf (slot-value beacon 'metadata) (cffi:foreign-string-to-lisp metadata :encoding :utf-8 :count 4096))))

(defmethod allocate-handle ((beacon beacon) &key open-slots location connect-string metadata)
  (check-type location beacon-location)
  (check-utf8-size 256 connect-string)
  (cffi:with-foreign-object (locptr '(:struct steam::steam-party-beacon-location))
    (setf (cffi:foreign-slot-value locptr '(:struct steam::steam-party-beacon-location) 'steam::type) (location-type location))
    (setf (cffi:foreign-slot-value locptr '(:struct steam::steam-party-beacon-location) 'steam::location-id) (handle location))
    (with-call-result (result :poll T) (steam::parties-create-beacon (iface* beacon) open-slots locptr
                                                                     connect-string (or metadata ""))
      (with-error-on-failure (steam::create-beacon-callback-result result))
      (steam::create-beacon-callback-beacon-id result))))

(defmethod free-handle-function ((beacon beacon) handle)
  (let ((interface (iface* beacon)))
    (lambda () (steam::parties-destroy-beacon interface handle))))

(define-interface-submethod beacon complete-reservation (steam::parties-on-reservation-completed (user integer)))
(define-interface-submethod beacon (setf open-slots) ((value integer) steam::parties-change-num-open-slots))
(define-interface-submethod beacon join (steam::parties-join-party)
  (let ((result (poll-for-result 'steam::join-party-callback result)))
    (with-error-on-failure (steam::join-party-callback-result result))
    (steam::join-party-callback-connect-string result)))

(defmethod complete-reservation ((beacon beacon) (user friend))
  (complete-reservation beacon (steam-id user)))
