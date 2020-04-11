/* Copyright 2020 - TU Darmstadt, NXP */
/* SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications */

include il "second_order/basic_gadgets.il"

macro calcG (w32 a_in, w32 b_in, w32 c_in, w32 d_in,
             w32 a_out, w32 b_out, w32 c_out, w32 d_out,
             w32 rnd_loc)
{
  secmult(b_in, d_in, rnd_loc, d_out);
  secmult(b_in, c_in, rnd_loc, a_out);
  secxor(a_out, a_in, a_out);

  /*calc a'*/
  secxor(a_out, d_out, a_out);

  /*calc d'*/
  secxor(c_in, d_out, d_out);

  /*calc b'*/
  secmult(a_in, b_in, rnd_loc, b_out);
  secxor(b_out, d_in, b_out);

  /*calc c'*/
  secstore(b_in, c_out);
}

macro calcB (w32 a_in, w32 b_in, w32 c_in, w32 d_in,
             w32 a_out, w32 b_out, w32 c_out, w32 d_out,
             w32 rnd_loc)
{
  secxor(b_in, d_in, d_out);
  secnot(d_out, d_out);
  secref(d_out, r3, d_out);
  secstore(c_in, c_out);
  secref(c_out, r3, c_out);
  secxor(b_in, c_in, b_out);
  secref(b_out, r3, b_out);
  secxor(a_in, b_in, a_out);
  secref(a_out, r3, a_out);
}

macro calcA (w32 a_in, w32 b_in, w32 c_in, w32 d_in,
             w32 a_out, w32 b_out, w32 c_out, w32 d_out,
             w32 rnd_loc)
{
  secxor(a_in, c_in, a_out);
  secnot(b_in, b_out);
  secstore(a_in, c_out);
  secxor(a_in, c_in, d_out);
  secxor(d_out, d_in, d_out);
  secnot(d_out, d_out);
}

macro calcB_opt (w32 rnd_loc)
{ 
  copy(r3,r2);
  r3 <- r3 +w32 (w32) (6*4);
  load(r4, r2, 3);
  load(r5, r3, 3);
  xor(r5, r4);
  xor(r5, (w32) 0xFFFFFFFF);
  load(r6, rnd_loc, 0);
  xor(r5,r6);
  r1 <- r1 +w32 (w32) (6*4);
  store(r5, r1, 3);
  r1 <- r1 -w32 (w32) (6*4);
  load(r6, r2, 0);
  xor(r6, r4);
  load(r5, rnd_loc, 2);
  xor(r6,r5);
  store(r6, r1, 0);

  load(r5, r3, 0);
  xor(r4, r5);
  load(r6,rnd_loc, 4);
  xor(r4, r6);
  store(r4, r1, 3);
  load(r6,rnd_loc, 6);
  xor(r5, r6);
  r1 <- r1 +w32 (w32) (6*4);
  store(r5, r1, 0);
scrub(r4);
scrub(r5);
scrub(r6);
clear(opA);
clear(opB);
clear(opR);
clear(opW);

  /*second share*/

  load(r4, r2, 4);
  load(r5, r3, 4);
  xor(r5, r4);
  load(r6,rnd_loc, 1);
  xor(r5, r6);
  store(r5, r1, 4);
r1 <- r1 -w32 (w32) (6*4);

  load(r6, r2, 1);
  xor(r6, r4);
  load(r5,rnd_loc, 3);
  xor(r6, r5);
  store(r6, r1, 1);

  load(r5, r3, 1);
  xor(r4, r5);
  load(r6,rnd_loc, 5);
  xor(r4, r6);
  store(r4, r1, 4);
  load(r6,rnd_loc, 7);
  xor(r5, r6);
r1 <- r1 +w32 (w32) (6*4);
  store(r5, r1, 1);

scrub(r4);
scrub(r5);
scrub(r6);
clear(opA);
clear(opB);
clear(opR);
clear(opW);

  /*third share*/

  load(r4, r2, 5);
  load(r5, r3, 5);
  xor(r5, r4);
scrub(r6);
  load(r6,rnd_loc, 0);
clear(opR);
  load(r7,rnd_loc, 1);
clear(opB);
  xor(r6, r7);
clear(opA);
clear(opB);
  xor(r5, r6);
  store(r5, r1, 5);
r1 <- r1 -w32 (w32) (6*4);
  load(r6, r2, 2);
  xor(r6, r4);
scrub(r5);
  load(r5,rnd_loc, 2);
clear(opR);
  load(r7,rnd_loc, 3);
clear(opB);
  xor(r5, r7);
clear(opA);
clear(opB);
  xor(r6, r5);
  store(r6, r1, 2);

  load(r5, r3, 2);
clear(opB);
  xor(r4, r5);
scrub(r6);
  load(r6,rnd_loc, 4);
clear(opR);
  load(r7,rnd_loc, 5);
clear(opB);
  xor(r6, r7);
clear(opA);
clear(opB);
  xor(r4, r6);
  store(r4, r1, 5);

scrub(r6);
  load(r6,rnd_loc, 6);
clear(opR);
  load(r7,rnd_loc, 7);
clear(opB);
  xor(r6, r7);
clear(opA);
clear(opB);
  xor(r5, r6);
r1 <- r1 +w32 (w32) (6*4);
  store(r5, r1, 2);
r1 <- r1 -w32 (w32) (6*4);

scrub(r4);
scrub(r5);
scrub(r6);
scrub(r7);
clear(opA);
clear(opB);
clear(opR);
clear(opW);

rnd_loc <- (rnd_loc +w32 (w32) (8 * 4));
}

