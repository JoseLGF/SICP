#lang scheme

; Exercise 2.54

; Two lists are said to be equal? if they contain equal ele-
; ments arranged in the same order. For example:
; (equal? '(this is a list) '(this is a list))
; Returns true, but

; (equal? '(this is a list) '(this (is a) list))
; Returns false

; To be more precise:
(define (equal? a b)
  (if (or (and (not (pair? a)) ; both a
               (not (pair? b)) ; and b are symbols, and
               (eq? a b)       ; the symbols are eq?
           )
          ; OR
          (and (pair? a) ; both a and
               (pair? b) ; b are lists, and
               (equal? (car a) (car b)) ; (car a) equal? (car b)
               (equal? (cdr a) (cdr b))))
      true
      false))
          
(equal? '(this is a list) '(this is a list))
(equal? '(this is a list) '(this (is a) list))