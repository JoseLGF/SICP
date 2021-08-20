#lang scheme

; Exercise 2.20

; Returns only even numbers in the input list
(define (get-even items)
  (if (null? items)
      null
      (if (even? (car items))
          (cons (car items) (get-even (cdr items)))
          (get-even (cdr items)))))
; Returns only odd numbers in the input list
(define (get-odd items)
  (if (null? items)
      null
      (if (odd? (car items))
          (cons (car items) (get-odd (cdr items)))
          (get-odd (cdr items)))))
; Abstract into generic function
(define (get-all-of f items)
  (if (null? items)
      null
      (if (f (car items))
          (cons (car items) (get-all-of f (cdr items)))
          (get-all-of f (cdr items)))))
; Now we can define the same-parity function
(define (same-parity first . others)
  (cons first
        (if (even? first)
            (get-all-of even? others)
            (get-all-of odd?  others))))

; Test code:
(same-parity 1)
(get-even (list 1 2 3 4 5 6 7))
(get-odd (list 1 2 3 4 5 6 7))

(get-all-of even? (list 1 2 3 4 5 6 7))
(get-all-of odd? (list 1 2 3 4 5 6 7))

(same-parity 1 2 3 4 5 6 7 8 9)
(same-parity 2 3 4 5 6 7 8 9)