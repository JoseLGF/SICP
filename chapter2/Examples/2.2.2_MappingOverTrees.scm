#lang scheme

; Example 2.2.2 - Mapping over trees

; Just as we can map over sequences, we can map over tress.
; Example: The scale-tree procedure, analogous to scale-list,
; takes as arguments a numeric factor a tree whose leaves are
; numbers, and returns a tree of the same shape, where each
; number is multiplied by the factor.

; From 2.2.1:
(define (scale-list items factor)
  (if (null? items)
      null
      (cons (* factor (car items))
            (scale-list (cdr items) factor))))

(define (scale-tree tree factor)
  (cond ((null? tree) null)
        ((not (pair? tree)) (* factor tree))
        (else (cons (scale-tree (car tree) factor)
                    (scale-tree (cdr tree) factor)))))

(scale-tree (list (list 1 2) (list 3 4)) 3)
(scale-tree (list) 3)

; Another way to implement scale-tree is to regard the tree as
; a sequence of sub-trees and use map.
; In the base case, where the tree is a leaf, we simply multi-
; ply by the factor
(define (scale-tree2 tree factor)
  (map (lambda (sub-tree)
       (if (pair? sub-tree)
           (scale-tree2 sub-tree factor)
           (* sub-tree factor)))
  tree))

(scale-tree2 (list (list 1 2) (list 3 4)) 3)
(scale-tree2 (list) 3)