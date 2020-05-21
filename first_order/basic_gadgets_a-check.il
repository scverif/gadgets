// Copyright 2020 - NXP, TU Darmstadt
// SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications

include il "first_order/basic_gadgets_a.il"

annotate firstxor
  region mem w32 a[0:1]
  region mem w32 b[0:1]
  region mem w32 c[0:1]
  region mem w32 rnd[0:0]
  region mem w32 stack[-2:-1]
  init r0 [rnd 0]
  init r1 [c 0]
  init r2 [a 0]
  init r3 [b 0]
  init sp [stack 0]
//  init a [w32 0x5AF0, w32 0x0000]
//  init b [w32 0x0000, w32 0xA5F0]
//  init rnd [w32 0x0000]
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
  input public c
  input public rnd[0:0]
  output sharing c
  input public pub
  input public metric_cyclecount
  input public metric_scrubcount
  input public metric_clearcount_opA
  input public metric_clearcount_opB
  input public metric_clearcount_opR
  input public metric_clearcount_opW
  input public metric_ops_xor
  input public metric_ops_and
  input public metric_ops_copy
  input public metric_ops_load
  output secret metric_ops_store
  output secret metric_cyclecount
  output secret metric_scrubcount
  output secret metric_clearcount_opA
  output secret metric_clearcount_opB
  output secret metric_clearcount_opR
  output secret metric_clearcount_opW
  output secret metric_ops_xor
  output secret metric_ops_and
  output secret metric_ops_copy
  output secret metric_ops_load
  output secret metric_ops_store
  init metric_cyclecount 0
  init metric_scrubcount 0
  init metric_clearcount_opA 0
  init metric_clearcount_opB 0
  init metric_clearcount_opR 0
  init metric_clearcount_opW 0
  init metric_ops_xor 0
  init metric_ops_and 0
  init metric_ops_copy 0
  init metric_ops_load 0
  init metric_ops_store 0
  ;

annotate firstmult
  region mem w32 a[0:1]
  region mem w32 b[0:1]
  region mem w32 c[0:1]
  region mem w32 rnd[0:0]
  region mem w32 stack[-4:-1]
  init r0 [rnd 0]
  init r1 [c 0]
  init r2 [a 0]
  init r3 [b 0]
  init sp [stack 0]
//  init a [w32 0x5AF0, w32 0x0000]
//  init b [w32 0x0000, w32 0xA5F0]
//  init rnd [w32 0x0000]
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
  input urandom rnd[0:0]
  input public c
  output sharing c
  input public pub
  input public metric_cyclecount
  input public metric_scrubcount
  input public metric_clearcount_opA
  input public metric_clearcount_opB
  input public metric_clearcount_opR
  input public metric_clearcount_opW
  input public metric_ops_xor
  input public metric_ops_and
  input public metric_ops_copy
  input public metric_ops_load
  output secret metric_ops_store
  output secret metric_cyclecount
  output secret metric_scrubcount
  output secret metric_clearcount_opA
  output secret metric_clearcount_opB
  output secret metric_clearcount_opR
  output secret metric_clearcount_opW
  output secret metric_ops_xor
  output secret metric_ops_and
  output secret metric_ops_copy
  output secret metric_ops_load
  output secret metric_ops_store
  init metric_cyclecount 0
  init metric_scrubcount 0
  init metric_clearcount_opA 0
  init metric_clearcount_opB 0
  init metric_clearcount_opR 0
  init metric_clearcount_opW 0
  init metric_ops_xor 0
  init metric_ops_and 0
  init metric_ops_copy 0
  init metric_ops_load 0
  init metric_ops_store 0
  ;

annotate firstref
  region mem w32 a[0:1]
  region mem w32 c[0:1]
  region mem w32 rnd[0:0]
  region mem w32 stack[-2:-1]
  init r0 [rnd 0]
  init r1 [c 0]
  init r3 [a 0]
  init sp [stack 0]
//  init a [w32 0x5AF0, w32 0x0000]
//  init rnd [w32 0x0000]
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
  input urandom rnd[0:0]
  input public c
  output sharing c
  input public pub
  input public metric_cyclecount
  input public metric_scrubcount
  input public metric_clearcount_opA
  input public metric_clearcount_opB
  input public metric_clearcount_opR
  input public metric_clearcount_opW
  input public metric_ops_xor
  input public metric_ops_and
  input public metric_ops_copy
  input public metric_ops_load
  output secret metric_ops_store
  output secret metric_cyclecount
  output secret metric_scrubcount
  output secret metric_clearcount_opA
  output secret metric_clearcount_opB
  output secret metric_clearcount_opR
  output secret metric_clearcount_opW
  output secret metric_ops_xor
  output secret metric_ops_and
  output secret metric_ops_copy
  output secret metric_ops_load
  output secret metric_ops_store
  init metric_cyclecount 0
  init metric_scrubcount 0
  init metric_clearcount_opA 0
  init metric_clearcount_opB 0
  init metric_clearcount_opR 0
  init metric_clearcount_opW 0
  init metric_ops_xor 0
  init metric_ops_and 0
  init metric_ops_copy 0
  init metric_ops_load 0
  init metric_ops_store 0
  ;

