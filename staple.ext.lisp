(asdf:load-system :staple-markless)
(asdf:load-system :cl-steamworks-generator)

(defmethod staple:subsystems ((system (eql (asdf:find-system "cl-steamworks"))))
  (list (asdf:find-system "cl-steamworks-generator")))
