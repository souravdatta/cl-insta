(ql:quickload :cl-insta)

(setf cl-insta:*cl-insta-root* "path-to-cl-insta")
(cl-insta:start-server :port 3000)
