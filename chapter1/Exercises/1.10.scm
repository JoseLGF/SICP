#lang scheme

; Exercise 1.10

; The definition of the Ackermann's function is:
(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

(A 1 10)
(A 2 4)
(A 3 3)
; Give concise mathematical definitions for the following
; functions:
(define (f n) (A 0 n))
(f 1)
(f 2)
(f 3)
(f 4)
(f 5)
; computes the double of the argument

(define (g n) (A 1 n))
(g 1)
(g 2)
(g 3)
(g 4)
(g 5)
; Computes 2^n

(define (h n) (A 2 n))
(h 1)
(h 2)
(h 3)
(h 4)
; Appears to compute 2^(2^(2^(n-1)))