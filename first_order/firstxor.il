// Copyright 2019-2020 - TU Darmstadt, NXP
// SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications

include il "models/pseudoisa-clearings.il"

macro firstxor ()
{
/*calculation of thefirst outputshare c0 = a0+b0*/

/*load a0 into register r4*/
  load(r4, r1, 0);
/*load b0 into register r5*/
  load(r5, r2, 0);

/*xor r4 and r5 s.t. r4 contains a0+b0*/
  xor(r4, r5);

/*store value of r4 = a0+b0 as output value c0*/
  store(r4, r0, 0);

clear(opW);

/*calculation of thefirst outputshare c0 = a0+b0*/

/*load a1 into register r5*/
  load(r5, r1, 1);
/*load b1 into register r6*/
  load(r6, r2, 1);

/*xor r5 and r6 s.t. r5 contains a1+b1*/
  xor(r5, r6);

/*store value of r5 = a1+b1 as output value c1*/
/*load a1 into register r5*/
  load(r5, r1, 1);
/*load b1 into register r6*/
  load(r6, r2, 1);

/*xor r5 and r6 s.t. r5 contains a1+b1*/
  xor(r5, r6);

/*store value of r5 = a1+b1 as output value c1*/
  store(r5, r0, 1);

  scrub(r4);
  scrub(r5);
  scrub(r6);
  clear(opW);
  clear(opB);
  clear(opA);
  clear(opR);
}

annotate firstxor
  region mem w32 a[0:1]
  region mem w32 b[0:1]
  region mem w32 c[0:1]
  region mem w32 rnd[0:0]
  init r0 [c 0]
  init r1 [a 0]
  init r2 [b 0]
  init r3 [rnd 0]
  input sharing a
  input sharing b
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
inlinecall:
  target: firstxor;

print:
  kind: macrodef
  target: firstxor
  verbosity: 0;

partialeval:
  target: firstxor;

infertaint:
  inputsAsPublic: false
  outputsAsPublic: true
  memoryAsPublicOut: true
  target: firstxor;

print:
  kind: maskverif
  target: firstxor
  verbosity: 0;

print:
  kind: variables
  variables: "metric_*"
  target: firstxor
  verbosity: 1;

check:
  target: firstxor
  kind: "Stateful NI";
...

// Local Variables:
// eval: (setq default-directory (concat (file-name-directory buffer-file-name) "..") compile-command (concat "scverif --il " buffer-file-name))
// End:
