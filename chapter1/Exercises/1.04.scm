#lang scheme

; Ex 1.4
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
; If b>0, the plus operator is returned and applied to a and b.
; If b<=0, the minus operator is returned and applied to a and b.
; This way, the sign of b is never negative, hence, abs(b)

