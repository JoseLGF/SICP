#lang scheme

; Procedures as Arguments

; ----------------------------------
; Consider the following procedures:
; ----------------------------------
; Compute the sum of integers from a through b
(define (sum-integers a b)
  (cond ((> a b) 0)
        ((= b a) b)
        (else (+ a (sum-integers (+ a 1) b)))))

; Better implementation (book's solution)
(define (sum-integers2 a b)
  (if (> a b)
            0
            (+ a (sum-integers2 (+ a 1) b))))

; Compute the sum of cubes of the integers in the given range
(define (sum-cubes a b)
  (define (cube x) (* x x x))
    (if (> a b)
       0
       (+ (cube a) (sum-cubes (+ a 1) b))))
(sum-cubes 4 6)

; Compute the sum of a sequence of terms in the series
;
;  1     1     1
; --- + --- + ---- + ...
; 1*3   5*7   9*11
(define (pi-sum a b)
  (if (> a b)
      0
      (+ (/ 1.0 (* a (+ a 2))) (pi-sum (+ a 4) b))))

(pi-sum 1.0 1000)

; All these three terms share a common structure.
; We can express the generic concept of sumation as follows:
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

; Where:
; term: function that calculates the transformation to apply
; In the case of common sumation, it is to increment a by 1.
; a and b: lower and upper bounds of the summation
; next: function that calculates the next term in the sum
(define (inc n) (+ n 1))
(define (cube x) (* x x x))
(define (new-sum-cubes a b)
  (sum cube a inc b))

(new-sum-cubes 1 10)

; We can make simple summation using the identity function
(define (identity x) x)
(define (new-sum-integers a b)
  (sum identity a inc b))
(new-sum-integers 1 10)

; Also possible to define pi-sum this way again:
(define (new-pi-sum a b)
  (define (pi-term x) (/ 1.0 (* x (+ x 2))))
  (define (pi-next x) (+ x 4))
  (sum pi-term a pi-next b))
(new-pi-sum 1.0 1000)

; With sum, it is possible to use it as building block for
; further concepts. For instace, the integral of a function f
; between limits a and b can be approximated numerically using
; the formula:
;     _ b
;    / `             
;   /  f  = [ f(a + dx/2) + f(a + dx + dx/2) + f(a + 2dx + dx/2) + ...]dx
;._/a
;
; We can express this as the procedure:
(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* dx (sum f (+ a (/ dx 2.0)) add-dx b)))

(integral cube 0 1 0.01)