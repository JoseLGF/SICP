#lang scheme

; 1.31 Product

; We can express the generic concept of sumation as follows:
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

; Additionally, express the generic concept of product by:
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (identity x) x)
(define (inc x) (+ x 1))
(define (cube x) (* x x x))

(product identity 1 inc 6)
(product cube 1 inc 6)

; Show how to define factorial in terms of product
; fact(n) = n*(n-1)*...*2*1
(define (factorial n)
  (product identity 1 inc n))
(factorial 9)

; Use product to compute approximations to pi using the
; formula:

;  pi    2*4*4*6*6*8...
; ---- = --------------
;  4     3*3*5*5*7*7...

; Wallis product:
;       _______ n    /   4*n*n   \
;  pi    |   |      |  ---------  |
; ---- = |   |      |  4*n*n - 1  |
;  2     |   | i=1   \           /

; Implementation for the problem from the book's definition
(define (pi-approx n)
  (define (pi-term x)
    (if (even? x)
        (* x x)
        (/ 1.0 (* x x))))
  (* 2 (product pi-term 2 inc n)))

; Wallis product implementation
(define (pi-wallis n)
  (define (wallis-term x)
    (/ (* 4 x x) (- (* 4 x x) 1)))
  (* 2.0 (product wallis-term 1 inc n)))

(pi-wallis 15)