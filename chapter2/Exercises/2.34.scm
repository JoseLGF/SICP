#lang scheme

; Exercise 2.34

(define (accumulate f initial sequence)
  (if (null? sequence)
      initial
      (f (car sequence)
         (accumulate f initial (cdr sequence)))))

; Evaluating a polynomial can be seen as an accumulation:
; anxn + an-1*xn-1 + ... + a1x + a0
; by using an algorithm called Horner's rule, which structures
; the computation as:
; ( ... (anx + an-1)x + ... + a1)x + a0
; Or:
; a0 +
;    x * (a1 +
;            x * (a2 +
;                   ...
;                    x * (an) ... )))
;
; We start with an, multiply by x, add n-1, multiply by x, and
; so on until we reach a0.
(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms)
                (+ this-coeff (* x higher-terms)))
              0
              coefficient-sequence))

; In order to evaluate 1 + 3x + 5x3 + x5 at x=2:
(horner-eval 5 (list 1 3 0 5 0 1))