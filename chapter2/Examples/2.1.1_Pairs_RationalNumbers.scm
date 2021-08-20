#lang scheme

; Example - Pairs - Rational numbers

; Construct a rational number, given numerator and denominator
(define (make-rat n d) (cons n d))

; Data accessors for rational number
(define (numer x) (car x))
(define (denom x) (cdr x))

; -----
(define (print-rat x)
  (newline)
  (display (number x))
  (display "/")
  (display (denom x)))


