#lang scheme

; 1.29 Simpson's Rule

; We can express the generic concept of sumation as follows:
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

; Simpsons rule:
; The integral of a function f between a and b is approximated
; as:
;
; (h/3) *
;  (y0 + 4*y1 + 2*y2 + 4*y3 + 2*y4 + ... + 2*yn-2 + 4*yn-1 + yn)
;
; Where:
; h = (b - a)/n
; yk = f(a + kh)
(define (integral f a b n)
  ; auxiliary functions
  (define h (/ (- b a) n))
  (define (y k) (f (+ a (* k h))))
  (define (inc x) (+ x 1))
  (define (term-int x)
    (cond ((= x 0)  (* 1 (y 0)))
          ((= x n)  (* 1 (y n)))
          ((odd? x) (* 4 (y x)))
          (else     (* 2 (y x)))))
  ;body
  (* (/ h 3)
     (sum term-int 0 inc n)))

(define (cube x) (* x x x))

(integral cube 0 1.0 1000)