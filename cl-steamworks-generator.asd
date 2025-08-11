(asdf:defsystem cl-steamworks-generator
  :version "1.0.0"
  :license "zlib"
  :author "Yukari Hafner <shinmera@tymoon.eu>"
  :maintainer "Yukari Hafner <shinmera@tymoon.eu>"
  :description "Generator for the low-level steamworks bindings."
  :homepage "https://shinmera.com/project/cl-steamworks"
  :serial T
  :components ((:file "package")
               (:file "c-support")
               (:file "generator"))
  :depends-on (:yason
               :uiop
               :cffi
               :pathname-utils
               :parse-number
               :alexandria
               :cl-ppcre))
