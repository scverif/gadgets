/* Copyright 2020 - TU Darmstadt, NXP */
/* SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications */

include il "present/second_order/sbox_gadgets.il"

// helper register pointing to memory holding intermediate outputs between calculations
w32 rai1;
w32 rbi1;
w32 rci1;
w32 rdi1;
w32 rai2;
w32 rbi2;
w32 rci2;
w32 rdi2;

// helper register for in and output adresses
w32 rain;
w32 rbin;
w32 rcin;
w32 rdin;
w32 rao;
w32 rbo;
w32 rco;
w32 rdo;

macro present_sbox ()
{
  /* present_sbox with optimzed gadgets */

  calcB_opt(rain, rbin, rcin, rdin,
            rai1, rbi1, rci1, rdi1,
            r3);
  calcG_paraMult(rai1, rbi1, rci1, rdi1, rai2, rbi2, rci2, rdi2, r3);
  calcG_paraMult(rai2, rbi2, rci2, rdi2, rai1, rbi1, rci1, rdi1, r3);
  calcA_opt(rai1, rbi1, rci1, rdi1, rao, rbo, rco, rdo, r3);
}

macro present_sbox_plain ()
{
  /* present_sbox with standard (non-optimized) gadgets */
  calcB(rain, rbin, rcin, rdin, rai1, rbi1, rci1, rdi1, r3);
  calcG(rai1, rbi1, rci1, rdi1, rai2, rbi2, rci2, rdi2, r3);
  calcG(rai2, rbi2, rci2, rdi2, rai1, rbi1, rci1, rdi1, r3);
  calcA(rai1, rbi1, rci1, rdi1, rao, rbo, rco, rdo, r3);
}

annotate present_sbox
  region mem w32 a[0:2]
  region mem w32 b[0:2]
  region mem w32 c[0:2]
  region mem w32 d[0:2]
  region mem w32 ao[0:2]
  region mem w32 bo[0:2]
  region mem w32 co[0:2]
  region mem w32 do[0:2]
  region mem w32 ai1[0:2]
  region mem w32 bi1[0:2]
  region mem w32 ci1[0:2]
  region mem w32 di1[0:2]
  region mem w32 ai2[0:2]
  region mem w32 bi2[0:2]
  region mem w32 ci2[0:2]
  region mem w32 di2[0:2]
  region mem w32 rnd[0:26]
  init r3 [rnd 0]
  init rain [a 0]
  init rbin [b 0]
  init rcin [c 0]
  init rdin [d 0]
  init rao [ao 0]
  init rbo [bo 0]
  init rco [co 0]
  init rdo [do 0]
  init rai1 [ai1 0]
  init rbi1 [bi1 0]
  init rci1 [ci1 0]
  init rdi1 [di1 0]
  init rai2 [ai2 0]
  init rbi2 [bi2 0]
  init rci2 [ci2 0]
  init rdi2 [di2 0]
//  init a [w32 0x0000, w32 0x0000, w32 0x0000]
//  init b [w32 0x0000, w32 0x0000, w32 0x0000]
//  init c [w32 0x0000, w32 0x0000, w32 0x0000]
//  init d [w32 0x0000, w32 0x0000, w32 0x0000]
//  init rnd [w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000]
  input sharing a
  input sharing b
  input sharing c
  input sharing d
  input urandom rnd
  input public r0
  input public r3
  input public r4
  input public r5
  input public r6
  input public r7
  input public pub
  input public opA
  input public opB
  input public opR
  input public opW
  input public rain
  input public rbin
  input public rcin
  input public rdin
  input public rai1
  input public rbi1
  input public rci1
  input public rdi1
  input public rai2
  input public rbi2
  input public rci2
  input public rdi2
  input public rao
  input public rbo
  input public rco
  input public rdo
  output sharing ao
  output sharing bo
  output sharing co
  output sharing do
  /*helper variables to simulate mv of intermediate result values*/
  output sharing ai1
  output sharing bi1
  output sharing ci1
  output sharing di1
  output sharing ai2
  output sharing bi2
  output sharing ci2
  output sharing di2
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

annotate present_sbox_plain
  region mem w32 a[0:2]
  region mem w32 b[0:2]
  region mem w32 c[0:2]
  region mem w32 d[0:2]
  region mem w32 ao[0:2]
  region mem w32 bo[0:2]
  region mem w32 co[0:2]
  region mem w32 do[0:2]
  region mem w32 ai1[0:2]
  region mem w32 bi1[0:2]
  region mem w32 ci1[0:2]
  region mem w32 di1[0:2]
  region mem w32 ai2[0:2]
  region mem w32 bi2[0:2]
  region mem w32 ci2[0:2]
  region mem w32 di2[0:2]
  region mem w32 rnd[0:26]
  init r3 [rnd 0]
  init rain [a 0]
  init rbin [b 0]
  init rcin [c 0]
  init rdin [d 0]
  init rao [ao 0]
  init rbo [bo 0]
  init rco [co 0]
  init rdo [do 0]
  init rai1 [ai1 0]
  init rbi1 [bi1 0]
  init rci1 [ci1 0]
  init rdi1 [di1 0]
  init rai2 [ai2 0]
  init rbi2 [bi2 0]
  init rci2 [ci2 0]
  init rdi2 [di2 0]
//  init a [w32 0x0000, w32 0x0000, w32 0x0000]
//  init b [w32 0x0000, w32 0x0000, w32 0x0000]
//  init c [w32 0x0000, w32 0x0000, w32 0x0000]
//  init d [w32 0x0000, w32 0x0000, w32 0x0000]
//  init rnd [w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000, w32 0x0000]
  input sharing a
  input sharing b
  input sharing c
  input sharing d
  input urandom rnd
  input public r3
  input public r4
  input public r5
  input public r6
  input public r7
  input public pub
  input public opA
  input public opB
  input public opR
  input public opW
  input public rain
  input public rbin
  input public rcin
  input public rdin
  input public rai1
  input public rbi1
  input public rci1
  input public rdi1
  input public rai2
  input public rbi2
  input public rci2
  input public rdi2
  input public rao
  input public rbo
  input public rco
  input public rdo
  output sharing ao
  output sharing bo
  output sharing co
  output sharing do
  /*helper variables to simulate mv of intermediate result values*/
  output sharing ai1
  output sharing bi1
  output sharing ci1
  output sharing di1
  output sharing ai2
  output sharing bi2
  output sharing ci2
  output sharing di2
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
  target: present_sbox;

print:
  kind: macrodef
  target: present_sbox
  verbosity: 0;

partialeval:
  target: present_sbox;

print:
  kind: evaltrace
  target: present_sbox
  verbosity: 0;

infertaint:
  inputsAsPublic: false
  outputsAsPublic: true
  memoryAsPublicOut: true
  target: present_sbox;

print:
  kind: variables
  variables: "metric_*"
  target: present_sbox
  verbosity: 1;

print:
  kind: variables
  variables: [a, b, c, d, rnd, ao, bo, co, do]
  target: present_sbox
  verbosity: 1;

check:
  target: [present_sbox]
  kind: "Stateful NI";
...

// Local Variables:
// eval: (setq default-directory (concat (file-name-directory buffer-file-name) "../..") compile-command (concat "scverif --il " buffer-file-name))present_sbox
// End:
