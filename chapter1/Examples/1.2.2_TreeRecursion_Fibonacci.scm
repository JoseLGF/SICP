#lang scheme

; Fibonacci numbers

; Consider the following rule for Fibonacci numbers:
;           _
;          |  0                 if n = 0
; Fib(n) =.|  1                 if n = 1
;          |_ Fib(n-1)+Fib(n-2) otherwise
;

(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

(fib 8)

; A more efficient way to calcula Fibonacci numbers is by for-
; mulating an iterative process for computing the Fib numbers.
; The idea is to use a pair of integers a and b, initialized
; to Fib(1) and Fib(0), and to repeatedly apply:
; a <- a + b
; b <- a
; After applying this transformation n times, a and b will be
; equal to Fib(n+1) and Fib(n).
(define (Fib2 n)
  (fib-iter 1 0 n))

(define (fib-iter a b count)
  (if (= count 0)
      b
      (fib-iter (+ a b)
                a
                (- count 1))))

(Fib2 8)
