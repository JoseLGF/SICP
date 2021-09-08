#lang scheme

; Exercise 3.1

; An accumulator is a procedure that is called repeatedly
; with a single numeric argument and accumulates its arg-
; uments into a sum.
; Each time it is called, it returns the currently accum-
; ulated sum.
; Write a procedure make-accumulator that generates accum-
; ulators, each maintaining an independent sum.
; The input to make-accumulator should specify the initial
; value of the sum.
(define (make-accumulator sum)
  (lambda (amount)
    (begin (set! sum (+ sum amount))
           sum)))

(define A (make-accumulator 5))

(A 10)
(A 10)