#lang scheme

; 1.32 Accumulate

; We can express the generic concept of sumation as follows:
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

; Additionally, express the generic concept of product by:
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

; More generically, both procedures are special cases of a
; still more general notion called accumulate, that combinas a
; collection of terms, using some general accumulation func-
; tion:

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))

; Write sum and product in terms of accumulate
(define (acc-sum term a next b)
  (accumulate + 0 term a next b))

(define (acc-product term a next b)
  (accumulate * 1 term a next b))

(define (identity x) x)
(define (inc x) (+ x 1))
(acc-sum identity 1 inc 10)

(acc-product identity 1 inc 10)