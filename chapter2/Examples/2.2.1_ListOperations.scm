#lang scheme

; List operations

; The procedure list-ref takes as arguments a list and a num-
; ber n and returns the nth item of the list.

; For n=0, list-ref should return the car of the list
; Otherwise, list-ref should return the (n-1)st item of the
; cdr of the list.

(define (list-ref l n)
  (if (= n 0)
      (car l)
      (list-ref (cdr l) (- n 1))))

(list-ref (list 1 2 3 4) 3)

; The procedure length returns the number of items in a list:
(define (length items)
  (if (null? items)
      0
      (+ 1 (length (cdr items)))))

(length (list 1))

; This can also be done iteratively:
(define (length-i items)
  (define (length-iter a count)
    (if (null? a)
        count
        (length-iter (cdr a) (+ 1 count))))
  (length-iter items 0))

; We can append two lists as follows:
; If list1 is the empty list, then the result is just list2
; Otherwise, append the cdr of list1 and list2, and cons the
; car of list1 onto the result
(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))
