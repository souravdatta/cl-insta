(in-package :cl-insta)

(defparameter *cl-insta-root* nil)

(define-condition unknown-document-root-error (error)
  ())

(defun start-server (&key (port 8082))
  (restart-case
      (if (not *cl-insta-root*)
	  (error 'unknown-document-root-error)
	  (start (make-instance 'easy-acceptor
				:port port
				:document-root (truename *cl-insta-root*))))
    (use-value (v)
      :report "Specify cl-insta location in absolute path"
      :interactive (lambda () (list (read-line)))
      (progn
	(setf *cl-insta-root* v)
	(start-server :port port)))
    (show-error ()
      (format t "Please set cl-insta:*cl-insta-root* to the absolute path where you have installed this package.~%Typically this would be ~~/quicklisp/local-projects/cl-insta.~%"))))

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
      (:h2 "(cl-insta)")
      (:h3 "[Ctrl + Enter to evaluate code on left]")
      (:div :id "content"
	    (:textarea :id "code-pane" :class "pane")
	    (:div :id "result-pane" :class "pane result-pane" :disabled "true"))))

(define-easy-handler (eval-code :uri "/eval-code" :default-request-type :post)
    (data)
  (let ((code-data (raw-post-data :force-text t)))
    (eval-text code-data :json t)))





	     
