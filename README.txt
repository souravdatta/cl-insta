cl-insta
============

This is a small utility to which executes (with eval) a block of CL code and gives out the results according to their line numbers. 
This is useful in cases where you want to send some text from editor and get the result with mapping to source line number back.

Git clone the repo inside your Quicklisp directory, usually, ~/quicklisp/local-projects and then load with (ql:quickload :cl-insta).

Usage:

(cl-insta:eval-text text) === Returns the result mapping in an associated list.
(cl-insta:eval-text text 'json) === Returns the result in JSON format.

