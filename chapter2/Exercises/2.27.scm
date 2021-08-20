#lang scheme

; Ex 2.27

; Produce a deep-reverse procedure that takes a list as arg
; and returns as its value the list with its elements reversed
; and with all sublists deep-reversed as well.

(define (deep-reverse lst)
  (cond ((not (pair? lst)) lst)
        ((null? (car lst)) (deep-reverse (cdr lst)))
        ((null? (cdr lst)) (deep-reverse (car lst)))
        (else (list   (deep-reverse (cdr lst))
                      (deep-reverse (car lst))))))

(deep-reverse (list (list 1 2) (list 3 4)))