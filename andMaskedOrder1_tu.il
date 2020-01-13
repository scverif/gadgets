// Copyright 2020 - NXP

include il "isa/isa-cortex-m0plus.il"
include il "isa/leakyisa-cortex-m0plus.il"
include asm "gadgets/andMaskedOrder1_tu.objdump"

annotate andMaskedOrder1_TU
  region mem w32 a[0:1]
  region mem w32 b[0:1]
  region mem w32 c[0:1]
  region mem w32 rnd[0:1]
  region mem w32 stack[-4:-1]
  init r1 [a 0]
  init r2 [b 0]
  init r3 [rnd 0]
  init r0 [c 0]
  init sp [stack 0]
  init lr exit
  input sharing a
  input sharing b
  input public opA
  input public opB
  input public opR
  input public opW
  input public r0
  input public r1
  input public r2
  input public r3
  input public r4
  input public r5
  input public r6
  input public r7
  input public stack
  input public sp
  input public lr
  input urandom rnd
  input sharing c
  output sharing c
  /* everything else assumed to be public input !and! public output */;

---
addleakage:
  target: andMaskedOrder1_TU;

print:
  kind: macrodef
  target: andMaskedOrder1_TU
  verbosity: 0;

inlinecall:
  target: andMaskedOrder1_TU;

partialeval:
  target: andMaskedOrder1_TU;

print:
  kind: initials
  target: andMaskedOrder1_TU
  verbosity: 0;

rewriteformv:
  target: andMaskedOrder1_TU
  inferinput: false
  inferoutput: true;

print:
  kind: initials
  target: andMaskedOrder1_TU
  verbosity: 0;

print:
  kind: maskverif
  target: andMaskedOrder1_TU
  verbosity: 0;

check:
  kind: SNI
  target: andMaskedOrder1_TU;
...
