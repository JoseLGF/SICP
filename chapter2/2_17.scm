#lang scheme

; Ex 2.17

; Assumes that the list is non-empty
(define (last-pair lst)
  (if (null? (cdr lst))
      (car lst)
      (last-pair (cdr lst))))

(last-pair (list 23 72 149 34))
(last-pair (list 23))
; (last-pair (list )) ; Empty list throws error