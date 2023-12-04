(defpackage cl-aoc-2023/tests/main
  (:use :cl
        :cl-aoc-2023
        :rove))
(in-package :cl-aoc-2023/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :cl-aoc-2023)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
