(defpackage cl-aoc-2023
  (:use :cl :str))
(in-package :cl-aoc-2023)

;; shared
(defun key-it (s)
  (cond
    ((equal s "red") :red)
    ((equal s "green") :green)
    ((equal s "blue") :blue)))

(defun play->colors (play)
  (mapcar (lambda (c) (str:split " " c)) (str:split ", " play)))

(defun ->play (results)
  (str:split "; " results))

(defun line->id&results (line)
  (str:split ": " (str:substring 5 t line)))

;; part 1
(defvar contents '(:red 12 :green 13 :blue 14))

(defun color-possible? (c)
  (>= (getf contents (key-it (second c)))
      (read-from-string (first c))))

(defun play-possible? (play)
  (every #'color-possible? (play->colors play)))

(defun kim-possible? (line)
  (let* ((l (line->id&results line))
         (id (first l))
         (results (second l)))
    (if (every #'play-possible? (->play results))
        (read-from-string id)
        0)))

(defun part1 (path)
  (let ((lines (str:lines (str:from-file path))))
    (reduce #'+ (mapcar #'kim-possible? lines))))

;; part 2
(defun play->colors-pl (play)
  (reduce (lambda (pl c)
            (if (eq nil c)
                pl
                (cons (key-it (second c))
                      (cons (read-from-string (first c)) pl))))
          (play->colors play)
          :initial-value '()))

(defun max-color (c pl1 pl2)
  (max (getf pl1 c 0) (getf pl2 c 0)))

(defun ->max-colors (results)
  (reduce (lambda (r play)
            (let* ((colors (play->colors-pl play))
                   (red (max-color :red r colors))
                   (blue (max-color :blue r colors))
                   (green (max-color :green r colors)))
              (list :red red :blue blue :green green)))
          (->play results)
          :initial-value '()))

(defun min-possible (line)
  (let* ((l (line->id&results line))
         (max-colors (->max-colors (second l))))
    (* (or (getf max-colors :red) 1)
       (or (getf max-colors :blue) 1)
       (or (getf max-colors :green) 1))))

(defun part2 (path)
  (let ((lines (str:lines (str:from-file path))))
    (reduce #'+ (mapcar #'min-possible lines))))
