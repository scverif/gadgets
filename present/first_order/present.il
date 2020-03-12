// Copyright 2019-2020 - NXP, TU Darmstadt
// SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications

include il "models/pseudoisa-clearings.il"
include il "present/first_order/sbox_gadgets.il"

macro present_plain()
  int i
{
  copy(r4, r3);
  r4 <- r4 +w32 (w32) 32;
  copy(r8, r3);       // keep copies of r3 and r4 around
  copy(r9, r4);

  /* compostion of non-optimized first order gadgets */
  calcB(r2, r3, r0);
  copy(r3, r8);
  copy(r4, r9);

  calcG(r3, r4, r0);
  copy(r3, r8);
  copy(r4, r9);

  calcG(r4, r3, r0);
  copy(r3, r8);
  copy(r4, r9);

  calcA(r3, r1, r0);
  copy(r3, r8);

  /* scrub memory holding intermediates */
  i <- 0;
  while (i <= 15) {
    store(pub, r3, i);
    i <- i + 1;
  }
}

macro present ()
  int i
{
  copy(r4, r3);
  r4 <- r4 +w32 (w32) 32;
  /* present with optimzed gadgets */
  calcB_opt     (r2, r3, r0);
  calcG_paraMult(r3, r4, r0);
  calcG_paraMult(r4, r3, r0);
  calcA_opt     (r3, r1, r0);

  /* scrub memory holding intermediates */
  i <- 0;
  while (i < 13) {
    store(pub, r3, i);
    i <- i + 1;
  }
}

annotate present
  region mem w32 in[0:7]
  region mem w32 out[0:7]
  region mem w32 im[0:15]       // intermediates
  region mem w32 rnd[0:9]
  init r0 [rnd 0]
  init r1 [out 0]
  init r2 [in 0]
  init r3 [im 0]                // pointer to intermediate's memory
  input sharing a [in[0:1]]     // an input sharing named "a" is located in a given range of "in"
  input sharing b [in[2:3]]
  input sharing c [in[4:5]]
  input sharing d [in[6:7]]
  input public im
  input urandom rnd
  output sharing oa [out[0:1]]  // an output sharing named "oa" is located in a given range of "out"
  output sharing ob [out[2:3]]
  output sharing oc [out[4:5]]
  output sharing od [out[6:7]]
  output public im
  input public pub
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
  target: [present];

print:
  kind: macrodef
  target: [present]
  verbosity: 0;

partialeval:
  target: [present];

rewriteformv:
  target: [present]
  inferinput: false
  inferoutput: true;

print:
  kind: maskverif
  target: [present]
  verbosity: 0;

print:
  kind: variables
  variables: "metric_*"
  target: [present]
  verbosity: 1;

check:
  target: [present]
  kind: "Stateful NI";
...

// Local Variables:
// eval: (setq default-directory (concat (file-name-directory buffer-file-name) "../..") compile-command (concat "scverif --il " buffer-file-name))
// End:
