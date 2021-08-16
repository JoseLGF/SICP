#lang scheme

; 1.2.4 Exponentiation

; Compute the exponential b^n via the recursive definition:
; b^n = b * b^(n-1)
; b^0 = 1

(define (expt b n)
  (if (= n 0)
       1
       (* b (expt b (- n 1)))))

(expt 15 4)

; It can also be done in linear iteration:
(define (expt2 b n)
  (expt-lin b n 1))

(define (expt-lin b n p)
  (if (= n 0)
      1
      (* b (expt-lin b (- n 1) (* p b)))))

(expt2 15 4)

; It can be done in fewer steps by using successive squaring.
; Example:
; b2 = b  * b
; b4 = b2 * b2
; b8 = b4 * b4
; We can deduce the rule:
; b^n = (b^(n/2))^2 if n is even
; b^n = b * b^(n-1)

(define (square x) (* x x))
(define (half   x) (/ x 2))
(define (dec    x) (- x 1))

(define (expt3 b n)
  (cond ((= 0 n) 1)
        ((even? n) (square (expt3 b (half n))))
        (else (* b (expt3 b (- n 1))))))

(expt 15 4)