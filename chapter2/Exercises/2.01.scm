#lang scheme

; Exercise 2.1

; Define a bettwe version of make-rat such that:
;     - If the rational number is positive, both numerator and
;       denominator are positive.
;     - If the rational number is negative, only the numerator is
;       negative

; According to table:
; +--------------+-------------+
; | Input number |  New number |
; | Numer | Den  | Numer | Den |
; +-------+------+-------+-----+
; |   +   |   +  |   +   |  +  |
; |   +   |   -  |   -   |  +  |
; |   -   |   +  |   -   |  +  |
; |   -   |   -  |   +   |  +  |
; +-------+------+-------+-----+

; Construct a rational number, given numerator and denominator
(define (make-rat n d)
  (define n_sign (< n 0))
  (define d_sign (< d 0))
  (cond ((and (not n_sign) (not d_sign)) (cons    n     d ))
        ((and (not n_sign)      d_sign ) (cons (- n) (- d)))
        ((and      n_sign  (not d_sign)) (cons    n     d ))
        (else                            (cons (- n) (- d)))))

; Data accessors for rational number
(define (numer x) (car x))
(define (denom x) (cdr x))

; -----
(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

; Test
(make-rat 5 5)
(make-rat -1 2)
(make-rat 3 -4)
(make-rat -3 -2)

