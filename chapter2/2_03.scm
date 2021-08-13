#lang scheme

; Ex 2.3

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

; Representation for rectangles in a plane--------------------
; Constructor of a rectanble with pair width-height
(define (make-rectangle w h) (cons w h))
; Selector for the width and height of a Rectangle
(define (rect-width  R) (car R))
(define (rect-height R) (cdr R))
; Procedures for calculating the area and perimeter of a Rect
(define (area-rect  R) (* (rect-width R) (rect-height R)))
(define (perim-rect R) (* 2 (+ (rect-width R) (rect-height R))))
; ------------------------------------------------------------

; Test code for rational numbers
(define R1 (make-rectangle 3 5))
(area-rect  R1)
(perim-rect R1)