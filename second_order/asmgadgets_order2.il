// Copyright 2020 - NXP, TU Darmstadt
// SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications

include il "models/isa-cortex-m0plus-metrics.il"
include il "models/leakyisa-cortex-m0plus.il"
include gas "second_order/asmgadgets_order2.s"

annotate xorOrder2
  region mem w32 a[0:2]
  region mem w32 b[0:2]
  region mem w32 c[0:2]
  region mem w32 rnd[0:0]
  region mem w32 stack[-4:-1]
  init r0 [rnd 0]
  init r1 [c 0]
  init r2 [a 0]
  init r3 [b 0]
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
  input public c
  input public rnd
  output sharing c
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
  output public metric_ops_copy
  ;

annotate andOrder2
  region mem w32 a[0:2]
  region mem w32 b[0:2]
  region mem w32 c[0:2]
  region mem w32 rnd[0:3]
  region mem w32 stack[-4:-1]
  init r0 [rnd 0]
  init r1 [c 0]
  init r2 [a 0]
  init r3 [b 0]
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
  input public c
  input public rnd [0:0]
  input urandom rnd [1:3]
  output sharing c
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
  output public metric_ops_copy
  ;

annotate refOrder2
  region mem w32 a[0:2]
  region mem w32 c[0:2]
  region mem w32 rnd[0:2]
  region mem w32 stack[-4:-1]
  init r0 [rnd 0]
  init r1 [c 0]
  init r2 [a 0]
  init sp [stack 0]
  init lr exit
  input sharing a
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
  input public c
  input public rnd [0:0]
  input urandom rnd [1:2]
  output sharing c
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
  output public metric_ops_copy
  ;

annotate notOrder2
  region mem w32 a[0:2]
  region mem w32 rnd[0:0]
  init r0 [rnd 0]
  init r1 [a 0]
  init lr exit
  input sharing a
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
  input public sp
  input public lr
  input public rnd [0:0]
  output sharing a
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
  output public metric_ops_copy
  ;

annotate leakOrder2
  region mem w32 a[0:2]
  region mem w32 rnd[0:0]
  init r0 [rnd 0]
  init r1 [a 0]
  init lr exit
  input sharing a
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
  input public sp
  input public lr
  input public rnd [0:0]
  output sharing a
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
  output public metric_ops_copy
  ;

---
addleakage:
  target: "*";

inlinecall:
  target: [xorOrder2, andOrder2, refOrder2, notOrder2, leakOrder2];

partialeval:
  target: [xorOrder2, andOrder2, refOrder2, notOrder2, leakOrder2];

infertaint:
  inputsAsPublic: false
  outputsAsPublic: true
  memoryAsPublicOut: true
  target: [xorOrder2, andOrder2, refOrder2, notOrder2, leakOrder2];

print:
  kind: variables
  variables: [metric_cyclecount, r0, rnd]
  target: [xorOrder2, andOrder2, refOrder2, notOrder2, leakOrder2]
  verbosity: 1;

print:
  kind: variables
  variables: "metric_*"
  target: [xorOrder2, andOrder2, refOrder2, notOrder2, leakOrder2]
  verbosity: 1;

check:
  kind: "Stateful NI"
  target: [xorOrder2, notOrder2];

check:
  kind: "Stateful SNI"
  target: [andOrder2, refOrder2];
 ...

// Local Variables:
// eval: (setq default-directory (concat (file-name-directory buffer-file-name) "..") compile-command (concat "scverif --il " buffer-file-name))
// End:
