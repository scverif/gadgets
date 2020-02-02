// Copyright 2020 - NXP, TU Darmstadt

include il "models/isa-cortex-m0plus-metrics.il"
include il "models/leakyisa-cortex-m0plus.il"
include asm "second_order/asmgadgets_order2.objdump"

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
  init cyclecount 0
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
  output sharing c;

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
  init cyclecount 0
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
  output sharing c;

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
  init cyclecount 0
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
  output sharing c;

annotate notOrder2
  region mem w32 a[0:2]
  region mem w32 rnd[0:0]
  init r0 [rnd 0]
  init r1 [a 0]
  init lr exit
  init cyclecount 0
  input sharing a
  input public opA
  input public opB
  input public opR
  input public opW
  input public r0
  input public r1
  input public r2
  input public r3
  input public lr
  input public rnd [0:0]
  output sharing a;

annotate leakOrder2
  region mem w32 a[0:2]
  region mem w32 rnd[0:0]
  init r0 [rnd 0]
  init r1 [a 0]
  init lr exit
  init cyclecount 0
  input sharing a
  input public opA
  input public opB
  input public opR
  input public opW
  input public r0
  input public r1
  input public r2
  input public r3
  input public lr
  input public rnd [0:0]
  output sharing a;

---
addleakage:
  target: "*";

inlinecall:
  target: [xorOrder2, andOrder2, refOrder2, notOrder2, leakOrder2];

partialeval:
  target: [xorOrder2, andOrder2, refOrder2, notOrder2, leakOrder2];

rewriteformv:
  target: [xorOrder2, andOrder2, refOrder2, notOrder2, leakOrder2]
  inferinput: false
  inferoutput: true;

print:
  kind: variables
  variables: [cyclecount, r0, rnd]
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
