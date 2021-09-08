#lang scheme

; Macros are useful for extending the language

; Macro is transformation of code.
; Code is transformed before being evaluated or compiled,
; and the procedure continues as if the transformed code
; had been written from the beginning.

; Scheme macros take parsed code as input and return
; expanded code as output
; This is one of the applications of Scheme's "code is
; data" phrase, and it is what makes the language so pow-
; erful.

; macros in scheme are created with define-syntax, which
; can define a macro in a number of ways.
; The simplest method is to use syntax-rules, which uses
; pattern-matching to transform the input code into the
; output code.

; Examples:
; 1 - Assigns '() to a variable
(define-syntax nil!
  (syntax-rules ()
    ((_ x)
     (set! x '()))))
; This cannot be written as a function, because functions
; cannot affect the variable outside of it:
(define (f-nil! x)
  (set! x '()))

(define a 1)
(f-nil! a)
a
; Value of a does not change

(nil! a)
a
; Value of a changed due to the macro