// Copyright 2019-2020 - NXP, TU Darmstadt
// SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications

include il "models/isa-cortex-m0plus-metrics.il"
include il "models/leakyisa-cortex-m0plus.il"
include gas "present/first_order/asmpresent_order1.s"

annotate presentOrder1
  region mem w32 in[0:7]
  region mem w32 out[0:7]
  region mem w32 stack[-1:7]
  region mem w32 rnd[0:10]
  init r0 [rnd 0]
  init r1 [out 0]
  init r2 [in 0]
  init sp [stack 0]
  init lr exit
//  init in [w32 0x0000, w32 0x0000, w32 0xFFFFFFFF, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0xFFFFFFFF]
//  init rnd [w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000]
  input sharing a [in[0:1]]     // an input sharing named "a" is located in a given range of "in"
  input sharing b [in[2:3]]
  input sharing c [in[4:5]]
  input sharing d [in[6:7]]
  input urandom rnd
  output sharing ao [out[0:1]]  // an output sharing named "oa" is located in a given range of "out"
  output sharing bo [out[2:3]]
  output sharing co [out[4:5]]
  output sharing do [out[6:7]]
  input public stack
  input public sp
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
  init metric_cyclecount 0
  init metric_ops_xor 0
  init metric_ops_and 0
  init metric_ops_copy 0
  init metric_ops_load 0
  init metric_ops_store 0
  ;

---
addleakage:
  target: "*";

print:
  kind: macrodef
  target: [presentOrder1]
  verbosity: 0;

inlinecall:
  target: [calcAOrder1, calcBOrder1, calcGOrder1, presentOrder1];

print:
  kind: macrodef
  target: [presentOrder1]
  verbosity: 1;

partialeval:
  target: [presentOrder1];

rewriteformv:
  target: [presentOrder1]
  inferinput: false
  inferoutput: true;

print:
  kind: maskverif
  target: [presentOrder1]
  verbosity: 0;

print:
  kind: variables
  variables: "metric_*"
  target: [presentOrder1]
  verbosity: 1;

print:
  kind: variables
  variables: [in, rnd, out]
  target: [presentOrder1]
  verbosity: 1;

check:
  target: [presentOrder1]
  kind: "Stateful NI";
...

// Local Variables:
// eval: (setq default-directory (concat (file-name-directory buffer-file-name) "../..") compile-command (concat "scverif --il " buffer-file-name))
// End:
