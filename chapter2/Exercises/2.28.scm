#lang scheme

; Ex 2.28 Fringe

; Write a procedure fringe that takes as argument a tree
; and returns a list whose elements are all the leaves of
; the tree arranged in let-to-right order

(define (fringe tree)
  (cond
    ((null? tree) null)
    ((pair? tree) (append (fringe (car tree))
                          (fringe (cdr tree))))
    (else (list tree))))

(define x (list (list 1 2) (list 3 4) (list 5 6)))
(fringe x)

(fringe (list x x))
      