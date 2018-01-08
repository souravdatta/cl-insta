;;;; cl-insta.asd
;;;;
;;;; Copyright (c) 2018 Sourav Datta

(asdf:defsystem #:cl-insta
  :description "Describe cl-insta here"
  :author "Sourav Datta"
  :license "MIT"
  :depends-on (#:cl-json #:hunchentoot #:cl-who #:parenscript)
  :serial t
  :components ((:file "package")
               (:file "cl-insta")
	       (:file "cl-insta-server")))

