(in-package #:org.shirakumo.fraf.steamworks)

(defmacro with-inventory-result ((handle iface) &body body)
  `(let ((,handle (with-foreign-value (,handle 'steam::steam-inventory-result)
                    ,@body)))
     (make-instance 'inventory-result :interface ,iface :handle ,handle)))

(defclass steaminventory (interface)
  ((prices-available-p :initform NIL :accessor prices-available-p)
   (local-currency :initform NIL :accessor local-currency)))

(defmethod initialize-instance :after ((interface steaminventory) &key (version T) steamworks)
  (setf (handle interface) (get-interface-handle* steamworks 'steam::client-get-isteam-inventory
                                                  (t-or version STEAM::STEAMINVENTORY-INTERFACE-VERSION))))

(define-interface-method steaminventory load-items (steam::inventory-load-item-definitions))

(defmethod ensure-prices-available ((inventory steaminventory) &key force)
  (when (or force (not (prices-available-p inventory)))
    (with-call-result (result :poll T) (steam::inventory-request-prices (handle inventory))
      (check-result (steam::steam-inventory-request-prices-result result)
                    'steam::inventory-request-prices)
      (setf (local-currency inventory) (steam::steam-inventory-request-prices-currency result))
      (setf (prices-available-p inventory) T))))

(defmethod grant ((inventory steaminventory))
  (with-inventory-result (handle inventory)
    (with-invalid-check NIL (steam::inventory-grant-promo-items (handle inventory) handle))))

(defmethod deserialize-result ((inventory steaminventory) (buffer vector))
  (with-inventory-result (handle inventory)
    (cffi:with-pointer-to-vector-data (data buffer)
      (with-invalid-check NIL (steam::inventory-deserialize-result (handle inventory) handle data (length buffer) NIL)))))

(defgeneric list-items (thing &key &allow-other-keys))

(defmethod list-items ((inventory steaminventory) &key prices user ids)
  (cond (user
         (with-call-result (result :poll T) (steam::inventory-request-eligible-promo-item-definitions-ids (handle inventory) (steam-id user))
           (check-result (steam::steam-inventory-eligible-promo-item-def-ids-result result)
                         'steam::inventory-request-eligible-promo-item-definitions-ids)
           (let ((count (steam::steam-inventory-eligible-promo-item-def-ids-eligible-promo-item-defs result)))
             (cffi:with-foreign-object (array 'steam::steam-item-def count)
               (with-invalid-check NIL (steam::inventory-get-eligible-promo-item-definition-ids (handle inventory) (steam-id user) array count))
               (loop for i from 0 below count
                     for handle = (cffi:mem-aref array 'steam::steam-item-def i)
                     collect (ensure-iface-obj 'item :interface inventory :handle handle))))))
        (prices
         (ensure-prices-available inventory)
         (let ((count (steam::inventory-get-num-items-with-prices (handle inventory))))
           (cffi:with-foreign-objects ((handles 'steam::steam-item-def count)
                                       (prices :uint64 count)
                                       (bases :uint64 count))
             (with-invalid-check NIL (steam::inventory-get-items-with-prices (handle inventory) handles prices bases count))
             (loop for i from 0 below count
                   for handle = (cffi:mem-aref handles 'steam::steam-item-def i)
                   for price = (cffi:mem-aref prices :uint64 i)
                   for base = (cffi:mem-aref bases :uint64 i)
                   collect (ensure-iface-obj 'item :interface inventory :handle handle :price (list base price))))))
        (ids
         (cffi:with-foreign-objects ((idsp 'steam::steam-item-instance-id (length ids))
                                     (result 'steam::steam-inventory-result))
           (loop for i from 0 below (length ids)
                 for id in ids
                 do (setf (cffi:mem-aref idsp 'steam::steam-item-instance-id i) id))
           (with-invalid-check NIL (steam::inventory-get-items-by-id (handle inventory) result idsp 1))
           (let* ((handle (cffi:mem-ref result 'steam::steam-inventory-result))
                  (result (make-instance 'inventory-result :interface inventory :handle handle)))
             (list-items result))))
        (T
         (cffi:with-foreign-object (count :uint32)
           (with-invalid-check NIL (steam::inventory-get-item-definition-ids (handle inventory) (cffi:null-pointer) count))
           (cffi:with-foreign-object (array 'steam::steam-item-def (cffi:mem-ref count :uint32))
             (with-invalid-check NIL (steam::inventory-get-item-definition-ids (handle inventory) array count))
             (loop for i from 0 below (cffi:mem-ref count :uint32)
                   for handle = (cffi:mem-aref array 'steam::steam-item-def i)
                   collect (ensure-iface-obj 'item :interface inventory :handle handle)))))))

(defmethod list-item-instances ((inventory steaminventory))
  (with-c-objects ((result (with-inventory-result (handle inventory)
                             (with-invalid-check NIL (steam::inventory-get-all-items (handle inventory) handle)))))
    (mapcar #'first (list-items result))))

(defmethod update-item-properties ((inventory steaminventory) updates)
  (let ((handle (steam::inventory-start-update-properties (handle inventory))))
    (dolist (update updates)
      (destructuring-bind (item property &optional (value NIL value-p)) update
        (if value-p
            (check-invalid NIL (etypecase value
                                 (string (steam::inventory-set-property-string (handle inventory) handle (handle item) property value))
                                 (boolean (steam::inventory-set-property-bool (handle inventory) handle (handle item) property value))
                                 ((unsigned-byte 64) (steam::inventory-set-property-int64 (handle inventory) handle (handle item) property value))
                                 (float (steam::inventory-set-property-float (handle inventory) handle (handle item) property (coerce value 'single-float))))
                           'steam::inventory-set-property)
            (with-invalid-check NIL (steam::inventory-remove-property (handle inventory) handle (handle item) property)))))
    (with-inventory-result (result inventory)
      (with-invalid-check NIL (steam::inventory-submit-update-properties (handle inventory) handle result)))))

(defmethod item ((index integer) (inventory steaminventory))
  (cffi:with-foreign-objects ((ids 'steam::steam-item-instance-id)
                              (result 'steam::steam-inventory-result))
    (setf (cffi:mem-ref ids 'steam::steam-item-instance-id) index)
    (with-invalid-check NIL (steam::inventory-get-items-by-id (handle inventory) result ids 1))
    (let* ((handle (cffi:mem-ref result 'steam::steam-inventory-result))
           (result (make-instance 'inventory-result :interface inventory :handle handle)))
      (first (list-items result)))))

(defclass item-instance (interface-object)
  ()
  (:default-initargs :interface 'steaminventory))

(defmethod consume ((item item-instance) &optional (quantity 1))
  (with-inventory-result (handle item)
    (with-invalid-check NIL (steam::inventory-consume-item (iface* item) handle (handle item) quantity))))

(defmethod transfer ((source item-instance) (destination item-instance) &optional (quantity 1))
  (with-inventory-result (handle source)
    (with-invalid-check NIL (steam::inventory-transfer-item-quantity (iface* source) handle (handle source) quantity (handle destination)))))

(defmethod (setf property) (value (item item-instance) (property string))
  (check-type value (or string boolean (unsigned-byte 64) float))
  (update-item-properties (iface item) (list (list item property value))))

(defclass item (interface-object)
  ((price :initform NIL :initarg :price))
  (:default-initargs :interface 'steaminventory))

(defmethod grant-promo ((item item))
  (with-inventory-result (handle item)
    (with-invalid-check NIL (steam::inventory-add-promo-item (iface* item) handle (handle item)))))

(defmethod grant-promo ((items cons))
  (with-inventory-result (handle (car items))
    (cffi:with-foreign-object (g 'steam::steam-item-def (length items))
      (loop for i from 0
            for el in items
            do (setf (cffi:mem-aref g 'steam::steam-item-def i) (handle el)))
      (with-invalid-check NIL (steam::inventory-add-promo-items (iface* (car items)) handle g (length items))))))

(defun generate-items (items)
  (with-inventory-result (handle (caar items))
    (cffi:with-foreign-objects ((g 'steam::steam-item-def (length items))
                                (q :uint32 (length items)))
      (loop for i from 0
            for item in items
            do (destructuring-bind (el qu) (enlist item 1)
                 (check-type el item)
                 (setf (cffi:mem-aref g 'steam::steam-item-def i) (handle el))
                 (setf (cffi:mem-aref q :uint32 i) qu)))
      (with-invalid-check NIL (steam::inventory-add-promo-items (iface* (caar items)) handle g (length items))))))

(defmethod exchange ((consume item-instance) (grant item))
  (with-inventory-result (handle consume)
    (cffi:with-foreign-objects ((c 'steam::steam-item-def 1)
                                (g 'steam::steam-item-def 1)
                                (q :uint32 1))
      (setf (cffi:mem-aref c 'steam::steam-item-def 0) (handle consume))
      (setf (cffi:mem-aref g 'steam::steam-item-def 0) (handle grant))
      (setf (cffi:mem-aref q :uint32) 1)
      (with-invalid-check NIL (steam::inventory-exchange-items (iface* consume) handle g q 1 c q 1)))))

(defmethod exchange ((consume cons) (grant item))
  (with-inventory-result (handle consume)
    (cffi:with-foreign-objects ((c 'steam::steam-item-def (length consume))
                                (g 'steam::steam-item-def 1)
                                (q :uint32 (length consume)))
      (loop for i from 0
            for item in consume
            do (destructuring-bind (el qu) (enlist item 1)
                 (check-type el item-instance)
                 (setf (cffi:mem-aref c 'steam::steam-item-def i) (handle el))
                 (setf (cffi:mem-aref q :uint32) qu)))
      (setf (cffi:mem-aref g 'steam::steam-item-def 0) (handle grant))
      (with-invalid-check NIL (steam::inventory-exchange-items (iface* consume) handle g q 1 c q 1)))))

(defmethod property ((item item) (name string))
  ;; Fucking fuck steam API doesn't give you any way of knowing whatever the fuck size you should
  ;; use for the values buffer here. It PRETENDS to, if you pass NULL for the name, but then STILL
  ;; puts some shit into the buffer, and who the hell knows how big it should be for that.
  ;; Anyway, 4kb aught to be enough for anybody
  (cffi:with-foreign-objects ((length :uint32)
                              (value :char 4096))
    (setf (cffi:mem-ref length :uint32) 4096)
    (with-invalid-check NIL (steam::inventory-get-item-definition-property (iface* item) (handle item) name value length))
    (cffi:foreign-string-to-lisp value :count (cffi:mem-ref length :uint32) :encoding :utf-8)))

(defmethod list-properties ((item item))
  (cffi:with-foreign-objects ((length :uint32) (value :char 4096))
    (setf (cffi:mem-ref length :uint32) 4096)
    (with-invalid-check NIL (steam::inventory-get-item-definition-property (iface* item) (handle item) (cffi:null-pointer) value length))
    (split-string (cffi:foreign-string-to-lisp value :encoding :utf-8) #\,)))

(defmethod properties ((item item))
  (loop for name in (list-properties item)
        collect (cons name (property item name))))

(defmethod price ((item item))
  (or (slot-value item 'price)
      (with-foreign-values ((price :uint64)
                            (base :uint64))
        (ensure-prices-available (iface item))
        (with-invalid-check NIL (steam::inventory-get-item-price (iface* item) (handle item) price base))
        (setf (slot-value item 'price) (list (cffi:mem-ref base :uint64)
                                             (cffi:mem-ref price :uint64))))))

(defmethod purchase-items ((items cons))
  (cffi:with-foreign-objects ((p 'steam::steam-item-def (length items))
                              (q :uint32 (length items)))
    (loop for i from 0
          for item in items
          do (destructuring-bind (el qu) (enlist item 1)
               (check-type el item)
               (setf (cffi:mem-aref p 'steam::steam-item-def i) (handle el))
               (setf (cffi:mem-aref q :uint32 i) qu)))
    (with-call-result (result :poll T) (steam::inventory-start-purchase (iface* (caar items)) p q (length items))
      (check-result (steam::steam-inventory-start-purchase-result result)
                    'steam::inventory-start-purchase)
      (list :order-id (steam::steam-inventory-start-purchase-order-id result)
            :transaction-id (steam::steam-inventory-start-purchase-trans-id result)))))

(defmethod trigger-item-drop ((item item))
  (with-inventory-result (handle item)
    (with-invalid-check NIL (steam::inventory-trigger-item-drop (iface* item) handle (handle item)))))

(defclass inventory-result (c-managed-object interface-object)
  ()
  (:default-initargs :interface 'steaminventory
                     :free-on-gc T))

(defmethod allocate-handle ((result inventory-result) &key)
  (error "Cannot allocate an inventory result."))

(defmethod free-handle-function ((result inventory-result) handle)
  (let ((interface (iface* result)))
    (lambda () (steam::inventory-destroy-result interface handle))))

(define-interface-submethod inventory-result check-steam-id (steam::inventory-check-result-steam-id id)
  (check-invalid NIL result 'steam::inventory-check-result-steam-id))
(define-interface-submethod inventory-result status (steam::inventory-get-result-status))
(define-interface-submethod inventory-result result-time (steam::inventory-get-result-timestamp)
  (unix->universal result))

(defmethod result-property ((result inventory-result) (name string) &optional (index 0))
  ;; Same shit as above
  (cffi:with-foreign-objects ((length :uint32)
                              (value :char 4096))
    (setf (cffi:mem-ref length :uint32) 4096)
    (with-invalid-check NIL (steam::inventory-get-result-item-property (iface* result) (handle result) index name value length))
    (cffi:foreign-string-to-lisp value :count (cffi:mem-ref length :uint32) :encoding :utf-8)))

(defmethod list-result-properties ((result inventory-result) &optional (index 0))
  (cffi:with-foreign-objects ((length :uint32) (value :char 4096))
    (setf (cffi:mem-ref length :uint32) 4096)
    (with-invalid-check NIL (steam::inventory-get-result-item-property (iface* result) (handle result) index (cffi:null-pointer) value length))
    (split-string (cffi:foreign-string-to-lisp value :encoding :utf-8) #\,)))

(defmethod result-properties ((result inventory-result) &optional (index *))
  (loop for name in (list-result-properties result index)
        collect (cons name (result-property result name index))))

(defmethod list-items ((result inventory-result) &key)
  (cffi:with-foreign-object (count :uint32)
    (with-invalid-check NIL (steam::inventory-get-result-items (iface* result) (handle result) (cffi:null-pointer) count))
    (cffi:with-foreign-object (array '(:struct steam::steam-item-details) (cffi:mem-ref count :uint32))
      (with-invalid-check NIL (steam::inventory-get-result-items (iface* result) (handle result) array count))
      (loop for i from 0 below (cffi:mem-ref count :uint32)
            for details = (cffi:mem-aref array '(:struct steam::steam-item-details) i)
            collect (list (ensure-iface-obj 'item :interface (iface result) :handle (steam::steam-item-details-definition details))
                          (steam::steam-item-details-quantity details)
                          (decode-flags 'steam::esteam-item-flags (steam::steam-item-details-flags details)))))))

(defmethod serialize-result ((result inventory-result))
  (cffi:with-foreign-object (count :uint32)
    (with-invalid-check NIL (steam::inventory-serialize-result (iface* result) (handle result) (cffi:null-pointer) count))
    (let ((buffer (cffi:make-shareable-byte-vector (cffi:mem-ref count :uint32))))
      (cffi:with-pointer-to-vector-data (data buffer)
        (with-invalid-check NIL (steam::inventory-serialize-result (iface* result) (handle result) data count))
        buffer))))
