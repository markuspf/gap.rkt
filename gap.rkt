#lang racket/base

; C FFI into libgap for gasket (or other racket programs)

(require ffi/unsafe
         ffi/unsafe/define)

(define-ffi-definer define-gap
  (ffi-lib "extern/gap/.libs/libgap.so"))

; Datatypes
(define _gap-obj (_cpointer/null 'GAP-OBJ))

;
; Defined in libgap-api.h
;
; Initialize LibGAP
(define-gap GAP_Initialize (_fun _int
                                 (v : (_list i _string))
                                 (e : (_list i _string))
                                 (mark : _pointer)
                                 (error : _pointer)
                                 -> _void))

; Evaluate a string
(define-gap GAP_EvalString
  (_fun _string -> _void))

; Obtain the value of a global variable
(define-gap GAP_ValueGlobalVariable
  (_fun _string -> _gap-obj))


(define-gap GAP_EQ
  (_fun _gap-obj _gap-obj -> _int))
(define-gap GAP_LT
  (_fun _gap-obj _gap-obj -> _int))
(define-gap GAP_IN
  (_fun _gap-obj _gap-obj -> _int))

(define-gap GAP_SUM
  (_fun _gap-obj _gap-obj -> _gap-obj))
(define-gap GAP_DIFF
  (_fun _gap-obj _gap-obj -> _gap-obj))
(define-gap GAP_PROD
  (_fun _gap-obj _gap-obj -> _gap-obj))
(define-gap GAP_QUO
  (_fun _gap-obj _gap-obj -> _gap-obj))
(define-gap GAP_LQUO
  (_fun _gap-obj _gap-obj -> _gap-obj))
(define-gap GAP_POW
  (_fun _gap-obj _gap-obj -> _gap-obj))
(define-gap GAP_COMM
  (_fun _gap-obj _gap-obj -> _gap-obj))
(define-gap GAP_MOD
  (_fun _gap-obj _gap-obj -> _gap-obj))


(define-gap GAP_True
  _gap-obj)
(define-gap GAP_False
  _gap-obj)
(define-gap GAP_Fail
  _gap-obj)

(define-gap GAP_CallFuncList
  (_fun (op : _gap-obj) (args : _gap-obj) -> _gap-obj))
(define-gap GAP_CallFuncArray
  (_fun (op : _gap-obj) (nargs : _uint) (_list i _gap-obj) -> _gap-obj))

(define-gap GAP_IsInt
  (_fun (o : _gap-obj) -> _int))

(define-gap GAP_IsSmallInt
  (_fun (o : _gap-obj) -> _int))

(define-gap GAP_IsLargeInt
  (_fun (o : _gap-obj) -> _int))

(define-gap GAP_MakeObjInt
  (_fun (limbs : (_list i _uint)) (size : _int) -> _gap-obj))

(define-gap GAP_SizeInt
  (_fun (o : _gap-obj) -> _int))

(define-gap GAP_AddrInt
  (_fun (o : _gap-obj) -> (_list i _uint)))

(define-gap GAP_IsList
  (_fun (o : _gap-obj) -> _int))

(define-gap GAP_LenList
  (_fun (o : _gap-obj) -> _uint))

(define-gap GAP_AssList
  (_fun (l : _gap-obj) _uint _gap-obj -> _void))

(define-gap GAP_ElmList
  (_fun (l : _gap-obj) (pos : _uint) -> _gap-obj))

(define-gap GAP_NewPlist
  (_fun (cap : _int) -> _gap-obj))

(define-gap GAP_IsString
  (_fun (o : _gap-obj) -> _int))

(define-gap GAP_LenString
  (_fun (o : _gap-obj) -> _uint))

(define-gap GAP_CSTR_STRING
  (_fun (o : _gap-obj) -> _string))

(define-gap GAP_MakeString
  (_fun (s : _string) -> _gap-obj))

(define-gap GAP_MakeImmString
  (_fun (s : _string) -> _gap-obj))

(define-gap GAP_ValueOfChar
  (_fun (o : _gap-obj) -> _int))

(define-gap GAP_CharWithValue
  (_fun (o : _uint8) -> _gap-obj))


; Our own API
(define (gap-initialize lib)
  (GAP_Initialize 5 
                  (list
                   "" "-l" lib "-r" "-A" "--nointeract" #f)
                  (list #f)
                  #f #f))


