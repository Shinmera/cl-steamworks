#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.steamworks)

(defmacro with-inventory-result ((handle iface) &body body)
  `(let ((,handle (with-foreign-value (,handle 'steam::steam-inventory-result-t)
                    ,@body)))
     (make-instance 'inventory-result :interface ,iface :handle ,handle)))

(defclass steaminventory (interface)
  ((prices-available-p :initform NIL :accessor prices-available-p)
   (local-currency :inintform NIL :accessor local-currency)))

(defmethod initialize-instance :after ((interface steaminventory) &key version steamworks)
  (setf (handle interface) (get-interface-handle* steamworks 'steam::client-get-isteam-inventory
                                                  (t-or version steam::steaminventory-interface-version))))

(define-interface-method steaminventory load-items (steam::inventory-load-item-definitions))

(defmethod ensure-prices-available ((inventory steaminventory) &key force)
  (when (or force (not (prices-available-p inventory)))
    (with-call-result (result :poll T) (steam::inventory-request-prices (handle inventory))
      (with-error-on-failure (steam::steam-inventory-request-prices-result result))
      (setf (local-currency inventory) (steam::steam-inventory-request-prices-currency result))
      (setf (prices-available-p inventory) T))))

(defmethod grant ((inventory steaminventory))
  (with-inventory-result (handle inventory)
    (unless (steam::inventory-grant-promo-items (handle inventory) handle)
      (error "FIXME: failed"))))

(defmethod deserialize-result ((inventory steaminventory) (buffer vector))
  (with-inventory-result (handle inventory)
    (cffi:with-pointer-to-vector-data (data buffer)
      (unless (steam::inventory-deserialize-result (handle inventory) handle data (length buffer) NIL)
        (error "FIXME: failed")))))

(defgeneric list-items (thing &key &allow-other-keys))

(defmethod list-items ((inventory steaminventory) &key prices user)
  (cond (user
         (with-call-result (result :poll T) (steam::inventory-request-eligible-promo-item-definitions-ids (handle inventory) (steam-id user))
           (with-error-on-failure (steam::steam-inventory-eligible-promo-item-def-ids-result result))
           (let ((count (steam::steam-inventory-eligible-promo-item-def-ids-num-eligible-promo-item-defs result)))
             (cffi:with-foreign-object (array 'steam::steam-item-def-t count)
               (unless (steam::inventory-get-eligible-promo-item-definition-ids (handle inventory) (steam-id user) array count)
                 (error "FIXME: failed"))
               (loop for i from 0 below count
                     for handle = (cffi:mem-aref array 'steam::steam-item-def-t i)
                     collect (make-instance 'item :interface inventory :handle handle))))))
        (prices
         (ensure-prices-available inventory)
         (let ((count (steam::inventory-get-num-items-with-prices (handle inventory))))
           (cffi:with-foreign-objects ((handles 'steam::steam-item-def-t count)
                                       (prices :uint64 count)
                                       (bases :uint64 count))
             (unless (steam::inventory-get-items-with-prices (handle inventory) handles prices bases count)
               (error "FIXME: failed"))
             (loop for i from 0 below count
                   for handle = (cffi:mem-aref handles 'steam::steam-item-def-t i)
                   for price = (cffi:mem-aref prices :uint64 i)
                   for base = (cffi:mem-aref bases :uint64 i)
                   collect (make-instance 'item :interface inventory :handle handle :price (list base price))))))
        (T
         (cffi:with-foreign-object (count :uint32)
           (unless (steam::inventory-get-item-definition-ids (handle inventory) (cffi:null-pointer) count)
             (error "FIXME: failed"))
           (cffi:with-foreign-object (array 'steam::steam-item-def-t (cffi:mem-ref count :uint32))
             (unless (steam::inventory-get-item-definition-ids (handle inventory) array count)
               (error "FIXME: failed"))
             (loop for i from 0 below (cffi:mem-ref count :uint32)
                   for handle = (cffi:mem-aref array 'steam::steam-item-def-t i)
                   collect (make-instance 'item :interface inventory :handle handle)))))))

(defmethod list-item-instances ((inventory steaminventory))
  (with-c-objects ((result (with-inventory-result (handle inventory)
                             (unless (steam::inventory-get-all-items (handle inventory) handle)
                               (error "FIXME: failed")))))
    (mapcar #'first (list-items result))))

(defclass item-instance (interface-object)
  ()
  (:default-initargs :interface 'steaminventory))

(defmethod consume ((item item-instance) &optional (quantity 1))
  (with-inventory-result (handle (iface item))
    (unless (steam::inventory-consume-item (iface* item) handle (handle item) quantity))))

;; FIXME: GetItemsById

(defclass item (interface-object)
  ((price :initform NIL :initarg :price))
  (:default-initargs :interface 'steaminventory))

(defmethod grant-promo ((item item))
  (with-inventory-result (handle (iface item))
    (unless (steam::inventory-add-promo-item (iface* item) handle (handle item))
      (error "FIXME: failed"))))

(defmethod grant-promo ((items cons))
  (with-inventory-result (handle (iface (car items)))
    (cffi:with-foreign-object ((g 'steam::steam-item-def-t (length items)))
      (loop for i from 0
            for el in items
            do (setf (cffi:mem-aref 'steam::steam-item-def-t i) (handle el)))
      (unless (steam::inventory-add-promo-items (iface* (car items)) handle defs (length items))
        (error "FIXME: failed")))))

(defun generate-items (items)
  (with-inventory-result (handle (iface (caar items)))
    (cffi:with-foreign-object ((g 'steam::steam-item-def-t (length items))
                               (q :uint32 (length items)))
      (loop for i from 0
            for (el qu) in items
            do (setf (cffi:mem-aref 'steam::steam-item-def-t i) (handle el))
               (setf (cffi:mem-aref :uint32 i) qu))
      (unless (steam::inventory-add-promo-items (iface* (caar items)) handle defs (length items))
        (error "FIXME: failed")))))

(defmethod exchange ((consume item-instance) (grant item))
  (with-inventory-result (handle (iface consume))
    (cffi:with-foreign-objects ((c 'steam::steam-item-def-t 1)
                                (g 'steam::steam-item-def-t 1)
                                (q :uint32 1))
      (setf (cffi:mem-aref c 'steam::steam-item-def-t 0) (handle consume))
      (setf (cffi:mem-aref g 'steam::steam-item-def-t 0) (handle grant))
      (setf (cffi:mem-aref q :uint32) 1)
      (unless (steam::inventory-exchange-items (iface* consume) handle g q 1 c q 1)
        (error "FIXME: failed")))))

(defmethod exchange ((consume cons) (grant item))
  (with-inventory-result (handle (iface consume))
    (cffi:with-foreign-objects ((c 'steam::steam-item-def-t (length consume))
                                (g 'steam::steam-item-def-t 1)
                                (q :uint32 (length consume)))
      (loop for i from 0
            for (el qu) in consume
            do (check-type el 'item-instance)
               (setf (cffi:mem-aref c 'steam::steam-item-def-t i) (handle el))
               (setf (cffi:mem-aref q :uint32) qu))
      (setf (cffi:mem-aref g 'steam::steam-item-def-t 0) (handle grant))
      (unless (steam::inventory-exchange-items (iface* consume) handle g q 1 c q 1)
        (error "FIXME: failed")))))

(defmethod property ((item item) (name string))
  ;; Fucking fuck steam API doesn't give you any way of knowing whatever the fuck size you should
  ;; use for the values buffer here. It PRETENDS to, if you pass NULL for the name, but then STILL
  ;; puts some shit into the buffer, and who the hell knows how big it should be for that.
  ;; Anyway, 4kb aught to be enough for anybody
  (cffi:with-foreign-objects ((length :uint32)
                              (value :char 4096))
    (setf (cffi:mem-ref length :uint32) 4096)
    (unless (steam::inventory-get-item-definition-property (iface* item) (handle item) name value length)
      (error "FIXME: failed"))
    (cffi:foreign-string-to-lisp value :count (cffi:mem-ref length :uint32) :encoding :utf-8)))

(defmethod list-properties ((item item))
  (cffi:with-foreign-objects ((length :uint32) (value :char 4096))
    (setf (cffi:mem-ref length :uint32) 4096)
    (unless (steam::inventory-get-item-definition-property (iface* item) (handle item) (cffi:null-pointer) value length)
      (error "FIXME: failed"))
    (split-string (cffi:foreign-string-to-lisp value :encoding :utf-8) #\,)))

(defmethod properties ((item item))
  (loop for name in (list-properties item)
        collect (cons name (property item name))))

(defmethod price ((item item))
  (or (slot-value item 'price)
      (with-foreign-values ((price :uint64)
                            (base :uint64))
        (ensure-prices-available (iface item))
        (unless (steam::inventory-get-item-price (iface* item) (handle item) price base)
          (error "FIXME: failed"))
        (setf (slot-value item 'price) (list (cffi:mem-ref base :uint64)
                                             (cffi:mem-ref price :uint64))))))

(defclass inventory-result (c-managed-object interface-item)
  ()
  (:default-initargs :interface 'steaminventory))

(defmethod allocate-handle ((result inventory-result))
  (error "Cannot allocate an inventory result."))

(defmethod free-handle-function ((result inventory-result) handle)
  (let ((interface (iface* result)))
    (lambda () (steam::inventory-destroy-result interface handle))))

(define-interface-submethod inventory-result check-steam-id (steam::inventory-check-result-steam-id id)
  (unless result (error "FIXME: bad ID")))
(define-interface-submethod inventory-result status (steam::inventory-get-result-status))
(define-interface-submethod inventory-result result-time (steam::inventory-get-result-timestamp)
  (unix->universal result))

(defmethod result-property ((result inventory-result) (name string) &optional (index 0))
  ;; Same shit as above
  (cffi:with-foreign-objects ((length :uint32)
                              (value :char 4096))
    (setf (cffi:mem-ref length :uint32) 4096)
    (unless (steam::inventory-get-result-item-property (iface* result) (handle result) index name value length)
      (error "FIXME: failed"))
    (cffi:foreign-string-to-lisp value :count (cffi:mem-ref length :uint32) :encoding :utf-8)))

(defmethod list-result-properties ((result inventory-result) &optional (index 0))
  (cffi:with-foreign-objects ((length :uint32) (value :char 4096))
    (setf (cffi:mem-ref length :uint32) 4096)
    (unless (steam::inventory-get-result-item-property (iface* result) (handle result) index (cffi:null-pointer) value length)
      (error "FIXME: failed"))
    (split-string (cffi:foreign-string-to-lisp value :encoding :utf-8) #\,)))

(defmethod result-properties ((result inventory-result) &optional (index *))
  (loop for name in (list-result-properties result index)
        collect (cons name (result-property result name index))))

(defmethod list-items ((result inventory-result) &key)
  (cffi:with-foreign-object (count :uint32)
    (unless (steam::inventory-get-result-items (iface* result) (handle result) (cffi:null-pointer) count)
      (error "FIXME: failed"))
    (cffi:with-foreign-object (array 'steam::steam-item-details (cffi:mem-ref count :uint32))
      (unless (steam::inventory-get-result-items (iface* result) (handle result) array count)
        (error "FIXME: failed"))
      (loop for i from 0 below (cffi:mem-ref count :uint32)
            for details = (cffi:mem-aref array 'steam::steam-item-details i)
            collect (list (make-instance 'item :interface inventory :handle (steam::steam-item-details-definition details))
                          (steam::steam-item-details-quantity details)
                          (decode-flags 'steam::esteam-item-flags (steam::steam-item-details-flags details)))))))

(defmethod serialize-result ((result inventory-result))
  (cffi:with-foreign-object (count :uint32)
    (unless (steam::inventory-serialize-result (iface* result) (handle result) (cffi:null-pointer) count)
      (error "FIXME: failed"))
    (let ((buffer (cffi:make-shareable-byte-vector count)))
      (cffi:with-pointer-to-vector-data (data buffer)
        (unless (steam::inventory-serialize-result (iface* result) (handle result) data count)
          (error "FIXME: failed"))
        buffer))))
