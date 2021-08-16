#lang scheme

; Exercise 1.44

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeated f n)
  (lambda (x)
    (if (= n 1)
        (f x)
        ((compose f (repeated f (- n 1))) x))))

; The smoothed version of f is the average of f(x-dx),f(x),
; and f(x+dx).
(define (smooth f)
  (define dx 0.01)
  (define (avg-3 x y z)
    (/ (+ x y z) 3))
  (lambda (x)
    (avg-3 (f (- x dx))
           (f x)
           (f (+ x dx)))))

(define (square x) (* x x))
(define (cube x) (* x x x))

((smooth square) 1)

; The n-fold smoothed function is obtained by repeatedly
; smoothing a function n times:
(define (n-fold-smoothed f n)
  (repeated (smooth f) n))

((n-fold-smoothed square 4) 1)