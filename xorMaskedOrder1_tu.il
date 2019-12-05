// Copyright 2019 - NXP

include il "isa/isa-cortex-m0plus.il"
include il "isa/leakyisa-cortex-m0plus.il"
include asm "gadgets/xorMaskedOrder1_tu.objdump"

annotate xorMaskedOrder1_TU
  region mem w32 a[0:1]
  region mem w32 b[0:1]
  region mem w32 c[0:1]
  region mem w32 rnd[0:0]
  region mem w32 stack[-3:-1]
  init r1 [a 0]
  init r2 [b 0]
  init r3 [rnd 0]
  init r0 [c 0]
  init sp [stack 0]
  init lr exit
  input sharing a
  input sharing b
  input urandom rnd
  output sharing c
  /* everything else assumed to be public input !and! public output */;

---
addleakage:
  target: xorMaskedOrder1_TU;

print:
  kind: macrodef
  target: xorMaskedOrder1_TU
  verbosity: 0;

inlinecall:
  target: xorMaskedOrder1_TU;

partialeval:
  target: xorMaskedOrder1_TU;

deadcodeelim:
  target: xorMaskedOrder1_TU;

print:
  kind: maskverif
  target: xorMaskedOrder1_TU
  verbosity: 1;

/*check:
  kind: NI
  target: xorMaskedOrder1_TU;*/
...
