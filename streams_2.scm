#lang scheme

(define-syntax delay
  (syntax-rules ()
    ((_ exp) (lambda () exp))))

(define (force delayed-obj)
  (delayed-obj))

(define-syntax cons-stream
  (syntax-rules ()
    ((_ a b) (cons a (delay b)))))

(define (stream-car stream) (car stream))

(define (stream-cdr stream) (force (cdr stream)))

(define the-empty-stream '())

(define empty-stream? null?)

;--------------------------------------------------------
(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream
       low
       (stream-enumerate-interval (+ low 1) high))))

(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (stream-filter pred
                                     (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))

