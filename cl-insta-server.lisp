(in-package :cl-insta)
(defun start-server (&key (port 8082))
  (start (make-instance 'easy-acceptor
			:port port
			:document-root (truename "."))))

(defmacro page (&body body)
  `(with-html-output (*standard-output*)
     (:html
      (:head
       (:title "Cl-INSTA")
       (:link :type "text/css"
	      :rel "stylesheet"
	      :href "/styles/cl-insta.css")
       (:script :type "text/javascript"
		:src "/js/jquery-3.2.1.min.js")
       (:script :type "text/javascript"
		:src "/js/cl-insta.js"))
      (:body
       ,@body))))

(define-easy-handler (index :uri "/") ()
    (page
        (:h3 "cl-instathon [use ctrl + enter to eval all code on left]")
	(:div :id "content"
	      (:textarea :id "code-pane" :class "pane")
	      (:textarea :id "result-pane" :class "pane" :disabled "true"))))

(define-easy-handler (eval-code :uri "/eval-code" :default-request-type :post)
    (data)
  (let ((code-data (raw-post-data :force-text t)))
    (eval-text code-data :json t)))





	     
