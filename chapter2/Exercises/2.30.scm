#lang scheme

; Exercise 2.30

; Define a procedure square-tree, similar to square-list.
; It should behave as follows:
; (square-tree
;   (list 1
;         (list 2 (list 3 4) 5)
;         (list 6 7)))
; (1 (4 (9 16) 25) (36 49))

(define (square x) (* x x))
; Directly
(define (square-tree tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (square tree))
        (else (cons (square-tree (car tree))
                    (square-tree (cdr tree))))))

(square-tree (list (list 1 2) (list 3 4)))
(square-tree (list))
(square-tree
  (list 1
        (list 2 (list 3 4) 5)
        (list 6 7)))

; By using a map and recursion
(define (square-tree2 tree)
  (map (lambda (sub-tree)
       (if (pair? sub-tree)
           (square-tree2 sub-tree)
           (square sub-tree)))
  tree))
(square-tree2 (list))
(square-tree2
  (list 1
        (list 2 (list 3 4) 5)
        (list 6 7)))