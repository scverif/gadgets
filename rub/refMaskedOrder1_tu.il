// Copyright 2019-2020 - NXP
// SPDX-License-Identifier: AGPL-3.0-or-later

include il "isa/isa-cortex-m0plus.il"
include il "isa/leakyisa-cortex-m0plus.il"
include asm "gadgets/refMaskedOrder1_tu.objdump"

annotate refMaskedOrder1_TU
  region mem w32 a[0:1]
  region mem w32 c[0:1]
  region mem w32 rnd[0:0]
  region mem w32 stack[-2:-1]
  init r1 [a 0]
  init r2 [rnd 0]
  init r0 [c 0]
  init sp [stack 0]
  init lr exit
  input sharing a
  input urandom rnd
  input public r0
  input public r1
  input public r2
  input public r3
  input public r4
  input public r5
  input public sp
  input public lr
  input public opA
  input public opB
  input public opR
  input public opW
  output public stack
  output sharing c
  /* everything else assumed to be public input !and! public output */;

---
addleakage:
  target: refMaskedOrder1_TU;

print:
  kind: macrodef
  target: refMaskedOrder1_TU
  verbosity: 0;

inlinecall:
  target: refMaskedOrder1_TU;

partialeval:
  target: refMaskedOrder1_TU;

rewriteformv:
  target: refMaskedOrder1_TU
  inferinput: false
  inferoutput: true;

print:
  kind: maskverif
  target: refMaskedOrder1_TU
  verbosity: 3;

check:
  kind: "Stateful SNI"
  target: refMaskedOrder1_TU;
...
