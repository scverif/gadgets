// Copyright 2019 - NXP
// SPDX-License-Identifier: AGPL-3.0-or-later

include il "isa/isa-cortex-m0plus.il"
include il "isa/leakyisa-cortex-m0plus.il"
include asm "gadgets/andMaskedOrder1.objdump"

annotate andMaskedOrder1
  region mem w32 a[0:1]
  region mem w32 b[0:1]
  region mem w32 c[0:1]
  region mem w32 rnd[0:0]
  region mem w32 stack[-5:-1]
  init r1 [a 0]
  init r2 [b 0]
  init r0 [c 0]
  init r3 [rnd 0]
  init sp [stack 0]
  init lr exit
  input sharing a
  input sharing b
  input urandom rnd
  output sharing c
  /* everything else assumed to be public input !and! public output */;

---
addleakage:
  target: andMaskedOrder1;

inlinecall:
  target: andMaskedOrder1;

partialeval:
  target: andMaskedOrder1;

deadcodeelim:
  target: andMaskedOrder1;

print:
  kind: macrodef
  target: andMaskedOrder1
  verbosity: 0;

print:
  kind: maskverif
  target: andMaskedOrder1
  verbosity: 0;

check:
  kind: NI
  target: andMaskedOrder1;
...
