#lang scheme

; Ex 1.15 Sine of an angle

; The sine of an angle (in radians) can be computed by making
; use of the approximation sin x ~ x if x is sufficiently
; small, and the trigonometric identity

; sin x = 3 * sin (x / 3) - 4 * (sin (x/3))^3

; to reduce the size of the argument of sin.
; An angle is considered sufficiently small if its magnitude
; is not greater than 0.1 radians.

(define (cube x) (* x x x))

(define (p x) (- (* 3 x) (* 4 (cube x))))

(define (sine angle)
  (if (not (> (abs angle) 0.1))
  angle
  (p (sine (/ angle 3.0)))))

(sin 100.0)