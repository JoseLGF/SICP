#lang scheme


; Problem: How many different ways can we make change of $1.00
; given half-dollars, quarters, dimes, nickels, and pennies?
; Can we write a procedure to compute the number of ways to
; change any given amount of money?

; We can think of the solution in terms of recursion:
; The number of ways to change amount _a using _n kinds of
; coins equals:
; - the number of ways to change amount a using all but the
; first kind of coin, plus
; - the number of ways to change amount (a-d) using all n
; kinds of coins, where d is the denomination of the first
; kind of coin.

; Consider the following base cases:
; if a is exactly 0, we count that as 1 way to make change
; if a is less than 0, we count that as 0 ways to make change
; if n is 0, we count that as 0 ways to make change

(define n 5)
(define (count-change amount)
  (cc amount n))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((< amount 0) 0)
        ((= kinds-of-coins 0) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination kinds-of-coins))
                     kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

(count-change 100)