#lang scheme

; Linear Recursion and Iteration

; Factorial function:
; n! = n * (n-1) * (n-2) * ... * 3 * 2 * 1
; We can use the following rule:
; n! = n * (n-1)!
(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

(factorial 6)

; It can be rewritten by using a running product:
(define (factorial2 n)
  (fact-iter n 1))

(define (fact-iter n p)
  (if (= n 1)
      p
      (fact-iter (- n 1) (* p n))))

(factorial2 6)