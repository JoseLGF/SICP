#lang scheme

; Example - Newton's Method

(define (square x) (* x x))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (sqrt-iter guess x)
  (if (good-enough? guess x) ; If the guess is good enough
      guess ; Return the guess
      (sqrt-iter (improve guess x) ; Otherwise give the result of running sqrt-iter again with an improved guess
                 x))) ; on the same value x

(define (sqrt x)
  (sqrt-iter 1.0 x))

(sqrt 9)

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