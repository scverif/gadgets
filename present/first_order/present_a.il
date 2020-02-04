// Copyright 2019-2020 - NXP, TU Darmstadt

include il "models/pseudoisa.il"
include il "present/first_order/sbox_gadgets_a.il"

w32 r8;
w32 r9;
w32 r10;
w32 sp;

macro present_plain()
  int i
{
  copy(r8,r1);
  copy(r1,sp);
  r1 <- r1 + w32 (w32) (2*4); 
  copy (r9, r1);
  store(r2,sp,0);
  store(r1,sp,1);
  r1 <- r1 + w32 (w32) (8*4);
  copy(r10, r1);

  /* compostion of non-optimized first order gadgets */
  calcB(r2, r1, r0, sp);
  
  copy(r1,r10);
  copy(r2,r9);
  store(r2,sp,0);
  store(r1,sp,1);

  calcG(r2, r1, r0, sp);

  copy(r1,r9);
  copy(r2,r10);
  store(r2,sp,0);
  store(r1,sp,1);

  calcG(r2, r1, r0, sp);

  copy(r1,r8);
  copy(r2,r9);
  store(r1,sp,1);
  store(r2,sp,0);

  calcA(r2, r1, r0, sp);

  /* scrub memory holding intermediates */
  i <- 0;
  while (i <= 17) {
    store(pub, sp, i);
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
  calcG_paraMult(r3, r3, r0, 0);
  calcG_paraMult(r3, r3, r0, 1);
  calcA_opt     (r3, r1, r0);

  /* scrub memory holding intermediates */
  i <- 0;
  while (i < 16) {
    store(pub, r3, i);
    i <- i + 1;
  }
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
  ;

---
inlinecall:
  target: [present_plain];

print:
  kind: macrodef
  target: [present_plain]
  verbosity: 0;

partialeval:
  target: [present_plain];

rewriteformv:
  target: [present_plain]
  inferinput: false
  inferoutput: true;

print:
  kind: maskverif
  target: [present_plain]
  verbosity: 0;

check:
  target: [present_plain]
  kind: "Stateful NI";
...

// Local Variables:
// eval: (setq default-directory (concat (file-name-directory buffer-file-name) "../..") compile-command (concat "scverif --il " buffer-file-name))
// End: