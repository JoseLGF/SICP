#lang scheme

; Ex 1.6
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(new-if (= 2 3) 0 5) ; expect 5
(new-if (= 1 1) 0 5) ; expect 0

(define (new-sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (new-sqrt-iter (improve guess x)
                         x)))

(define (new-sqrt x)
  (new-sqrt-iter 1.0 x))

;(new-sqrt 9) ; Returns 0!
; Why? 