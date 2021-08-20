#lang scheme

; Ex 2.2
; Point representation ---------------------------------------
; Constructor of a point as a pair of numbers
(define (make-point x y) (cons x y))
; Selector for the x- and y- components of a point
(define (x-point p) (car p))
(define (y-point p) (cdr p))
; Print point
(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))
; ------------------------------------------------------------

; Line segment representation --------------------------------
; Constructor of a line segment as a pair of points
(define (make-segment p_a p_b) (cons p_a p_b))
; Selector for the start- and end- points of a line segment
(define (start-segment s) (car s))
(define (end-segment   s) (cdr s))
; Takes a line segment as argument and returns its midpoint
(define (midpoint-segment s)
  (define (average a b) (/ (+ a b) 2))
  (let ((x1 (x-point (start-segment s)))
        (y1 (y-point (start-segment s)))
        (x2 (x-point (end-segment   s)))
        (y2 (y-point (end-segment   s))))
  (make-point (average x1 x2) (average y1 y2))))
; ------------------------------------------------------------

; Test code for rational numbers
(define A (make-point 1 2))
(define B (make-point 6 4))
(define S (make-segment A B))
(define C (midpoint-segment S))
(print-point C)