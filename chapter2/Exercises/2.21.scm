#lang scheme

; Ex 2.21
; The procedure square-list takes a list of numbers as argu-
; ment and returns a list of the squares of those numbers

; Complete the definitions
(define (square x) (* x x))

; Implementation 1
(define (square-list1 items)
  (if (null? items)
      null
      (cons (square (car items)) (square-list1 (cdr items)))))

; Implementation 2
(define (square-list2 items)
  (map (lambda (x) (* x x))
       items))

; Usage
(square-list1 (list 1 2 3 4))
(square-list2 (list 1 2 3 4))
