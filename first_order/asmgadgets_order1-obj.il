// Copyright 2020 - NXP, TU Darmstadt

include il "models/isa-cortex-m0plus-metrics.il"
include il "models/leakyisa-cortex-m0plus.il"
include asm "first_order/asmgadgets_order1.objdump"

annotate xorOrder1
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

annotate andOrder1
  region mem w32 a[0:1]
  region mem w32 b[0:1]
  region mem w32 c[0:1]
  region mem w32 rnd[0:1]
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
  input urandom rnd
  input public c
  output sharing c;

annotate refOrder1
  region mem w32 a[0:1]
  region mem w32 c[0:1]
  region mem w32 rnd[0:1]
  region mem w32 stack[-2:-1]
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
  input urandom rnd
  input public c
  output sharing c;

annotate notOrder1
  region mem w32 a[0:1]
  region mem w32 rnd[0:0]
  region mem w32 stack[-2:-1]
  init r0 [rnd 0]
  init r1 [a 0]
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
  input urandom rnd
  output sharing a;

---
addleakage:
  target: "*";

inlinecall:
  target: [xorOrder1, andOrder1, refOrder1, notOrder1];

partialeval:
  target: [xorOrder1, andOrder1, refOrder1, notOrder1];

rewriteformv:
  target: [xorOrder1, andOrder1, refOrder1, notOrder1]
  inferinput: false
  inferoutput: true;

print:
  kind: variables
  variables: [cyclecount, r0, sp, rnd]
  target: [xorOrder1, andOrder1, refOrder1, notOrder1]
  verbosity: 1;

/* FIXME subsequent checking has currently a bug
check:
  kind: "Stateful NI"
  target: [xorOrder1];

check:
  kind: "Stateful SNI"
  target: [andOrder1, refOrder1, notOrder1];  // FIXME fails due to scVerif bug
*/
...


// Local Variables:
// eval: (setq default-directory (concat (file-name-directory buffer-file-name) "..") compile-command (concat "scverif --il " buffer-file-name))
// End:
