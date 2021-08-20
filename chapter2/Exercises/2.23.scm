#lang scheme

; Ex 2.23

; Give an implementation of for-each

(define (for-each f items)
  (f (car items))
  (if (null? (cdr items))
      null
      (for-each f (cdr items))))

; Test
(for-each (lambda (x) (newline) (display x))
          ;(list 57 321 88))
          (list 57 321 88))
