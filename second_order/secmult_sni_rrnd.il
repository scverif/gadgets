// Copyright 2020 - TU Darmstadt, NXP
// SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications

include il "models/pseudoisa-clearings.il"

/*
 * This gadget is a SNI-multiplication in the leakage-model defined by pseudoisa.il
 * It uses SNI-multiplication with 3 fresh random words and clearings
 * c0 = ((a0*b0+rnd0)+a0*b1)+a1*b0+rnd1
 * c1 = ((a1*b1+rnd1)+a1*b2)+a2*b1+rnd2
 * c2 = ((a2*b2+rnd2)+a2*b0)+a0*b2+rnd0
*/

macro secmult ()
{
  load(r5, r1, 0);      /*a0 is loaded into register r5*/
  load(r4, r2, 0);      /*b0 is loaded into register r4*/
  and(r4, r5);          /*in r4 the result b0*a0 is stored*/
  load(r6, r3, 0);        /*rnd0 is loaded into register r6*/
  xor(r6, r4);           /*in register r6 the result rnd0+b0*a0 is stored*/
clear(opB);            /*This clearing is needed to remove b0*a0 from opB otherwise (Load Operand) would leak*/
  load(r7, r2, 1);      /*In register r7 b1 is loaded and a0 still is in register r5*/
  and(r7, r5);          /*in r7 the result b1*a0 is stored*/
  xor(r6, r7);           /*in register r6 the result rnd0+b0*a0+b1*a0 is stored*/

/* To load a1 into register r4 register r4 needs to be cleared by loading a public value into it*/
load_pub(r4);           /*Load Transition*/
  load(r4, r1, 1);      /*a1 is loaded to register r4*/
  load(r5, r2, 0);      /*b0 is loaded to register r5*/
clear(opB);
  and(r4, r5);          /*in register r4 the result a1*b0 is stored*/
  xor(r6, r4);           /*in register r6 the result rnd0+b0*a0+b1*a0+a1*b0 is stored*/

/* To achieve SNI security the randomness is not allowed to be leaked with much other values therefore the following clearings are needed*/
clear(opA);            /*Xor Oparand A*/
load_pub(r5);           /*Load Transition*/
  load(r5, r3, 1);      /*rnd1 is loaded into register r5*/
  xor(r6, r5);          /*in register r6 the result rnd0+b0*a0+b1*a0+a1*b0+rnd1 is stored*/
  store(r6, r0, 0);     /*The first outputvalue c0 = rnd0+b0*a0+b1*a0+a1*b0+rnd1 is stored to memory*/

/*After the calculation of the first output-share these clearings are used to reset the hardware to make the calculation of the output-shares independent*/
clear(opW);            /*opW needs to be cleared because of StoreTranistion-Leakages*/
load_pub(r4);           /*Register r4, r5 and r7 need to be cleared*/
load_pub(r5);
load_pub(r7);
  load(r5, r1, 1);      /*a1 is loaded into register r5*/
  load(r4, r2, 1);      /*b1 is loaded into register r4*/
  and(r4, r5);          /*in r4 the result b1*a1 is stored*/
  load(r6, r3, 1);      /*rnd1 is loaded into register r6*/
  xor(r6, r4);          /*in register r6 the result rnd1+b1*a1 is stored*/
clear(opB);            /*This clearing is needed to remove b1*a1 from opB otherwise (Load Operand) would leak*/
  load(r7, r2, 2);      /*In register r7 b2 is loaded and a1 still is in register r5*/
  and(r7, r5);          /*in r7 the result b2*a1 is stored*/
  xor(r6, r7);          /*in register r6 the result rnd1+b1*a1+b2*a1 is stored*/

/*To load a2 into register r4 register r4 needs to be cleared by loading a public value into it*/
load_pub(r4);           /*Load Transition*/
  load(r4, r1, 2);      /*a2 is loaded to register r4*/
  load(r5, r2, 1);      /*b1 is loaded to register r5*/

clear(opB);            /*load opA*/
  and(r4, r5);          /*in register r4 the result a2*b1 is stored*/
  xor(r6, r4);          /*in register r6 the result rnd1+b1*a1+b2*a1+a2*b1 is stored*/

/*To achieve SNI security the randomness is not allowed to be leaked with much other values therefore the following clearings are needed*/
clear(opA);            /*Xor Oparand A*/
load_pub(r5);           /*Load Transition*/
  load(r5, r3, 2);      /*rnd2 is loaded into register r5*/
  xor(r6, r5);          /*in regsister r6 the result rnd1+b1*a1+b2*a1+a2*b1+rnd2 is stored*/
  store(r6, r0, 1);     /*The second outputvalue c1 = rnd1+b1*a1+b2*a1+a2*b1+rnd2 is stored to memory*/

/*After the calculation of the second output-share these clearings are used to reset the hardware to make the calculation of the output-shares independent*/
clear(opW);            /*opW needs to be cleared because of StoreTranistion-Leakages*/
load_pub(r4);           /*Register r4, r5 and r7 need to be cleared*/
load_pub(r5);
load_pub(r7);
  load(r5, r1, 2);      /*a2 is loaded into register r5*/
  load(r4, r2, 2);      /*b2 is loaded into register r4*/
  and(r4, r5);          /*in r4 the result b2*a2 is stored*/
  load(r6, r3, 2);      /*rnd2 is loaded into register r6*/
  xor(r6, r4);          /*in register r6 the result rnd2+b2*a2 is stored*/
clear(opB);            /*This clearing is needed to remove b2*a2 from opB otherwise (Load Operand) would leak*/
  load(r7, r2, 0);      /*In register r7 b0 is loaded and a1 still is in register r5*/
  and(r7, r5);          /*in r7 the result b0*a2 is stored*/
  xor(r6, r7);          /*in register r6 the result rnd2+b2*a2+b0*a2 is stored*/

/*To load a0 into register r4 register r4 needs to be cleared by loading a public value into it*/
load_pub(r4);           /*Load Transition*/
  load(r4, r1, 0);      /*a0 is loaded to register r4*/
  load(r5, r2, 2);      /*b2 is loaded to register r5*/
clear(opB);            /*load opA*/
  and(r4, r5);          /*in register r4 the result a0*b2 is stored*/
  xor(r6, r4);          /*in register r6 the result rnd2+b2*a2+b0*a2+a0*b2 is stored*/

/*To achieve SNI security the randomness is not allowed to be leaked with much other values therefore the following clearings are needed*/
clear(opA);            /*Xor Oparand A*/
load_pub(r5);           /*Load Transition*/
  load(r5, r3, 0);      /*rnd0 is loaded into register r5*/
  xor(r6, r5);          /*in regsister r6 the result rnd2+b2*a2+b0*a2+a0*b2+rnd0 is stored*/
  store(r6, r0, 2);     /*The third outptvalue c3 = rnd2+b2*a2+b0*a2+a0*b2+rnd0 is stored to memory*/

load_pub(r4);
load_pub(r5);
load_pub(r6);
load_pub(r7);
clear(opA);
clear(opB);
clear(opR);
clear(opW);
}


annotate secmult
  region mem w32 a[0:2]
  region mem w32 b[0:2]
  region mem w32 c[0:2]
  region mem w32 rnd[0:2]
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
verbosity:
  verbosity: 1;

print:
  kind: macrodef
  target: load
  verbosity: 0;

/* put all leakages of a macro in a single leak statement at the beginning.
accumulate:
  target: [load,store,xor,and]
  leaks: any
  keep: false; // remove the old leakages
*/

print:
  kind: macrodef
  target: load
  verbosity: 0;

addleakage:
  target: secmult;

inlinecall:
  target: secmult;

print:
  kind: macrodef
  target: secmult
  verbosity: 0;

partialeval:
  target: secmult;

infertaint:
  inputsAsPublic: false
  outputsAsPublic: true
  memoryAsPublicOut: true
  target: secmult;

print:
  kind: evaltrace
  target: secmult
  verbosity: 0;

print:
  kind: variables
  variables: "metric_*"
  target: secmult
  verbosity: 1;

check:
  target: secmult
  kind: "Stateful SNI";
...

// Local Variables:
// eval: (setq default-directory (concat (file-name-directory buffer-file-name) "..") compile-command (concat "scverif --il " buffer-file-name))
// End:
