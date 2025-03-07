(asdf:defsystem cl-steamworks
  :version "1.0.0"
  :license "zlib"
  :author "Yukari Hafner <shinmera@tymoon.eu>"
  :maintainer "Yukari Hafner <shinmera@tymoon.eu>"
  :description "A wrapper for the Valve SteamWorks API."
  :homepage "https://github.com/Shinmera/cl-steamworks"
  :serial T
  :components ((:file "package")
               (:file "conditions")
               (:file "c-support")
               (:file "toolkit")
               (:file "c-object")
               (:file "callback")
               (:file "callback-class")
               (:file "steamworks")
               (:file "interface")
               (:file "steamclient")
               (:file "steamutils")
               (:file "steamuser")
               (:file "steamfriends")
               (:file "steamapps")
               (:file "steamworkshop")
               (:file "steamgameserver")
               (:file "steamhtmlsurface")
               (:file "steamhttp")
               (:file "steaminput")
               (:file "steaminventory")
               (:file "steammatchmaking")
               (:file "steammusic")
               (:file "steammusicremote")
               (:file "steamnetworking")
               (:file "steamparties")
               (:file "steamremotestorage")
               (:file "steamscreenshots")
               (:file "steamuserstats")
               (:file "steamvideo")
               (:file "documentation"))
  :depends-on (:documentation-utils
               :pathname-utils
               :alexandria
               :trivial-features
               :trivial-garbage
               :trivial-gray-streams
               :float-features
               :babel
               :cffi
               (:feature :sbcl (:require :sb-posix))))
