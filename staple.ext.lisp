(asdf:load-system :staple-markless)

(defmethod staple:subsystems ((system (eql (asdf:find-system "cl-steamworks"))))
  (list (asdf:find-system "cl-steamworks-generator")))
