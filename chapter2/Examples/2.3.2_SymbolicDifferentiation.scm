#lang scheme

; Example - Symbolic differentiation


; We want to provide symbolic differentiation for the follow-
; ing types of expressions:
;  dc
; ---- = 0 ; for c a constant or variable different from x
;  dx
;
;  dx
; ---- = 1
;  dx
;
; d(u + v)    du     dv
; -------- = ---- + ----
;   dx        dx     dx
;
; d(uv)      dv        du
; ----- = u(----) + v(----)
;  dx        dx        dx

; Let's also assume we have the following primitives:
; (variable? e)         | Is e a variable?
; (same-variable v1 v2) | Are v1 and v2 the same variable?
; (sum? e)              | Is e a sum?
; (addend e)            | Addend of the sum e
; (augend e)            | Augend of the sum e
; (make-sum a1 a2)      | Construct of the sum of a1 and a2
; (product? e)          | Is e a product?
; (multiplier e)        | Multiplier of the product e
; (multiplicand e)      | Multiplicand of the product e
; (make-produt m1 m2)   | Construct of the product m1 and m2

; Using these, and the primite number?, we can express the
; differentiation rules as the following procedure:
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        (else
         (error "unknown expression type -- DERIV" exp))))

; Representing algebraic expressions
; If we use parenthesized prefix notation for expressions, the
; data representation is as follows:

; Variables are symbols:
(define (variable? x) (symbol? x))

; Two variables are the same if the symbols representing them
; are eq?:
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

; Sums and products are constructed as lists:
;(define (make-sum a1 a2) (list '+ a1 a2))
;(define (make-product m1 m2) (list '* m1 m2))

; A sum is a list whose first element is the symbol +:
(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))

; The addend is the second item of the sum list:
(define (addend s) (cadr s))

; The augend is the third item of the sum list:
(define (augend s) (caddr s))

; A product is a list whose first element is the symbol *:
(define (product? x)
  (and (pair? x) (eq? (car x) '*)))

; The multiplier is the second item of the product list:
(define (multiplier p) (cadr p))

; The multiplicand is the third item of the product list:
(define (multiplicand p) (caddr p))

; Thus, we have a woking symbolic differentiation program:
;(deriv '(+ x 3) 'x)

;(deriv '(* x y) 'x)

;(deriv '(* (* x y) (+ x 3)) 'x)

; This, however, produces unsimplified answers. In order to
; fix this, we only need to modify the constructors so that
; they produce the simplified forms when an object is created:
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))

; We can now see how it performs on the previous examples:
(deriv '(+ x 3) 'x)

(deriv '(* x y) 'x)

(deriv '(* (* x y) (+ x 3)) 'x)