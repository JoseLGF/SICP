#lang scheme

; Ex 1.1

10 ; 10
(+ 5 3 4) ; 12
(- 9 1) ; 8
(/ 6 2) ; 3
(+ (* 2 4) (- 4 6)) ; 6
(define a 3) ; -
(define b (+ a 1)) ; -
(+ a b (* a b)) ; 19
(= a b) ; #f
(if (and (> b a) (< b (* a b)))
    b
    a) ; 4
(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25)) ; 16

; Ex 1.2
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))
   (* 3 (- 6 2) (- 2 7)))

; Ex 1.3
; Define a procedure P that takes three numbers as arguments and returns the sum
; of the squares of the two larger numbers.
(define (sum-of-squares x y)
  (+ (* x x) (* y y)))

; Sorts two numbers, putting the greater one first
(define (largest a b)
  (cond ((> a b) a)
        (else b)))

(largest 4 4)
(largest 5 4)
(largest 3 5)

(define (P a b c)
  (sum-of-squares (largest a b)
                  (largest b c)))

; Ex 1.4
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
; If b>0, the plus operator is returned and applied to a and b.
; If b<=0, the minus operator is returned and applied to a and b.
; This way, the sign of b is never negative, hence, abs(b)

; Ex 1.5
(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

(test 0 (p))

; Infinite recursion because (p) is expanded to itself.


  

