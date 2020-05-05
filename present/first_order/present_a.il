// Copyright 2019-2020 - NXP, TU Darmstadt
// SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications

include il "present/first_order/sbox_gadgets_a.il"

/* present composed of non-optimized first order gadgets */
macro present_plain()
  int i
{
  copy(r8, r1);
  copy(r1, sp);
  r1 <- r1 +w32 (w32) (2*4);
  copy (r9, r1);
  store(r2, sp, 0);
  store(r1, sp, 1);
  r1 <- r1 +w32 (w32) (8*4);
  copy(r10, r1);

  calcB();

  copy(r1, r10);
  copy(r2, r9);
  store(r2, sp, 0);
  store(r1, sp, 1);

  calcG();

  copy(r1, r9);
  copy(r2, r10);
  store(r2, sp, 0);
  store(r1, sp, 1);

  calcG();

  copy(r1, r8);
  copy(r2, r9);
  store(r1, sp, 1);
  store(r2, sp, 0);

  calcA();

  /* scrub memory holding intermediates */
  i <- 0;
  while (i <= 17) {
    store(pub, sp, i);
    i <- i + 1;
  }
}

/* present sbox composed of optimzed gadgets */
macro present_opt ()
  int i
{
  copy(r8, r1);                // save output pointer in r8

  /* calcB */
  copy(r1, sp);                // next call will write to stack
  sp <- sp +w32 (w32) (8*4);   // mark stack as used (programers do that)
  calcB_opt();                 // output := stack; input := input memory

  /* calcG */
  copy(r2, r1);                // next call will use stack as first input
  copy(r1, r8);                // next call will write to output memory
  calcG_paraMult();            // output := output memory; input := stack

  /* calcG */
  copy(r2, r8);                // next call will use output memory as input
  r1 <- sp -w32 (w32) (8*4);   // next call will write to stack
  calcG_paraMult();            // output := stack; input := output memory

  /* calcA */
  copy(r2, r1);                // next call will use stack as input
  copy(r1, r8);                // next call will write to output pointer
  calcA_opt();                 // output := output memory; input := stack

  /* scrub memory holding intermediates */
  i <- 0;
  while (i <= 7) {
    store(pub, r2, i);
    i <- i + 1;
  }

  copy(sp, r2);                // free stack
}

annotate present_plain
  region mem w32 in[0:7]
  region mem w32 out[0:7]
  region mem w32 stack[0:17]       // intermediates
  region mem w32 rnd[0:9]
  init r0 [rnd 0]
  init r1 [out 0]
  init r2 [in 0]
  init sp [stack 0]                // pointer to intermediate's memory
//  init in [w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000]
//  init rnd [w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000]
  input sharing a [in[0:1]]     // an input sharing named "a" is located in a given range of "in"
  input sharing b [in[2:3]]
  input sharing c [in[4:5]]
  input sharing d [in[6:7]]
//  input public im
  input urandom rnd
  output sharing oa [out[0:1]]  // an output sharing named "oa" is located in a given range of "out"
  output sharing ob [out[2:3]]
  output sharing oc [out[4:5]]
  output sharing od [out[6:7]]
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

annotate present_opt
  region mem w32 in[0:7]
  region mem w32 out[0:7]
  region mem w32 stack[0:7]       // intermediates
  region mem w32 rnd[0:6]
  init r0 [rnd 0]
  init r1 [out 0]
  init r2 [in 0]
  init sp [stack 0]                // pointer to intermediate's memory
//  init rnd [w32 0, w32 0, w32 0, w32 0, w32 0, w32 0, w32 0, w32 0, w32 0, w32 0]
//  init in [w32 0x0000, w32 0x0000, w32 0xFFFFFFFF, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0xFFFFFFFF]
//  init in [w32 0, w32 0, w32 0xFFFFFFFF, w32 0, w32 0, w32 0, w32 0, w32 0]




// DEBUG WITH REAL RANDOM VECTOR
//  init in [w32 0xD84870A5, w32 0xFF10BAE1, w32 0x08E14400, w32 0xFF31B8AA, w32 0x412FE9D6, w32 0x783C5B5D, w32 0x56A7A53B, w32 0x1F6BB130]
  // unshared in [2758CA44, F7D0FCAA, 3913B28B, 49CC140B]
  // unshared in bin [00100111010110001100101001000100,
                      11110111110100001111110010101010,
                      00111001000100111011001010001011,
                      01001001110011000001010000001011]
  init rnd [w32 0x99BE28FB, w32 0x6CA2C0E4, w32 0x62CAD584, w32 0x644ECF39, w32 0x1B0ACEA1, w32 0x73E75F86, w32 0x0B9602F0]
// concrete assembly returns out => {4153785012, 1866303755, 2276250768, 298028837, 3798101861, 3945353128, 3123514209, 41523458}

  // unshared out [98A833BF, 966F5BB5, 94B20CD, B8549263]
  // unshared out bin [10011000101010000011001110111111,
                       10010110011011110101101110110101,
                       00001001010010110010000011001101,
                       10111000010101001001001001100011]

  // correct out should be
                      [1,
                       0,
                       0,
                       1]

// non-optimized present returns out => {3862442163, 2114978568, 430297457, 533367403, 3813598575,
         4194682794, 3555528776, 2075755047}





  input sharing a [in[0:1]]     // an input sharing named "a" is located in a given range of "in"
  input sharing b [in[2:3]]
  input sharing c [in[4:5]]
  input sharing d [in[6:7]]
//  input public im
  input urandom rnd
  output sharing oa [out[0:1]]  // an output sharing named "oa" is located in a given range of "out"
  output sharing ob [out[2:3]]
  output sharing oc [out[4:5]]
  output sharing od [out[6:7]]
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
  variables: [in, rnd, out]
  target: [present_opt, present_plain]
  verbosity: 1;

check:
  target: [present_opt, present_plain]
  kind: "Stateful NI";
...

// Local Variables:
// eval: (setq default-directory (concat (file-name-directory buffer-file-name) "../..") compile-command (concat "scverif --il " buffer-file-name))
// End:
