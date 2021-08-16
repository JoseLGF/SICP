#lang scheme

; Example - Newton's Method

(define (square x) (* x x))

(define (cube x) (* x x x))

(define (good-enough? guess x)
  (< (abs (- (cube guess) x)) 0.001))

(define (improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))

(define (cube-root-iter guess x)
  (if (good-enough? guess x) ; If the guess is good enough
      guess ; Return the guess
      (cube-root-iter (improve guess x) ; Otherwise give the result of running cube-root-iter again with an improved guess
                 x))) ; on the same value x

(define (cube-root x)
  (cube-root-iter 1.0 x))

(cube-root -3)

