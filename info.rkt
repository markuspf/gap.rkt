#lang info
(define collection "gap")
(define deps '("base"))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib"))
(define scribblings '(("scribblings/gap.scrbl" ())))
(define pkg-desc "A wrapper around the GAP computer algebra system (https://www.gap-system.org)")
(define version "0.0")
(define pkg-authors '(Markus Pfeiffer))
