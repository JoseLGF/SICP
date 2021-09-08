#lang scheme

; Example 3.5.1 - Streams are delayed lists

; Streams are a clever idea that allows one to use sequen-
; ce manipulations without incurring the costs of manipu-
; lating sequences as lists.

; The main idea is to arrange to construct a stream only
; partially and to pass the partial construction to the
; program that consumes the stream.
; If the consumer attempts to acces a part of the stream
; that has not yet been constructed, the stream will auto-
; matically construct just enough more of itself to produ-
; ce the required part, this preserving the illusion that
; the entire stream exists.

; On the surface, streams are just lists with different
; names for the procedures that manipulate them. There is
; a constructor, cons-stream, and two selectors,
; stream-car and stream-cdr, which satisfy the constraints
(stream-car (cons-stream x y)) = x
(stream-cdr (cons-stream x y)) = y

; There is a distinguishable object, the-emty-stream,
; which cannot be the result of any cons-stream operation,
; and which can be identified with the predicate
; stream-null?.
; Thus we can make and use streams, in just the same way
; as we can make and use lists, to represent aggregate
; data arranged in a sequence.

; As a data abstraction, streams are the same as lists.
; the difference is in the time at which the elements are
; evaluated. With ordinary lists, both the car and the cdr
; are evaluated at construction time. With streams, the
; cdr is evaluated at selection time.

; The implementation of streams will be based on a special
; form called delay. Evaluating (delay <exp>) does not e-
; valuate the expression <exp>, but rather returns a so-
; called delayed object, which we can think of as a
; "promise" to evaluate <exp> at some future time.
; As a companion to delay, there is a procedure called
; force, that takes a delayed object as argument and per-
; forms the evaluation -in effect, forcing the delay to
; fulfill its promise.

; Cons-stream is a special form defined so that
(cons-stream <a> <b>)
; is equivalent to
(cons <a> (delay <b>))
; this means that streams are constructed using pairs.
; However, rather than placing the value of the rest of
; the stream into the cdr of the pair, we put there a pro-
; mise to compute the rest if it is ever requested.

; Stream-car and stream-cdr can now be defined as procedu-
; res:
(define (stream-car stream) (car stream))

(define (stream-cdr stream) (force (cdr stream)))

; Stream-car selects the car of the pair. Stream-cdr se-
; lects the cdr of the pair and evaluates the delayed ex-
; pression found there to obtain the rest of the stream.

; Implementation of delay and force
; Delay must package an expression so that it can be eval-
; uated later on demad, and we can accomplish this simply
; by treating the expression as the body of a procedure.
; delay can be a special form such that
(delay <exp>)
; is syntactic sugar for
(lambda () <exp>)
; Force simply calls the procedure (of no arguments) pro-
; duced by delay, so we can implement force as a proced-
; ure:
(define (force delayed-object)
  (delayed-object))

; This implementation suffices for delay and force to work
; as advertised, but there is an importart optimization that
; we can include.
; In many applications, we end up forcing the same delayed
; object many times. This can lead to serious inefficiency
; in recursive programs involving streams.
; the solution is to build delayed objects so that the
; first time they are forced, they store the value that is
; computed. Subsequent forcings will simply return the
; stored value without repeating the computation.
; In other words, we implement delay as a special-purpose
; memorized procedure.
; We can accomplish this by the following procedure, which
; takes as argument a procedure, (of no arguments) and
; returns a memoized version of the procedure.
; The first time the memoized procedure is run, it saves
; the computed result. On subsequent evaluations, it simply
; returns the result.
(define (memo-proc proc)
  (let ((already-run? false) (result false))
    (lambda ()
      (if (not already-run?)
          (begin (set! result (proc))
                 (set! already-run? true)
                 result)
          result))))
; Delay is the defined so that (delay <exp>) is equivalent
; to
(memo-proc (lambda () <exp>))