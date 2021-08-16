#lang scheme

; Constructing Procedures using Lambda

; We can createprocedures that return procedures using the
; special form Lambda:
(lambda (x) (+ x 4))
; This returns a procedure that adds 4 to its argument
; This can be read as:
(lambda                   (x)              (+    x     4))
; The procedure   of an argument x   that adds   x and 4

; -----------------------------------
; Using let to create local variables
; -----------------------------------
; We want to compute the function:
; f(x, y) = x(1 + xy)^2 + y(1-y) + (1 + xy)(1-y)
; This can also be expressed as:
; a = 1 + xy
; b = 1 - y
; f(x, y) = x*a^2 + y*b + ab
; We can rewrite the use of intermediate variables and the
; use of the helper function as:
(define (f x y)
  (define (f-helper a b)
    (+ (* x (square a))
       (* y b)
       (* a b)))
  (f-helper (+ 1 (* x y))
            (- 1 y)))

; We can use a lambda expression to specify an anonymous pro-
; cedure for binding the local variables:

(define (f x y)
  ((lambda (a b)
     (+ (* x (square a))
        (* y b)
        (* a b)))
   (+ 1 (* x y))
   (- 1 y)))

; This construct is called 'let'. We can rewrite the procedure as:
(define (f x y)
  (let ((a (+ 1 (* x y)))
        (b (- 1 y)))
    (+ (* x (square a))
       (* y b)
       (* a b))))

; This can be though of as saying:
; let a = 1 + xy
;     b = 1 - y
; in
;     x*a^2 + yb + ab
