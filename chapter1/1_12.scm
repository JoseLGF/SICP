#lang scheme

; Ex 1.29
(define (even i)
  (if (= i 0)
      #t
      (not (even (- i 1)))))

(define (simpson-coefficient i n)
  (cond ((= i n) 1)
        ((= i 1) 1)
        ((even i) 4)
        (else 2)))
#|
; test
(simpson-coefficient 1 10)
(simpson-coefficient 2 10)
(simpson-coefficient 3 10)
(simpson-coefficient 4 10)
(simpson-coefficient 5 10)
(simpson-coefficient 6 10)
(simpson-coefficient 7 10)
(simpson-coefficient 8 10)
(simpson-coefficient 9 10)
(simpson-coefficient 10 10)
|#

(define (simpson-integral f a b n)
  (TODO))
