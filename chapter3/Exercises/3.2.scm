#lang scheme

; Exercise 3.2

; Write a procedure make-monitored that takes as input a
; procedure, f, that itself takes one input.
; The result returned by make-monitored is a third proce-
; dure, that keeps track of the number of times it has
; been called by maintaining an internal counter.
(define (make-monitored f)
  (define counter 0)
  (define (reset-count)
    (begin (set! counter 0)
           counter))
  (define (how-many-calls)
    counter)
  (define (dispatch m)
    (cond ((eq? m 'reset-counter) (reset-count))
          ((eq? m 'how-many-calls?) (how-many-calls))
          (else (begin (set! counter (+ counter 1))
                       (f m)))))
  dispatch)


(define s (make-monitored sqrt))
(s 100)
(s 'how-many-calls?)
(s 144)
(s 'how-many-calls?)
(s 'reset-counter)
(s 'how-many-calls?)