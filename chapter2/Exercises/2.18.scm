#lang scheme

; Ex 2.18

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))



; Define a procedure reverse that takes a list as argument and
; returns a list of the same elements in reverse order
(define (reverse lst)
  (if (null? (cdr lst))
             lst
             (append (reverse (cdr lst)) (list (car lst)))))

(reverse (list 1 2 3 4))
(reverse (list 1))
(reverse (list 0 0))