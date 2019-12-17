// Copyright 2019 - NXP

include il "isa/isa-cortex-m0plus.il"
include il "isa/leakyisa-cortex-m0plus.il"
include asm "gadgets/xorMaskedOrder1.objdump"

annotate xorMaskedOrder1
  region mem w32 a[0:1]
  region mem w32 b[0:1]
  region mem w32 c[0:1]
  region mem w32 stack[-3:-1]
  init r1 [a 0]
  init r2 [b 0]
  init r0 [c 0]
  init sp [stack 0]
  init lr exit
  input sharing a
  input sharing b
  output sharing c
  /* everything else assumed to be public input !and! public output */;

---
addleakage:
  target: xorMaskedOrder1;

print:
  kind: macrodef
  target: xorMaskedOrder1
  verbosity: 0;

inlinecall:
  target: xorMaskedOrder1;

partialeval:
  target: xorMaskedOrder1;

deadcodeelim:
  target: xorMaskedOrder1;

print:
  kind: maskverif
  target: xorMaskedOrder1
  verbosity: 0;

check:
  kind: NI
  target: xorMaskedOrder1;
...
