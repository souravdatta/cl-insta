**cl-insta web
================

There is a web ui that can be used to run Lisp code using above evaluator function online and get the results next to it.
See simple_server_example.lisp to setup your local server. To experiment without setting up locally
Run docker run -it -p <your machine port>:3000 souravdatta/cl-insta


**cl-insta
============

This is a small utility to which executes (with eval) a block of CL code and gives out the results according to their line numbers. 
This is useful in cases where you want to send some text from editor and get the result with mapping to source line number back.

Git clone the repo inside your Quicklisp directory, usually, ~/quicklisp/local-projects and then load with (ql:quickload :cl-insta).

Usage:

`(cl-insta:eval-text text)` === Returns the result mapping in an associated list.
`(cl-insta:eval-text text 'json)` === Returns the result in JSON format.

