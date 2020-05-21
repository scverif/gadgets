// Copyright 2019-2020 - NXP, TU Darmstadt
// SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications

include il "models/isa-cortex-m0plus-metrics.il"
include il "models/leakyisa-cortex-m0plus.il"
include gas "present/first_order/asmpresent_order1.s"

annotate presentOrder1
  region mem w32 in[0:7]
  region mem w32 out[0:7]
  region mem w32 stack[-14:-1]
  region mem w32 rnd[0:7]
  init r0 [rnd 0]
  init r1 [out 0]
  init r2 [in 0]
  init sp [stack 0]
  init lr exit
//  init rnd [w32 0, w32 0, w32 0, w32 0, w32 0, w32 0, w32 0, w32 0]
// input result in zero output:
//  init in [w32 0x0000, w32 0x0000, w32 0xFFFFFFFF, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0xFFFFFFFF]
// sbox of zero:
//  init in [w32 0, w32 0, w32 0, w32 0, w32 0, w32 0, w32 0, w32 0]
// random test vector
//  init in [w32 0xD84870A5, w32 0xFF10BAE1, w32 0x08E14400, w32 0xFF31B8AA, w32 0x412FE9D6, w32 0x783C5B5D, w32 0x56A7A53B, w32 0x1F6BB130]
//  init rnd [w32 0, w32 0x99BE28FB, w32 0x6CA2C0E4, w32 0x62CAD584, w32 0x644ECF39, w32 0x1B0ACEA1, w32 0x73E75F86, w32 0x0B9602F0]
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
  output public stack
  input public sp
  input public lr
  input public pc
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
  input public out
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

annotate calcAOrder1
  region mem w32 in[0:7]
  region mem w32 out[0:7]
  region mem w32 stack[-14:-1]
  region mem w32 rnd[0:7]
  init r0 [rnd 0]
  init r1 [out 0]
  init r2 [in 0]
  init sp [stack 0]
  init lr exit
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
  output public stack
  input public sp
  input public lr
  input public pc
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
  output secret apsrc
  ;

annotate calcBOrder1
  region mem w32 in[0:7]
  region mem w32 out[0:7]
  region mem w32 stack[-14:-1]
  region mem w32 rnd[0:7]
  init r0 [rnd 0]
  init r1 [out 0]
  init r2 [in 0]
  init sp [stack 0]
  init lr exit
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
  output public stack
  input public sp
  input public lr
  input public pc
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
  output secret apsrc
  ;

annotate calcGOrder1
  region mem w32 in[0:7]
  region mem w32 out[0:7]
  region mem w32 stack[-14:-1]
  region mem w32 rnd[0:7]
  init r0 [rnd 0]
  init r1 [out 0]
  init r2 [in 0]
  init sp [stack 0]
  init lr exit
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
  output public stack
  input public sp
  input public lr
  input public pc
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
  output secret apsrc
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
  verbosity: 0;

partialeval:
  target: [calcAOrder1, calcBOrder1, calcGOrder1, presentOrder1];

infertaint:
  inputsAsPublic: false
  outputsAsPublic: true
  memoryAsPublicOut: true
  target: [calcAOrder1, calcBOrder1, calcGOrder1, presentOrder1];

print:
  kind: maskverif
  target: [calcAOrder1, calcBOrder1, calcGOrder1, presentOrder1]
  verbosity: 0;

print:
  kind: variables
  variables: "metric_*"
  target: [calcAOrder1, calcBOrder1, calcGOrder1, presentOrder1]
  verbosity: 1;

print:
  kind: variables
  variables: [in, rnd, out, stack, sp, r0, r1, r2]
  target: [calcAOrder1, calcBOrder1, calcGOrder1, presentOrder1]
  verbosity: 1;

check:
  target: [presentOrder1]
  kind: "Stateful NI";
...

// Local Variables:
// eval: (setq default-directory (concat (file-name-directory buffer-file-name) "../..") compile-command (concat "scverif --il " buffer-file-name))
// End:
