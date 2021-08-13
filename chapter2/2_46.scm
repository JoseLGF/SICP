#lang scheme

; Ex 2.46

; Program for working with vectors
(define (make-vect x y) (cons x y))

; Selectors
(define (xcor-vect v) (car v))
(define (ycor-vect v) (cdr v))

; Operations on vectors
(define (add-vect v w)
  (make-vect
   (+ (xcor-vect v) (xcor-vect w))
   (+ (ycor-vect v) (ycor-vect w))))

(define (sub-vect v w)
  (make-vect
   (- (xcor-vect v) (xcor-vect w))
   (- (ycor-vect v) (ycor-vect w))))

(define (scale-vect v s)
  (make-vect
   (* s (xcor-vect v))
   (* s (ycor-vect v))))

(define v1 (make-vect 1 2))
(define v2 (make-vect 3 4))

; Test
(add-vect v1 v2)
(sub-vect v2 v1)
(scale-vect v1 5)