macro calcA_opt (w32 rnd_loc)
{
  copy(r3,r2);
  r3 <- r3 +w32 (w32) (6*4);
  load(r4, r2, 0);
r1 <- r1 +w32 (w32) (6*4);
  store(r4,r1, 0);
r1 <- r1 -w32 (w32) (6*4);
  load(r5, r3, 0);
  xor(r5, r4);
  store(r5, r1, 0);

  xor(r5, (w32) 0xFFFFFFFF);
  load(r6, r3, 3);
  xor(r5, r6);
r1 <- r1 +w32 (w32) (6*4);
  store(r5, r1, 3);
r1 <- r1 -w32 (w32) (6*4);

  load(r5, r2, 3);
  xor(r5, (w32) 0xFFFFFFFF);
  store(r5, r1, 3);

  /*second share*/

  load(r5, r2, 1);
r1 <- r1 +w32 (w32) (6*4);
  store(r5,r1, 1);
r1 <- r1 -w32 (w32) (6*4);
clear(opB);
  load(r4, r3, 1);
clear(opB);
  xor(r4, r5);
  store(r4, r1, 1);

  load(r5, r3, 4);
  xor(r4, r5);
r1 <- r1 +w32 (w32) (6*4);
  store(r4, r1, 4);
r1 <- r1 -w32 (w32) (6*4);
  load(r5, r2, 4);
  store(r5, r1, 4);

  /*third share*/

  load(r5, r2, 2);
r1 <- r1 +w32 (w32) (6*4);
  store(r5,r1, 2);
r1 <- r1 -w32 (w32) (6*4);
clear(opB);
  load(r4, r3, 2);
clear(opB);
  xor(r4, r5);
  store(r4, r1, 2);

  load(r5, r3, 5);
  xor(r4, r5);
r1 <- r1 +w32 (w32) (6*4);
  store(r4, r1, 5);
r1 <- r1 -w32 (w32) (6*4);
  load(r5, r2, 5);
  store(r5, r1, 5);

scrub(r4);
scrub(r5);
scrub(r6);
scrub(r7);
clear(opA);
clear(opB);
clear(opR);
clear(opW);
}




