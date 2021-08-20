#lang scheme

; Exercise 2.29

; A binary mobile consists of two branches, a left and a right
; branch. Each branch is a rod of a certain length, from which
; hangs either a weight or another binary mobile.

; We can represent a binary mobile using compound data by
; constructing it from two branches:
(define (make-mobile left right)
  (list left right))

; A branch is constructed from a length (which must be a num-
; ber) together with a structure, which may be either a num-
; ber (a simple weight) or another mobile:
(define (make-branch length structure)
  (list length structure))

; Write selectors for left-branch and right-branch.
(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (cadr mobile))

; Write the selectors branch-length and branch-structure, re-
; turning the components of a branch
(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (cadr branch))

; Define a procedure total-weight that returns the weight of a
; mobile
(define (total-weight mobile)
  (mobile-weight mobile))

(define (branch-weight branch)
  (if (pair? (branch-structure branch))
      (mobile-weight (branch-structure branch))
      (branch-structure branch)))

(define (mobile-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

; A mobile is said to be balanced if the torque applied to its
; top-left branch is equal to that applied by its top-right
; branch (means:(lenghtOfLeftRod  * WeightHangingFromLeftRod)
;            == (lengthOfRightRod * WeightHingingFromRightRod)
; Design a predicate that tests whether a mobile is balanced
(define (balanced? mobile)
  (= (torque (left-branch  mobile))
     (torque (right-branch mobile))))

(define (torque branch)
  (* (branch-length branch) (branch-weight branch)))

; Mobile representation
;
;             m3
;             |
;             |
;     32  10  |   20
;      W------+---------m2
;         b5      b6    |
;                       |
;                15     |   9   10
;        m1-------------+-------W
;        |       b3         b4
;        |
; 4  5   |  10   2
; W------+-------W
;    b1     b2

(define b1 (make-branch 5  4 ))
(define b2 (make-branch 10 2 ))
(define m1 (make-mobile b1 b2))

(define b3 (make-branch 15 m1))
(define b4 (make-branch 9  10))
(define m2 (make-mobile b3 b4))

(define b5 (make-branch 10 32))
(define b6 (make-branch 20 m2))
(define m3 (make-mobile b5 b6))

(display "m1")
(newline)
(left-branch m1)
(right-branch m1)
(display "Weight: ")
(total-weight m1)

(display "m2")
(newline)
(left-branch m2)
(right-branch m2)
(display "Weight: ")
(total-weight m2)

(display "m3")
(newline)
(left-branch m3)
(right-branch m3)
(display "Weight: ")
(total-weight m3)

(display "Torque b1: ")
(torque b1)
(display "Torque b2: ")
(torque b2)
(balanced? m1)

(display "Torque b3: ")
(torque b3)
(display "Torque b4: ")
(torque b4)
(balanced? m2)

(display "Torque b5: ")
(torque b5)
(display "Torque b6: ")
(torque b6)
(balanced? m3)