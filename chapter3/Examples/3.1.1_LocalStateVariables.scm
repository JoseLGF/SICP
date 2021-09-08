#lang scheme


; Assignment and Local state

; We can characterize an object's state by one or more
; state variables.

; this view of a system can be a powerful framework for
; organizing computational models of the system.
; each computational object must have its own local state
; variables describing the actual objects state.

; if we wish to model state variables by ordinary symbolic
; names in the programming language, then the language
; must provide an assignment operator to enable us to
; change the value associated with a name.

; in the example of a bank account, we can define a
; withdraw procedure
(define balance 100)

(define (withdraw amount)
  (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds"))

; Decrementing balance uses the set! special form, whose
; syntax is:
; (set! <name> <new-value>)
; Here, name is a symbol and <new-value> is any expression

; withdraw also uses the begin special form to cause two
; expressions to be evaluated in the case where the if
; test is true: first decrementing balance and then return-
; ing the value of balance. In general, evaluating the
; expression:
; (begin <exp1> <exp2> ... <expn>)
; causes the expressions <exp1> through <expn> to be eva-
; luated in sequence and the value of the final expression
; <expn> to be returned as the value of the entire begin
; form.

; we can make balance internal to withdraw by rewriting
; the definition as follows:
(define new-withdraw
  (let ((balance 100))
    (lambda (amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient funds"))))
; what we have done is to use let to establish an environ
; ment with a local variable balance, bound to the initial
; value 100.
; Within this local environment, we use lambda to create a
; procedure that takes amount as an argument and behaves
; like out previous withdraw procedure.
; This procedure -returned as the result of evaluating the
; let expression- is new-withdraw.
; Combining set! with local variables is the general pro-
; gramming technique to be used for constructing computa-
; tional objects with local state.

; The following procedure, make-withdraw, creates "with-
; drawal processors". The formal parameter balance in
; make-withdraw specifies the initial amount of money in
; the account:
(define (make-withdraw balance)
  (lambda (amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds")))

; Make-withdraw can be used to create withdrawal objects:
(define W1 (make-withdraw 100))
(define W2 (make-withdraw 100))

(W1 50) ; 50
(W2 70) ; 30
(W2 40) ; "Insufficient funds"
(W1 40) ; 10

; We can also create objects that handle deposits as well
; as withdrawals, and thus we can represent simple bank
; accounts. Here is a procedure that returns a "bank-acc-
; ount object" with a specified initial balance:
(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request -- MAKE-ACCOUNT"
                       m))))
  dispatch)

; Each call to make-account sets up an environment with a
; local state variable balance. Within this environment,
; make-account defines procedures deposit and withdraw
; that access balance and an additional procedure dis-
; patch that takes a "message" as input and returns one
; of the two local procedures.
(define acc (make-account 100))
((acc 'withdraw) 50)
((acc 'withdraw) 60)
((acc 'deposit) 40)
((acc 'withdraw) 60)