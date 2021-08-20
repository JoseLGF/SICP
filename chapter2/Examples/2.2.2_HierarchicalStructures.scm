#lang scheme

; Recursion is a natural tool for dealing with tree structures
; , since we can ofter reduce operations on trees to oper-
; ations on their branches, which reduce to operations on lea-
; ves.

; Compare the length procedure of section 2.2.1:
(define (length items)
  (if (null? items)
      0
      (+ 1 (length (cdr items)))))
; with the count-leaves procedure, which returns the total
; number of leaves of a tree:
(define x (cons (list 1 2) (list 3 4)))
(length x)

(define (count-leaves tree)
  (cond ((null? tree) 0)
        ((not (pair? tree)) 1)
        (else (+ (count-leaves (car tree))
                 (count-leaves (cdr tree))))))

(count-leaves x)