annotate firstxorone
  region mem w32 a[0:1]
  region mem w32 c[0:1]
  region mem w32 rnd[0:0]
  region mem w32 stack[-2:-1]
  init r0 [rnd 0]
  init r1 [c 0]
  init r3 [a 0]
  init sp [stack 0]
//  init a [w32 0x5AF0, w32 0x0000]
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
  input public c
  input public rnd[0:0]
  output sharing c
  input public pub
  input public metric_cyclecount
  input public metric_scrubcount
  input public metric_clearcount_opA
  input public metric_clearcount_opB
  input public metric_clearcount_opR
  input public metric_clearcount_opW
  input public metric_ops_xor
  input public metric_ops_and
  input public metric_ops_copy
  input public metric_ops_load
  output secret metric_ops_store
  output secret metric_cyclecount
  output secret metric_scrubcount
  output secret metric_clearcount_opA
  output secret metric_clearcount_opB
  output secret metric_clearcount_opR
  output secret metric_clearcount_opW
  output secret metric_ops_xor
  output secret metric_ops_and
  output secret metric_ops_copy
  output secret metric_ops_load
  output secret metric_ops_store
  init metric_cyclecount 0
  init metric_scrubcount 0
  init metric_clearcount_opA 0
  init metric_clearcount_opB 0
  init metric_clearcount_opR 0
  init metric_clearcount_opW 0
  init metric_ops_xor 0
  init metric_ops_and 0
  init metric_ops_copy 0
  init metric_ops_load 0
  init metric_ops_store 0
  ;

annotate firststore
  region mem w32 a[0:1]
  region mem w32 c[0:1]
  region mem w32 rnd[0:0]
  init r0 [rnd 0]
  init r1 [c 0]
  init r3 [a 0]
//  init a [w32 0x5AF0, w32 0x0000]
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
  input public rnd[0:0]
  input public c
  output sharing c
  input public pub
  input public metric_cyclecount
  input public metric_scrubcount
  input public metric_clearcount_opA
  input public metric_clearcount_opB
  input public metric_clearcount_opR
  input public metric_clearcount_opW
  input public metric_ops_xor
  input public metric_ops_and
  input public metric_ops_copy
  input public metric_ops_load
  output secret metric_ops_store
  output secret metric_cyclecount
  output secret metric_scrubcount
  output secret metric_clearcount_opA
  output secret metric_clearcount_opB
  output secret metric_clearcount_opR
  output secret metric_clearcount_opW
  output secret metric_ops_xor
  output secret metric_ops_and
  output secret metric_ops_copy
  output secret metric_ops_load
  output secret metric_ops_store
  init metric_cyclecount 0
  init metric_scrubcount 0
  init metric_clearcount_opA 0
  init metric_clearcount_opB 0
  init metric_clearcount_opR 0
  init metric_clearcount_opW 0
  init metric_ops_xor 0
  init metric_ops_and 0
  init metric_ops_copy 0
  init metric_ops_load 0
  init metric_ops_store 0
  ;

---
inlinecall:
  target: [firstxor, firstmult, firstref, firstxorone, firststore];

partialeval:
  target: [firstxor, firstmult, firstref, firstxorone, firststore];

infertaint:
  inputsAsPublic: false
  outputsAsPublic: true
  memoryAsPublicOut: true
  target: [firstxor, firstmult, firstref, firstxorone, firststore];

print:
  kind: variables
  variables: [metric_cyclecount, r0, rnd, c]
  target: [firstxor, firstmult, firstref, firstxorone, firststore]
  verbosity: 1;

print:
  kind: maskverif
  target: [firstxor, firstref, firstxorone, firststore]
  verbosity: 0;

check:
  kind: "Stateful NI"
  target: [firstxor, firstxorone, firststore];

check:
  kind: "Stateful SNI"
  target: [firstmult, firstref];
...

// Local Variables:
// eval: (setq default-directory (concat (file-name-directory buffer-file-name) "..") compile-command (concat "scverif --il " buffer-file-name))
// End:
