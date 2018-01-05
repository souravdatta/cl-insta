;;;; cl-insta.lisp
;;;;
;;;; Copyright (c) 2018 Sourav Datta

(in-package #:cl-insta)

;;; "cl-insta" goes here. Hacks and glory await!

(defun try-read (s)
  (with-input-from-string (strm s)
    (handler-case (list 'complete (read strm))
      (end-of-file () (list 'incomplete s)))))

(defun get-lines-from-string (text)
  (with-input-from-string (strm text)
    (loop for text = (read-line strm nil nil) while text collect text)))

(defun get-read-lines (lines &optional (lines-info '()) (line-count 0) (start-string ""))
  (cond
    ((null lines) (reverse lines-info))
    (t (let ((response (if (string= start-string "")
			   (try-read (car lines))
			   (try-read (concatenate 'string start-string (car lines))))))
	 (if (eq (first response) 'complete)
	     (get-read-lines (rest lines)
			     (cons (cons (+ 1 line-count)
					 (rest response))
				   lines-info)
			     (+ 1 line-count)
			     "")
	     (get-read-lines (rest lines)
			     lines-info
			     (+ 1 line-count)
			     (concatenate 'string start-string (car lines))))))))

(defun get-eval-lines (lines-info)
  (loop for info in lines-info
     collect (list (first info)
		   (handler-case (eval (second info))
		     (error (e) e)))))

(defun stringify-result (result)
  (mapcar #'(lambda (pair)
	      (cons (first pair)
		    (format nil (if (stringp (second pair)) "\"~A\"" "~A")
			    (second pair)))) result))

(defun eval-text (text &key (json nil))
  (let ((result (get-eval-lines (get-read-lines (get-lines-from-string text)))))
    (cond
      (json (cl-json:encode-json (stringify-result result)))
      (t result))))



