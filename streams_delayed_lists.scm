#lang scheme

(define (square x) (* x x))

; Delay:
; Transforms the procedure into a lambda so that
; we can execute the procedure at a later time:
(define-syntax delay
  (syntax-rules ()
    ((_ exp) (lambda () exp))))
; Example:
(define delayed-square (delay square))
; Will be transformed into:
; (define delayed-square ((lambda () square)))

; Force
; With force, we can force the execution of the lambda
; returned by delay:
(define (force delayed-obj)
  (delayed-obj))
((force delayed-square) 5)

; cons-stream
; creates a stream as a way of a delayed const-aggregate,
; by delay'ing the execution of the cdr of the cons
(define-syntax cons-stream
  (syntax-rules ()
    ((_ a b) (cons a (delay b)))))

; stream-car
; stream-specific accesors for streams
; The car can be identical to normal car since we want
; to evaluate the left part immediately, only the cdr part
; is delayed.
(define (stream-car stream) (car stream))

; stream-cdr
; Since the cdr is delayed at construction, we force its
; evaluation when the cdr is actually accessed.
(define (stream-cdr stream) (force (cdr stream)))

; Empty stream
(define empty-stream? '())
(define empty-stream? null?)