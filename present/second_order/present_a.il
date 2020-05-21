/* Copyright 2020 - TU Darmstadt, NXP */
/* SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications */

include il "present/second_order/sbox_gadgets_a.il"

macro present_opt ()
  int i
{
  /* present_sbox with optimzed gadgets */
  copy(r8, r1);
  copy(r1, sp);
  copy(r9, sp);
  r1 <- r1 +w32 (w32) (4 * 3 * 4);
  copy(r10, r1);
  copy(r1, sp);
  calcB_opt(r0);
  copy(r2, r9);
  copy(r1, r10);
  calcG_paraMult(r0);
  copy(r2, r10);
  copy(r1, r9);
  calcG_paraMult(r0);
  copy(r2, r9);
  copy(r1, r8);
  calcA_opt(r0);

  /* scrub memory holding intermediates */
  i <- 0;
  while (i <= 23) {
    store(pub, sp, i);
    i <- i + 1;
  }
}

annotate present_opt
  region mem w32 in[0:11]
  region mem w32 out[0:11]
  region mem w32 stack[0:23]       // intermediates
  region mem w32 rnd[0:25]
  init r0 [rnd 0]
  init r1 [out 0]
  init r2 [in 0]
  init sp [stack 0]                // pointer to intermediate's memory
/*
init in  [w32 0xD84870A5, w32 0xFF10BAE1, w32 0x00000000,
          w32 0x08E14400, w32 0xFF31B8AA, w32 0x00000000,
          w32 0x412FE9D6, w32 0x783C5B5D, w32 0x00000000,
          w32 0x56A7A53B, w32 0x1F6BB130, w32 0x00000000]
init rnd [w32 0xD84870A5, w32 0xFF10BAE1, w32 0x08E14400,
          w32 0xFF31B8AA, w32 0x412FE9D6, w32 0x783C5B5D,
          w32 0x56A7A53B, w32 0x1F6BB130, w32 0x1F6BB130,
          w32 0xD84870A5, w32 0xFF10BAE1, w32 0x08E14400,
          w32 0xFF31B8AA, w32 0x412FE9D6, w32 0x783C5B5D,
          w32 0x56A7A53B, w32 0x1F6BB130, w32 0x1F6BB130,
          w32 0xD84870A5, w32 0xFF10BAE1, w32 0x08E14400,
          w32 0xFF31B8AA, w32 0x412FE9D6, w32 0x783C5B5D,
          w32 0x56A7A53B, w32 0x1F6BB130]
*/
  input sharing a [in[0:2]]     // an input sharing named "a" is located in a given range of "in"
  input sharing b [in[3:5]]
  input sharing c [in[6:8]]
  input sharing d [in[9:11]]
  input urandom rnd
  output sharing oa [out[0:2]]  // an output sharing named "oa" is located in a given range of "out"
  output sharing ob [out[3:5]]
  output sharing oc [out[6:8]]
  output sharing od [out[9:11]]
  input public stack
  input public sp
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
  input public r10
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
  target: [present_opt];

print:
  kind: macrodef
  target: [present_opt]
  verbosity: 0;

partialeval:
  target: [present_opt];

infertaint:
  inputsAsPublic: false
  outputsAsPublic: true
  memoryAsPublicOut: true
  target: [present_opt];

print:
  kind: maskverif
  target: [present_opt]
  verbosity: 0;

print:
  kind: variables
  variables: "metric_*"
  target: [present_opt]
  verbosity: 1;

print:
  kind: variables
  variables: [in, rnd, out, r0, stack]
  target: [present_opt]
  verbosity: 1;

check:
  target: [present_opt]
  kind: "Stateful NI";
...

// Local Variables:
// eval: (setq default-directory (concat (file-name-directory buffer-file-name) "../..") compile-command (concat "scverif --il " buffer-file-name))
// End:
