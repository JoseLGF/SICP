#lang scheme

; Examples 2.3 - Symbolic Data

; Using quotation, we can distinguish between symbols and
; their values:
(define a 1)
(define b 2)
(define c 1)
(list a b)
(list 'a 'b)
(list 'a b)

; Quotation also allows us to type in compound objects, using
; the conventional printed representation for lists:
(car '(a b c))
(cdr '(a b c))

; We can obtain the empty list as follows:
'()
; This is equivalent to using null:
null

; A useful primitve is eq?, which takes two symbols as argu-
; ments and tests whether they are the same:
(eq? 'a 'b)
(eq? 'a 'a)
(eq? 'a 'c)
; a=1 and c=1. However, they are not eq?, for they are diff-
; erent symbols.

; With eq?, we can implement memq. This takes two args, a sym-
; bol and a list. If the symbol is not contained in the list,
; then memq returns false. Otherwise, it returns the sublist
; of the list beginning with the first occurrence of the sym-
; bol.
(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))

(memq 'apple '(pear banana prune))
(memq 'apple '(x (apple sauce) y apple pear))