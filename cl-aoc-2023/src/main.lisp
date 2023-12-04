(defpackage cl-aoc-2023
  (:use :cl :str))
(in-package :cl-aoc-2023)

(defun main (path)
  (let ((lines (str:lines (str:from-file path))))
    lines))
