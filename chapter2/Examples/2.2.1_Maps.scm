#lang scheme

; 2.2.1 Mapping over lists

; Consider the following procedure, which scales each number
; in a list by a given factor:

(define (scale-list items factor)
  (if (null? items)
      null
      (cons (* factor (car items))
            (scale-list (cdr items) factor))))

(scale-list (list 1 2 3 4 5) 5)

; We can abstract this general idea as a common pattern ex-
; pressed as a higher order procedure.
; This procedure is called map.

(define (map proc items)
  (if (null? items)
      null
      (cons (proc (car items))
            (map proc (cdr items)))))

(map abs (list -10 2.5 -11.6 17))
(map (lambda (x) (* x x))
     (list 1 2 3 4))

; We can now rewrite scale-list in terms of map:
(define (scale-list2 items factor)
  (map (lambda(x) (* factor x))
       items))

(scale-list2 (list 1 2 3 4 5) 5)
