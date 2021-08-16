#lang scheme

; Ex 1.3
; Define a procedure P that takes three numbers as arguments and returns the sum
; of the squares of the two larger numbers.
(define (sum-of-squares x y)
  (+ (* x x) (* y y)))

; Sorts two numbers, putting the greater one first
(define (largest a b)
  (cond ((> a b) a)
        (else b)))

(largest 4 4)
(largest 5 4)
(largest 3 5)

(define (P a b c)
  (sum-of-squares (largest a b)
                  (largest b c)))

