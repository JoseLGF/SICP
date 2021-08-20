#lang scheme

; Exercise 2.53

(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))

; What will the interpreter print in response to evaluating
; each of the following expressions?

(list 'a 'b 'c)
; (a b c)

(list (list 'george))
; (list (george))
; Error - george undefined. Wrong!
; ((george))

(cdr '((x1 x2) (y1 y2)))
; (cdr ((x1 x2) (y1 y2)))
; ((y1 y2))

(cadr '((x1 x2) (y1 y2)))
;(y1 y2)

(pair? (car '(a short list)))
; (pair? (car (a short list)))
; (pair? a)
; false

(memq 'red '((red shoes) (blue socks)))
; (memq red ((red shoes) (blue socks)))
; (red shoes) Wrong!
; false

(memq 'red '(red shoes blue socks))
; (red shoes blue socks)