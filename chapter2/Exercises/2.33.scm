#lang scheme

; Exercise 2.33
(define (square x) (* x x))
(define (accumulate f initial sequence)
  (if (null? sequence)
      initial
      (f (car sequence)
         (accumulate f initial (cdr sequence)))))

; Fill in the missing expressions to complete the definitions:
; A
(define (map p sequence)
  (accumulate (lambda (x y)
                (cons (p x) y))
              null sequence))

(map square (list 1 2 3 4))

; B
(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(append (list 1 2 3 4) (list 5 6 7 8))

; C
(define (length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

(length (list 1 2 3 4 5 6 7 10))