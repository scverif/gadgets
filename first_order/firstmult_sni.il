// Copyright 2019-2020 - TU Darmstadt, NXP
// SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications

include il "models/pseudoisa-clearings.il"

macro firstmult ()
{
/*calculation of the first outputshare: c0 = a0*b0 + rnd0 +a0*b1*/

  load(r4, r2, 0);         /*load b0 into register r4*/
  load(r5, r1, 0);         /*load a0 into register r5*/

  and(r4, r5);             /*perform AND r4 and r5 s.t. r4 contains b0*a0*/

  load(r6,r3,0);           /*load rnd0 into register r6*/

  xor(r6,r4);              /*perform XOR r6 and r4 s.t r6 contains b0*a0 + rnd0*/

  load(r7, r2, 1);         /*load b1 into register r7*/

  and(r5, r7);             /*perform AND with registers r5 and r7 s.t. r5 contains a0*b1*/
  xor(r5, r6);             /*perform XOR with registers r5 and r4 s.t. r5 contains a0*b1 + b0*a0 +rnd0*/

  store(r5, r0, 0);        /*store value of r5 = a0*b1 + b0*a0 +rnd0 as output value c0 */

clear(opW);
load_pub(r4);
load_pub(r6);

  load(r4, r1, 1);      /*load a1 into register r4*/

  and(r7, r4);          /*perform AND with registers r7 and r4 s.t. r7 contains b1*a1*/

  load(r6,r3,0);
  xor(r6,r7);           /*perform XOR with registers r6 and r7 s.t. r6 contains b1*a1 + rnd0*/

  load(r5, r2, 0);      /*load b0 into register r6*/

  and(r5, r4);          /*perform AND with registers r6 and r4 s.t. r6 contains b0*a1*/

  xor(r6, r5);          /*perform XOR with registers r6 and r7 s.t. r5 contains b0*a1 + b1*a1 + rnd0  */

  store(r6, r0, 1);     /*store value of r6 = b0a1 + b1*a1 +rnd0 as output value c1 */

  scrub(r4);
  scrub(r5);
  scrub(r6);
  scrub(r7);
  clear(opB);
  clear(opR);
  clear(opW);
}

annotate firstmult
  region mem w32 a[0:1]
  region mem w32 b[0:1]
  region mem w32 c[0:1]
  region mem w32 rnd[0:1]
  init r0 [c 0]
  init r1 [a 0]
  init r2 [b 0]
  init r3 [rnd 0]
  input sharing a
  input sharing b
  input urandom rnd
  output sharing c
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
  target: firstmult;

print:
  kind: macrodef
  target: firstmult
  verbosity: 0;

partialeval:
  target: firstmult;

rewriteformv:
  inferinput: true
  inferoutput: true
  target: firstmult;

print:
  kind: maskverif
  target: firstmult
  verbosity: 0;

print:
  kind: variables
  variables: "metric_*"
  target: firstmult
  verbosity: 1;

check:
  target: firstmult
  kind: "Stateful SNI";
...

// Local Variables:
// eval: (setq default-directory (concat (file-name-directory buffer-file-name) "..") compile-command (concat "scverif --il " buffer-file-name))
// End:
