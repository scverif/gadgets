/* Copyright 2020 - TU Darmstadt, NXP */
/* SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications */

include il "first_order/basic_gadgets_a.il"

macro calcG ()
{
  load(r2, sp, 0);
  load(r3, sp, 0);
  load(r1, sp, 1);
  r2 <- r2 +w32 (w32) (2*4);
  r3 <- r3 +w32 (w32) (6*4);
  r1 <- r1 +w32 (w32) (6*4);
  firstmult();

  r3 <- r3 -w32 (w32) (2*4);
  r1 <- r1 -w32 (w32) (6*4);
  firstmult();

  copy(r2, r1);
  r3 <- r3 -w32 (w32) (4*4);
  firstxor();

  /*calc a'*/
  copy(r3, r1);
  r3 <- r3 +w32 (w32) (6*4);
  firstxor();

  /*calc d'*/
  copy(r1, r3);
  load(r2, sp, 0);
  r2 <- r2 +w32 (w32) (4*4);
  firstxor();

  /*calc b'*/
  copy(r3, r2);
  r3 <- r3 -w32 (w32) (2*4);
  r2 <- r2 -w32 (w32) (4*4);
  r1 <- r1 -w32 (w32) (4*4);
  firstmult();

  copy(r2, r1);
  r3 <- r3 +w32 (w32) (4*4);
  firstxor();

  /*calc c'*/
  r3 <- r3 -w32 (w32) (4*4);
  r1 <- r1 +w32 (w32) (2*4);
  firststore();
}

macro calcB ()
{
  load(r2, sp, 0);
  load(r3, sp, 0);
  load(r1, sp, 1);

  r2 <- r2 +w32 (w32) (2*4);
  r3 <- r3 +w32 (w32) (6*4);
  r1 <- r1 +w32 (w32) (6*4);
  firstxor();

  copy(r3, r1);
  firstxorone();

  copy(r3, r2);
  r3 <- r3 +w32 (w32) (2*4);
  r1 <- r1 -w32 (w32) (2*4);
  firststore();

  r1 <- r1 -w32 (w32) (2*4);
  firstxor();

  copy(r3, r1);
  firstref();

  copy(r3, r2);
  r2 <- r2 -w32 (w32) (2*4);
  r1 <- r1 -w32 (w32) (2*4);
  firstxor();

}

macro calcA ()
{
  load(r2, sp, 0);
  load(r3, sp, 0);
  load(r1, sp, 1);

  r3 <- r3 +w32 (w32) (4*4);
  firstxor();

  r3 <- r3 -w32 (w32) (2*4);
  r1 <- r1 +w32 (w32) (2*4);
  firstxorone();

  r3 <- r3 -w32 (w32) (2*4);
  r1 <- r1 +w32 (w32) (2*4);
  firststore();

  r3 <- r3 +w32 (w32) (4*4);
  r1 <- r1 +w32 (w32) (2*4);
  firstxor();

  copy(r2, r1);
  r3 <- r3 +w32 (w32) (2*4);
  firstxor();

  copy(r3, r1);
  firstxorone();
}

//r2 -> [a0, a1, b0, b1, c0, c1, d0, d1]
macro calcG_paraMult (w32 in, w32 out, w32 rnd_loc, w32 sp)
{

  load(r4, r2, 2);
  load(r6, r2, 4);
  and(r6, r4);          /*r6 = c1b0*/
  load(r5, r2, 6);
  and(r5, r4);          /*r5 = d0b0*/

  xor(r6, r5);          /*r6 = c1b0 + d0b0*/

  load(r7, r0, 0);
  xor(r6, r7);          /*r6 = c1b0 + d0b0 + rnd0*/

  load(r7, r0, 1 );
  xor(r5, r7);          /*r5 = d0b0 + rnd1*/

r2 <-r2 -w32 (w32)8;
  load(r7, r2, 0);
  xor(r5, r7);          /*r5 = d0b0 +rnd1 + c0*/

  and(r7, r4);          /*r7 = c0b0*/

  xor(r6, r7);          /*r6 = c1b0 + d0b0 + rnd0 + c0b0*/
r2 <-r2 +w32 (w32)8;
  load(r7, r2, 1);
  and(r7, r4);          /*r7 = d1b0*/
r1 <-r1 +w32 (w32)24;
  xor(r5, r7);          /*r5 = d0b0 + rnd1 + c0 + d1b0*/
  store(r5, r1, 0);

  clear_opR();
r2 <-r2 -w32 (w32)24;
  load(r5, r1, 0);
  xor(r6, r5);          /*r6 = c1b0 + d0b0 + rnd0 + c0b0 + a0*/

  and(r5, r4);          /*r5 = a0b0*/
  clear_opA();
  xor(r6, r7);          /*r6 = c1b0 + d0b0 + rnd0 + c0b0 + a0 + d1b0*/
r1 <-r1 -w32 (w32)24;
  store(r6, r1, 0);
r2 <-r2 +w32 (w32)24;
  load(r6, r2, 0);
  //clear_opA();
  clear_opB();
  xor(r5, r6);          /*r5 = a0b0 + d0*/
r1 <-r1 +w32 (w32)16;
  store(r4, r1, 0);

clear_opR();
r2 <-r2 -w32 (w32)24;
  load(r7, r2, 1);
  and(r4, r7);          /*r4 = b0a1*/

  load(r7, r0, 2);

clear_opB();
  xor(r5, r7);          /*r4 = b0a1 +rnd2*/
clear_opB();
clear_opA();

  xor(r5, r4);          /*r5 = a0b0 + d0 +b0a1 + rnd2*/
r1 <-r1 -w32 (w32)8;
  store(r5, r1, 0);

/*second output share*/
clear_opB();
r2 <-r2 +w32 (w32)8;
  load(r7, r2, 1);
clear_opB();
r2 <-r2 +w32 (w32)8;
  load(r5, r2, 0);
  and(r5, r7);          /*r5 = c0b1*/

  and(r6, r7);          /*r5 = d0b1*/

/*-----------------------------------------*/

  xor(r5, r6);          /*r5 = c0b1 + d0b1*/
clear_opB();
  load(r4, r0, 0);
  clear_opB();

  xor(r5, r4);          /*r5 = c0b1 + d0b1 + rnd0*/


  load(r4, r0, 1);
  xor(r6, r4);          /*r6 = d0b1 + rnd1*/

  load(r4, r2, 1);
  xor(r6, r4);          /*r5 = d0b1 +rnd1 + c1*/

  and(r4, r7);          /*r4 = c1b1*/

  xor(r5, r4);          /*r5 = c0b1 + d0b1 + rnd0 + c1b1*/
r2 <-r2 +w32 (w32)8;
  load(r4, r2, 1);
  and(r4, r7);          /*r4 = d0b1*/
r1 <-r1 +w32 (w32)16;
  xor(r6, r4);          /*r6 = d0b1 + rnd1 + c1 + d1b1*/
  store(r6, r1, 1);
r2 <-r2 -w32 (w32)24;
  load(r6, r2, 1);
  xor(r5, r6);          /*r5 = c0b1 + d0b1 + rnd0 + c1b1 + a1*/

  and(r6, r7);          /*r6 = a1b1*/
  clear_opA();

  xor(r5, r4);          /*r5 = c0b1 + d0b1 + rnd0 + c1b1 + a1 + d1b1*/
r1 <-r1 -w32 (w32)24;
  store(r5, r1, 1);
r2 <-r2 +w32 (w32)24;
  load(r5, r2, 1);
  //clear_opA();
  clear_opB();
  xor(r6, r5);          /*r5 = a1b1 + d1*/
r1 <-r1 +w32 (w32)16;
  store(r7, r1, 1);

scrub(r4);
clear_opR();
r2 <-r2 -w32 (w32)24;
  load(r4, r2, 0);
clear_opB();
  and(r7, r4);          /*r4 = b1a0*/

  load(r4, r0, 2);

clear_opB();
  xor(r6, r4);          /*r4 = b1a0 +rnd2*/
clear_opB();
clear_opA();

  xor(r5, r4);          /*r6 = a1b1 + d1 +b1a0 + rnd2*/
r1 <-r1 -w32 (w32)8;
  store(r5, r1, 1);

scrub(r5);
scrub(r6);
scrub(r4);
scrub(r7);

clear_opR();
clear_opW();
clear_opA();
clear_opB();

rnd_loc <- (rnd_loc +w32 (w32) (3 * 4));
}

macro calcB_opt (w32 in, w32 out, w32 rnd_loc, w32 sp)
{
  r2 <- r2 +w32 (w32) 8;
  load(r4, r2, 0);
  r2 <- r2 +w32 (w32) 16;
  load(r5, r2, 0);
  xor(r5, r4);
  xor(r5, (w32) 0xFFFFFFFF);
  r1 <- r1 +w32 (w32) 24;
  store(r5, r1, 0);
  r2 <- r2 -w32 (w32) 24;
  load(r6, r2, 0);
  xor(r6, r4);
  r1 <- r1 -w32 (w32) 24;
  store(r6, r1, 0);

  r2 <- r2 +w32 (w32) 16;
  load(r5, r2, 0);
  xor(r4, r5);
  load(r6,rnd_loc, 0);
  xor(r4, r6);
  r1 <- r1 +w32 (w32)8;
  store(r4, r1, 0);
  r1 <- r1 +w32 (w32) 8;
  store(r5, r1, 0);

  /*second share*/
  r2 <- r2 -w32 (w32) 8;
  load(r4, r2, 1);
  r2 <- r2 +w32 (w32) 16;
  load(r5, r2, 1);
  xor(r5, r4);
  r1 <- r1 +w32 (w32) 8;
  store(r5, r1, 1);
  r2 <- r2 -w32 (w32) 24;
  load(r6, r2, 1);
  xor(r6, r4);
  r1 <- r1 -w32 (w32) -24;
  store(r6, r1, 1);
  r2 <- r2 +w32 (w32) 16;
  load(r5, r2, 1);
  xor(r4, r5);
  load(r6,rnd_loc, 0);
  xor(r4, r6);
  r1 <- r1 +w32 (w32) 8;
  store(r4, r1, 1);
  r1 <- r1 +w32 (w32) 8;
  store(r5, r1, 1);

scrub(r4);
scrub(r5);
scrub(r6);
clear_opA();
clear_opB();
clear_opR();
clear_opW();

rnd_loc <- (rnd_loc +w32 (w32) (1 * 4));
}

macro calcA_opt (w32 in, w32 out, w32 rnd_loc, w32 sp)
{
  load(r4, r2, 0);
  r1 <- r1 +w32 (w32) 16;
  store(r4, r1, 0);
  r2 <- r2 +w32 (w32) 16;
  load(r5, r2, 0);
  xor(r5, r4);
  r1 <- r1 -w32 (w32) 16;
  store(r5, r1, 0);

  xor(r5, (w32) 0xFFFFFFFF);
  r2 <- r2 +w32 (w32) 8;
  load(r6, r2, 0);
  xor(r5, r6);
  r1 <- r1 +w32 (w32) 24;
  store(r5, r1, 0);

  r2 <- r2 -w32 (w32) 8;
  load(r5, r2, 0);
  xor(r5, (w32) 0xFFFFFFFF);

  r1 <- r1 -w32 (w32) 16;
  store(r5, r1, 0);

  /*second share*/

  r2 <- r2 -w32 (w32) 8;
  load(r5, r2, 1);
  r1 <- r1 +w32 (w32) 8;
  store(r5, r1, 1);
clear_opB();
  r2 <- r2 +w32 (w32) 16;
  load(r4, r2, 1);
  xor(r4, r4);
  r1 <- r1 -w32 (w32) 16;
  store(r4, r1, 1);

  r2 <- r2 +w32 (w32) 8;
  load(r5, r2, 1);
  xor(r4, r5);
  r1 <- r1 +w32 (w32) 24;
  store(r4, r1, 1);

  r2 <- r2 -w32 (w32) 16;
  load(r5, r2, 1);
  r1 <- r1 -w32 (w32) 16;
  store(r5, r1, 1);

scrub(r4);
scrub(r5);
scrub(r6);
clear_opA();
clear_opB();
clear_opR();
clear_opW();
}
