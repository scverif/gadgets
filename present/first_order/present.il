// Copyright 2019-2020 - NXP, TU Darmstadt
// SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications

include il "present/first_order/sbox_gadgets.il"

/* present sbox composed of non-optimized first order gadgets */
macro present_plain()
  int i
{
  copy(r4, r3);
  r4 <- r4 +w32 (w32) 32;
  copy(r8, r3);       // keep copies of r3 and r4 around
  copy(r9, r4);

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

/* present sbox composed of optimized gadgets */
macro present_opt ()
  int i
{
  copy(r4, r3);
  r4 <- r4 +w32 (w32) 32;
  copy(r8, r3);       // keep copies of r3 and r4 around
  copy(r9, r4);

  calcB_opt(r2, r3, r0);
  copy(r3, r8);
  copy(r4, r9);

  calcG_paraMult(r3, r4, r0);
  copy(r3, r8);
  copy(r4, r9);

  calcG_paraMult(r4, r3, r0);
  copy(r3, r8);
  copy(r4, r9);

  calcA_opt(r3, r1, r0);
  copy(r3, r8);

  /* scrub memory holding intermediates */
  i <- 0;
  while (i <= 15) {
    store(pub, r3, i);
    i <- i + 1;
  }
}

annotate present_opt
  region mem w32 in[0:7]
  region mem w32 out[0:7]
  region mem w32 im[0:15]       // intermediates
  region mem w32 rnd[0:9]
  init r0 [rnd 0]
  init r1 [out 0]
  init r2 [in 0]
  init r3 [im 0]                // pointer to intermediate's memory
//  init in [w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000]
//  init rnd [w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000]
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
  input public r8
  input public r9
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

annotate present_plain
  region mem w32 in[0:7]
  region mem w32 out[0:7]
  region mem w32 im[0:15]       // intermediates
  region mem w32 rnd[0:6]
  init r0 [rnd 0]
  init r1 [out 0]
  init r2 [in 0]
  init r3 [im 0]                // pointer to intermediate's memory
//  init in [w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000]
//  init rnd [w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000]

// RANDOM VECTOR AS TEST
//  init in [w32 0xD84870A5, w32 0xFF10BAE1, w32 0x08E14400, w32 0xFF31B8AA, w32 0x412FE9D6, w32 0x783C5B5D, w32 0x56A7A53B, w32 0x1F6BB130]
//  init rnd [w32 0x99BE28FB, w32 0x6CA2C0E4, w32 0x62CAD584, w32 0x644ECF39, w32 0x1B0ACEA1, w32 0x73E75F86, w32 0x0B9602F0]
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
  input public r8
  input public r9
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
  target: [present_opt, present_plain];

print:
  kind: macrodef
  target: [present_opt, present_plain]
  verbosity: 0;

partialeval:
  target: [present_opt, present_plain];

infertaint:
  inputsAsPublic: false
  outputsAsPublic: true
  memoryAsPublicOut: true
  target: [present_opt, present_plain];

print:
  kind: maskverif
  target: [present_opt, present_plain]
  verbosity: 0;

print:
  kind: variables
  variables: "metric_*"
  target: [present_opt, present_plain]
  verbosity: 1;

print:
  kind: variables
  variables: ["in", "rnd", "out"]
  target: [present_opt, present_plain]
  verbosity: 1;

check:
  target: [present_opt, present_plain]
  kind: "Stateful NI";
...

// Local Variables:
// eval: (setq default-directory (concat (file-name-directory buffer-file-name) "../..") compile-command (concat "scverif --il " buffer-file-name))
// End:
