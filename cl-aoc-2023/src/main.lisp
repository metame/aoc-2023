(defpackage cl-aoc-2023
  (:use :cl :str))
(in-package :cl-aoc-2023)

(defvar contents '(:red 12 :green 13 :blue 14))

(defun key-it (s)
  (cond
    ((equal s "red") :red)
    ((equal s "green") :green)
    ((equal s "blue") :blue)))

(defun color-possible? (c)
  (if (eq c nil)
      nil
      (>= (getf contents (key-it (second c)))
          (read-from-string (first c)))))

(defun play-possible? (game)
  (let* ((cs (mapcar (lambda (c) (str:split " " c)) (str:split ", " game))))
    (every #'color-possible? cs)))

(defun kim-possible? (line)
  (let* ((l (str:split ": " (str:substring 5 t line)))
         (id (first l))
         (results (second l)))
    (if (every #'play-possible? (str:split "; " results))
        (read-from-string id)
        0)))

(defun main (path)
  (let ((lines (str:lines (str:from-file path))))
    (reduce #'+ (mapcar #'kim-possible? lines))))
