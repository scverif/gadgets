/* Copyright 2020 - TU Darmstadt, NXP */
/* SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications */

include il "models/isa-cortex-m0plus-metrics.il"
include il "models/leakyisa-cortex-m0plus.il"
include gas "present/second_order/asmpresent_order2.s"

annotate presentOrder2
  region mem w32 in[0:11]
  region mem w32 out[0:11]
  region mem w32 stack[-18:-1]
  region mem w32 rnd[0:26]
  init r0 [rnd 0]
  init r1 [out 0]
  init r2 [in 0]
  init sp [stack 0]
  init lr exit
/*
  init in  [w32 0, w32 0, w32 0,
            w32 0, w32 0, w32 0xFFFFFFFF,
            w32 0, w32 0, w32 0,
            w32 0, w32 0, w32 0xFFFFFFFF]
  init rnd [w32 0, w32 0, w32 0, w32 0, w32 0, w32 0, w32 0,
            w32 0, w32 0, w32 0, w32 0, w32 0, w32 0, w32 0,
            w32 0, w32 0, w32 0, w32 0, w32 0, w32 0, w32 0,
            w32 0, w32 0, w32 0, w32 0, w32 0, w32 0]
*/
/*
init in  [w32 0xD84870A5, w32 0xFF10BAE1, w32 0x00000000,
          w32 0x08E14400, w32 0xFF31B8AA, w32 0x00000000,
          w32 0x412FE9D6, w32 0x783C5B5D, w32 0x00000000,
          w32 0x56A7A53B, w32 0x1F6BB130, w32 0x00000000]
init rnd [w32 0,
          w32 0xD84870A5, w32 0xFF10BAE1, w32 0x08E14400,
          w32 0xFF31B8AA, w32 0x412FE9D6, w32 0x783C5B5D,
          w32 0x56A7A53B, w32 0x1F6BB130, w32 0x1F6BB130,
          w32 0xD84870A5, w32 0xFF10BAE1, w32 0x08E14400,
          w32 0xFF31B8AA, w32 0x412FE9D6, w32 0x783C5B5D,
          w32 0x56A7A53B, w32 0x1F6BB130, w32 0x1F6BB130,
          w32 0xD84870A5, w32 0xFF10BAE1, w32 0x08E14400,
          w32 0xFF31B8AA, w32 0x412FE9D6, w32 0x783C5B5D,
          w32 0x56A7A53B, w32 0x1F6BB130]
*/
  input sharing a [in[0:2]]     // a masked input denoted "a" is located in a given range of "in"
  input sharing b [in[3:5]]
  input sharing c [in[6:8]]
  input sharing d [in[9:11]]
  input urandom rnd
  output sharing oa [out[0:2]]
  output sharing ob [out[3:5]]
  output sharing oc [out[6:8]]
  output sharing od [out[9:11]]
  input public stack
  input public out
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
  input public r8
  input public r9
  input public lr
  input public pc
  init metric_cyclecount 0
  init metric_ops_xor 0
  init metric_ops_and 0
  init metric_ops_load 0
  init metric_ops_store 0
  init metric_ops_copy 0
  input public metric_cyclecount
  input public metric_ops_xor
  input public metric_ops_and
  input public metric_ops_load
  input public metric_ops_store
  input public metric_ops_copy
  output secret metric_cyclecount
  output secret metric_ops_xor
  output secret metric_ops_and
  output secret metric_ops_load
  output secret metric_ops_store
  output secret metric_ops_copy
  output secret apsrn
  output secret apsrc
  output secret apsrz
  output secret apsrv
  ;

---
addleakage:
  target: "*";

inlinecall:
  target: [calcAOrder2, calcBOrder2, calcGOrder2, presentOrder2];

print:
  kind: macrodef
  target: [presentOrder2]
  verbosity: 0;

partialeval:
  target: [presentOrder2];

/*
filterleak:
  inverse: false
  leaks: [ldrOperand1, ldrOperand2A, ldrOperand2B]
  target: [presentOrder2];
*/

infertaint:
  inputsAsPublic: false
  outputsAsPublic: true
  memoryAsPublicOut: true
  target: [presentOrder2];

print:
  kind: maskverif
  target: [presentOrder2]
  verbosity: 0;

print:
  kind: variables
  variables: "metric_*"
  target: [presentOrder2]
  verbosity: 1;

print:
  kind: variables
  variables: [in, rnd, out, stack, r0]
  target: [presentOrder2]
  verbosity: 1;

check:
  target: [presentOrder2]
  kind: "Stateful NI";
...

// Local Variables:
// eval: (setq default-directory (concat (file-name-directory buffer-file-name) "../..") compile-command (concat "scverif --il " buffer-file-name))
// End:
