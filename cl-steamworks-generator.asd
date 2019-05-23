#|
 This file is a part of cl-steamworks
 (c) 2019 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(asdf:defsystem cl-steamworks-generator
  :version "1.0.0"
  :license "Artistic"
  :author "Nicolas Hafner <shinmera@tymoon.eu>"
  :maintainer "Nicolas Hafner <shinmera@tymoon.eu>"
  :description "Generator for the low-level steamworks bindings."
  :homepage "https://github.com/Shinmera/cl-steamworks"
  :serial T
  :components ((:file "package")
               (:file "c-support")
               (:file "generator"))
  :depends-on (:yason
               :cffi
               :pathname-utils
               :parse-number
               :alexandria
               :cl-ppcre))