macro calcG_paraMult (w32 rnd_loc)
{

  load(r4,r2, 3);
r2 <- r2 +w32 (w32) (6*4);
  load(r5,r2, 4);
  load(r6,r2, 1);
r2 <- r2 -w32 (w32) (6*4);
  load(r7,r2,1);

  and(r5,r4);
  and(r6,r4);
  and(r7,r4);

  xor(r6,r5);

  load(r3, rnd_loc, 0);
  xor(r5,r3);
  load(r3, rnd_loc, 3);
  xor(r6,r3);
  load(r3, rnd_loc, 6);
  xor(r7,r3);

  load(r3,r2,0);
  xor(r6,r3);
  and(r3,r4);
  xor(r7,r3);
r2 <- r2 +w32 (w32) (6*4);
  load(r3,r2, 0);
  xor(r5,r3);
  and(r3,r4);
  xor(r6,r3);

  load(r3,r2, 3);
r2 <- r2 -w32 (w32) (6*4);
  xor(r7, r3);
  and(r3,r4);
  xor(r5,r3);
  xor(r6,r3);

scrub(r3);
clear(opR);
  load(r3, rnd_loc, 1);
clear(opA);
clear(opB);
  xor(r5,r3);
  load(r3, rnd_loc, 4);
  xor(r6,r3);
  load(r3, rnd_loc, 7);
  xor(r7,r3);

  load(r3,r2,2);
  and(r3,r4);
  xor(r7,r3);
r2 <- r2 +w32 (w32) (6*4);
  load(r3,r2, 2);
  and(r3,r4);
  xor(r6,r3);

  load(r3,r2, 5);
r2 <- r2 -w32 (w32) (6*4);
  and(r3,r4);
  xor(r5,r3);
  xor(r6,r3);


store(r6, r1,0);
store(r7, r1, 3);
r1 <- r1 +w32 (w32) (6*4);
store(r4, r1, 0);
store(r5, r1, 3);
r1 <- r1 -w32 (w32) (6*4);
scrub(r3);
scrub(r5);
scrub(r6);
scrub(r4);
scrub(r7);

clear(opR);
clear(opW);
clear(opA);
clear(opB);


  load(r4,r2, 4);
r2 <- r2 +w32 (w32) (6*4);
  load(r5,r2, 5);
  load(r6,r2, 2);
r2 <- r2 -w32 (w32) (6*4);
  load(r7,r2,2);

  and(r5,r4);
  and(r6,r4);
  and(r7,r4);

  xor(r6,r5);

  load(r3, rnd_loc, 1);
  xor(r5,r3);
  load(r3, rnd_loc, 4);
  xor(r6,r3);
  load(r3, rnd_loc, 7);
  xor(r7,r3);

  load(r3,r2,1);
  xor(r6,r3);
  and(r3,r4);
  xor(r7,r3);
r2 <- r2 +w32 (w32) (6*4);
  load(r3,r2, 1);
  xor(r5,r3);
  and(r3,r4);
  xor(r6,r3);

  load(r3,r2, 4);
r2 <- r2 -w32 (w32) (6*4);
  xor(r7, r3);
  and(r3,r4);
  xor(r5,r3);
  xor(r6,r3);

scrub(r3);
clear(opR);
  load(r3, rnd_loc, 2);
clear(opB);
clear(opA);
  xor(r5,r3);
  load(r3, rnd_loc, 5);
  xor(r6,r3);
  load(r3, rnd_loc, 8);
  xor(r7,r3);

  load(r3,r2,0);
  and(r3,r4);
  xor(r7,r3);
r2 <- r2 +w32 (w32) (6*4);
  load(r3,r2, 0);
  and(r3,r4);
  xor(r6,r3);

  load(r3,r2, 3);
r2 <- r2 -w32 (w32) (6*4);
  and(r3,r4);
  xor(r5,r3);
  xor(r6,r3);

store(r6, r1,1);
store(r7, r1, 4);
r1 <- r1 +w32 (w32) (6*4);
store(r4, r1, 1);
store(r5, r1, 4);
r1 <- r1 -w32 (w32) (6*4);
scrub(r3);
scrub(r5);
scrub(r6);
scrub(r4);
scrub(r7);

clear(opR);
clear(opW);
clear(opA);
clear(opB);

  load(r4,r2, 5);
r2 <- r2 +w32 (w32) (6*4);
  load(r5,r2, 3);
  load(r6,r2, 0);
r2 <- r2 -w32 (w32) (6*4);
  load(r7,r2,0);

  and(r5,r4);
  and(r6,r4);
  and(r7,r4);

  xor(r6,r5);

  load(r3, rnd_loc, 2);
  xor(r5,r3);
  load(r3, rnd_loc, 5);
  xor(r6,r3);
  load(r3, rnd_loc, 8);
  xor(r7,r3);

  load(r3,r2,2);
  xor(r6,r3);
  and(r3,r4);
  xor(r7,r3);
r2 <- r2 +w32 (w32) (6*4);
  load(r3,r2, 2);
  xor(r5,r3);
  and(r3,r4);
  xor(r6,r3);

  load(r3,r2, 5);
r2 <- r2 -w32 (w32) (6*4);
  xor(r7, r3);
  and(r3,r4);
  xor(r5,r3);
  xor(r6,r3);

scrub(r3);
clear(opR);
  load(r3, rnd_loc, 0);
clear(opB);
clear(opA);
  xor(r5,r3);
  load(r3, rnd_loc, 3);
  xor(r6,r3);
  load(r3, rnd_loc, 6);
  xor(r7,r3);

  load(r3,r2,1);
  and(r3,r4);
  xor(r7,r3);
r2 <- r2 +w32 (w32) (6*4);
  load(r3,r2, 1);
  and(r3,r4);
  xor(r6,r3);

  load(r3,r2, 4);
r2 <- r2 -w32 (w32) (6*4);
  and(r3,r4);
  xor(r5,r3);
  xor(r6,r3);

store(r6, r1,2);
store(r7, r1, 5);
r1 <- r1 +w32 (w32) (6*4);
store(r4, r1, 2);
store(r5, r1, 5);
r1 <- r1 -w32 (w32) (6*4);
scrub(r3);
scrub(r5);
scrub(r6);
scrub(r4);
scrub(r7);

clear(opR);
clear(opW);
clear(opA);
clear(opB);

rnd_loc <- (rnd_loc +w32 (w32) (9 * 4));
}
