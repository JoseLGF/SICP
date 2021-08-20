#lang scheme

; 2.2.3 Sequences as conventional interfaces

; Consider the following example, which takes a tree as arg
; and computes the sum of the squares of the leaves that are
; odd

(define x (cons (list 5 6) (list 7 8)))

(define (square x) (* x x))

(define (sum-odd-squares tree)
  (cond ((null? tree) 0)
        ((not (pair? tree)) (if (odd? tree)
                                (square tree)
                                0))
        (else (+ (sum-odd-squares (car tree))
                 (sum-odd-squares (cdr tree))))))

; On the surface, this procedure is very different from the
; following one, which constructs a list of all the even
; Fibonacci numbers Fib(k), where k is less than or equal to a
; given n:
(define (fib n)
  0) ; TODO

(define (even-fibs n)
  (define (next k)
    (if (> k n)
        null
        (let ((f (fib k)))
          (if (even? f)
              (cons f (next (+ k 1)))
              (next (+ k 1))))))
  (next 0))

; The similarities in the both programs are:
; - First program:
;    * Enumerates the leaves of a tree,
;    * filters them, selecting odd nodes,
;    * squares each of the selected nodes, and
;    * accumulates the result using +, starting with 0
;
; - The second program:
;    * enumerates the integers from 0 to n,
;    * computer the fibonacci number for each integer
;    * filters them, selecting the even ones, and
;    * accumulates the results using cons, starting with empty list
;
; It would be natural to conceptualize these processes in
; terms of signals flowing through a cascade of stages, each of
; which implements part of the program plan.
;
; In sum odd-squares, we begin with an enumerator, which gene-
; rates a signal consisting of the leaves of a given tree.
; This signal is passed through a filter, which eliminates all
; but the odd elements. The resulting signal is passed through
; a map, which is a "transducer" that applies the square pro-
; cedure to each element. The output of the map is the fed to
; an accumulator, which combines the elements using +, start-
; ing from an initial 0.
; The plan for even-fibs is analogous.
;
; sum-odd-squares
; +-------------+      +-------------+
; | enumerate:  |      | enumerate:  |
; | tree leaves |      | integers    |
; +-------------+      +-------------+
;       |                    |
;       V                    V
; +-------------+      +-------------+
; | filter:     |      | map:        |
; | odd?        |      | fib         |
; +-------------+      +-------------+
;       |                    |
;       V                    V 
; +-------------+      +-------------+
; | map:        |      | filter:     |
; | square      |      | even?       |
; +-------------+      +-------------+
;       |                    |
;       V                    V
; +-------------+      +-------------+
; | accumulate: |      | accumulate: |
; | +, 0        |      | cons, ()    |
; +-------------+      +-------------+
;
; The key to organizing programs to reflect signal flow struc-
; ture is to concentrate on the signals that flow from one
; stage in the process to the next.
; Representing signals as lists, we can use list operations to
; implement the processing at each of the stages.

; ---------------------
; Filtering a sequence:
; ---------------------
(define (filter predicate sequence)
  (cond ((null? sequence) null)
        ((predicate (car sequence)) (cons (car sequence)
                                          (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(filter odd? (list 1 2 3 4 5))

; --------------
; Accumulations:
; --------------
(define (accumulate f initial sequence)
  (if (null? sequence)
      initial
      (f (car sequence)
         (accumulate f initial (cdr sequence)))))

(accumulate + 0 (list 1 2 3 4 5))
(accumulate * 1 (list 1 2 3 4 5))
(accumulate cons null (list 1 2 3 4 5))

; ------------
; Enumerate's:
; ------------
(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low (enumerate-interval (+ low 1) high))))
(enumerate-interval 2 7)

(define (enumerate-tree tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))
(enumerate-tree (list 1 (list 2 (list 3 4))))

; Now we can rewrite sum-odd-squares and even-fibs as in the
; signal-flow diagrams:
(define (sum-odd-squares2 tree)
  (accumulate +
              0
              (map square
                   (filter odd?
                           (enumerate-tree tree)))))
(sum-odd-squares2 (list 1 (list 2 (list 3 4))))

(define (even-fibs2 n)
  (accumulate cons
              null
              (filter even?
                      (map fib
                           (enumerate-interval 0 n)))))

; We can reuse several of the pieces we have developed. For
; example, we can compute the product of the odd integers in a
; sequence:
(define (product-of-squares-of-odd-elements-in sequence)
  (accumulate *
              1
              (map square
                   (filter odd? sequence))))

(product-of-squares-of-odd-elements-in (list 1 2 3 4 5))

; Sequences, implemented here as lists, serve as a conven-
; tional interface that permits us to combine processing mo-
; dules.