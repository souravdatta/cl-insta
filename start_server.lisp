(ql:quickload :cl-insta)
(setf cl-insta:*cl-insta-root* "/src/quicklisp/local-projects/cl-insta")
(princ "Starting server at port 3000")
(cl-insta:start-server :port 3000)
