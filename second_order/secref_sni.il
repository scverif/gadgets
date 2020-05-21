// Copyright 2020 - TU Darmstadt, NXP
// SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications

include il "models/pseudoisa-clearings.il"

macro secref ()
{
  load(r4, r3, 0);
  load(r6, r1, 0);

clear(opR);

  load(r5, r3, 1);
  xor(r6, r4);
  store(r6, r0, 0);

clear(opW);
load_pub(r6);

  load(r7, r1, 1);
clear(opA);
  xor(r7, r5);

  store(r7, r0, 1);

clear(opW);
clear(opB);

  xor(r4, r5);
load_pub(r5);
clear(opB);
  load(r5, r1, 2);
  xor(r5, r4);

  store(r5, r0, 2);

load_pub(r4);
load_pub(r5);
load_pub(r6);
load_pub(r7);
clear(opA);
clear(opB);
clear(opR);
clear(opW);
}


annotate secref
  region mem w32 a[0:2]
  region mem w32 c[0:2]
  region mem w32 rnd[0:2]
  init r0 [c 0]
  init r1 [a 0]
  init r3 [rnd 0]
  input sharing a
  input urandom rnd
  output sharing c
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
print:
  kind: macrodef
  target: load
  verbosity: 0;

addleakage:
  target: secref;

inlinecall:
  target: secref;

partialeval:
  target: secref;

infertaint:
  inputsAsPublic: false
  outputsAsPublic: true
  memoryAsPublicOut: true
  target: secref;

print:
  kind: evaltrace
  target: secref
  verbosity: 0;

print:
  kind: variables
  variables: "metric_*"
  target: secref
  verbosity: 1;

check:
  target: secref
  kind: "Stateful SNI";
...

// Local Variables:
// eval: (setq default-directory (concat (file-name-directory buffer-file-name) "..") compile-command (concat "scverif --il " buffer-file-name))
// End:
