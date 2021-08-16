#lang scheme

; Block structure:

; Consider the following program consisting of separate
; procedures:
(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (improve guess x)
  (average guess (/ x guess)))

(define (square x) (* x x))
(define (average x y) (/ (+ x y) 2))

; The problem is that the only procedure important to the
; user is sqrt. In order to make the other procedures only
; local to the sqrt function, we can nest them like so:
(define (sqrt x)
  (define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess x)
    (average guess (/ x guess)))
  (define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x)))
  (sqrt-iter 1.0 x))

; This nesting of definitions is called block strucutre.

; Lexical scoping.
; In the above code, since x is the same for the procedures
; good-enough?, improve, and sqrt-iter, we don-t need to pass
; this parameter explicitly, since the functions can take it
; from the enclosing function (sqrt x):
(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))


