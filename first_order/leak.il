// Copyright 2020 - NXP
// SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications

include il "models/isa-cortex-m0plus-metrics.il"
include il "models/leakyisa-cortex-m0plus.il"

macro leakOrder1()
  label leakOrder1, label leakOrder12, label leakOrder14,
  label leakOrder16, label leakOrder18, label leakOrder1a,
  label leakOrder1c, label leakOrder1e, label leakOrder110,
  label leakOrder112, label leakOrder114, label leakOrder116
{
  leakOrder1:
  ldr3_leak(r2, r1, (w32) 0);
  ldr3(r2, r1, (w32) 0);
  leakOrder12:
  ldr3_leak(r3, r0, (w32) 0);
  ldr3(r3, r0, (w32) 0);
  leakOrder14:
  ldr3_leak(r1, r1, (w32) 4);
  ldr3(r1, r1, (w32) 4);
  leakOrder16:
//  eors2_leak(r2, r1);
  opA <- r2;
  opB <- r1;
  eors2(r2, r1);
  leakOrder18:
//  eors2_leak(r2, r2);
  opA <- r2;
  opB <- r2;
  eors2(r2, r2);
  leakOrder1a:
//  ands2_leak(r0, r0);
  opA <- r0;
  opB <- r0;
  ands2(r0, r0);
  leakOrder1c:
  ldr3_leak(r1, r0, (w32) 0);
  ldr3(r1, r0, (w32) 0);
  leakOrder1e:
  str3_leak(r1, r0, (w32) 0);
  str3(r1, r0, (w32) 0);
  leakOrder110:
  ands2_leak(r0, r0);
  ands2(r0, r0);
  leakOrder112:
  adds2(r0, (w32) 0);
  leakOrder114:
  bx1(lr);
  leakOrder116:
  nop0();
}

annotate leakOrder1
  region mem w32 a[0:1]
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
  input public lr
  input public rnd[0:0]
  output sharing a
  init metric_cyclecount 0
  init metric_ops_xor 0
  init metric_ops_and 0
  init metric_ops_load 0
  init metric_ops_store 0
  ;

---
inlinecall:
  target: [leakOrder1];

partialeval:
  target: [leakOrder1];

infertaint:
  inputsAsPublic: false
  outputsAsPublic: true
  memoryAsPublicOut: true
  target: [leakOrder1];

print:
  kind: variables
  variables: [metric_cyclecount, r0, rnd]
  target: [leakOrder1]
  verbosity: 1;

print:
  kind: macrodef
  target: [eors2]
  verbosity: 1;

check:
  kind: "Stateful NI"
  target: [leakOrder1];
...

// Local Variables:
// eval: (setq default-directory (concat (file-name-directory buffer-file-name) "..") compile-command (concat "scverif --il " buffer-file-name))
// End:
