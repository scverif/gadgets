/* Copyright 2020 - TU Darmstadt, NXP */
/* SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications */

include il "first_order/basic_gadgets.il"

macro calcG (w32 in, w32 out, w32 rnd_loc)
  w32 a_in, w32 b_in, w32 c_in, w32 d_in, w32 a_out, w32 b_out, w32 c_out, w32 d_out
{
  a_in <- in;
  b_in <- in +w32 (w32) 8;
  c_in <- in +w32 (w32) 16;
  d_in <- in +w32 (w32) 24;

  a_out <- out;
  b_out <- out +w32 (w32) 8;
  c_out <- out +w32 (w32) 16;
  d_out <- out +w32 (w32) 24;

  firstmult(b_in, d_in, rnd_loc, d_out);
  firstmult(b_in, c_in, rnd_loc, a_out);
  firstxor(a_out, a_in, a_out);

  /*calc a'*/
  firstxor(a_out, d_out, a_out);

  /*calc d'*/
  firstxor(c_in, d_out, d_out);

  /*calc b'*/
  firstmult(a_in, b_in, rnd_loc, b_out);

  firstxor(b_out, d_in, b_out);

  /*calc c'*/
  firststore(b_in, c_out);
}

macro calcB (w32 in, w32 out, w32 rnd_loc)
  w32 a_in, w32 b_in, w32 c_in, w32 d_in, w32 a_out, w32 b_out, w32 c_out, w32 d_out
{
  a_in <- in;
  b_in <- in +w32 (w32) 8;
  c_in <- in +w32 (w32) 16;
  d_in <- in +w32 (w32) 24;

  a_out <- out;
  b_out <- out +w32 (w32) 8;
  c_out <- out +w32 (w32) 16;
  d_out <- out +w32 (w32) 24;

  firstxor(b_in, d_in, d_out);
  firstxorone(d_out, d_out);
  firststore(c_in, c_out);
  firstxor(b_in, c_in, b_out);
  firstref(b_out, rnd_loc, b_out);
  firstxor(a_in, b_in, a_out);

}

macro calcA (w32 in, w32 out, w32 rnd_loc)
  w32 a_in, w32 b_in, w32 c_in, w32 d_in, w32 a_out, w32 b_out, w32 c_out, w32 d_out
{
  a_in <- in;
  b_in <- in +w32 (w32) 8;
  c_in <- in +w32 (w32) 16;
  d_in <- in +w32 (w32) 24;

  a_out <- out;
  b_out <- out +w32 (w32) 8;
  c_out <- out +w32 (w32) 16;
  d_out <- out +w32 (w32) 24;

  firstxor(a_in, c_in, a_out);
  firstxorone(b_in, b_out);
  firststore(a_in, c_out);
  firstxor(a_in, c_in, d_out);
  firstxor(d_out, d_in, d_out);
  firstxorone(d_out, d_out);
}

macro calcG_paraMult (w32 in, w32 out, w32 rnd_loc)
  w32 a_in, w32 b_in, w32 c_in, w32 d_in, w32 a_out, w32 b_out, w32 c_out, w32 d_out
{
  a_in <- in;
  b_in <- in +w32 (w32) 8;
  c_in <- in +w32 (w32) 16;
  d_in <- in +w32 (w32) 24;

  a_out <- out;
  b_out <- out +w32 (w32) 8;
  c_out <- out +w32 (w32) 16;
  d_out <- out +w32 (w32) 24;

  load(r4, b_in, 0);
  load(r6, c_in, 1);
  and(r6, r4);          /*r6 = c1b0*/

  load(r5, d_in, 0);
  and(r5, r4);          /*r5 = d0b0*/

  xor(r6, r5);          /*r6 = c1b0 + d0b0*/

  load(r7, rnd_loc, 0);
  xor(r6, r7);          /*r6 = c1b0 + d0b0 + rnd0*/

  load(r7, rnd_loc, 1 );
  xor(r5, r7);          /*r5 = d0b0 + rnd1*/

  load(r7, c_in, 0);
  xor(r5, r7);          /*r5 = d0b0 +rnd1 + c0*/

  and(r7, r4);          /*r7 = c0b0*/

  xor(r6, r7);          /*r6 = c1b0 + d0b0 + rnd0 + c0b0*/

  load(r7, d_in, 1);
  and(r7, r4);          /*r7 = d1b0*/

  xor(r5, r7);          /*r5 = d0b0 + rnd1 + c0 + d1b0*/
  store(r5, d_out, 0);

  clear(opR);
  load(r5, a_in, 0);
  xor(r6, r5);          /*r6 = c1b0 + d0b0 + rnd0 + c0b0 + a0*/

  and(r5, r4);          /*r5 = a0b0*/
  clear(opA);
  xor(r6, r7);          /*r6 = c1b0 + d0b0 + rnd0 + c0b0 + a0 + d1b0*/
  store(r6, a_out, 0);

  load(r6, d_in, 0);
  //clear(opA);
  clear(opB);
  xor(r5, r6);          /*r5 = a0b0 + d0*/

  store(r4, c_out, 0);

clear(opR);
  load(r7, a_in, 1);
  and(r4, r7);          /*r4 = b0a1*/

  load(r7, rnd_loc, 2);

clear(opB);
  xor(r5, r7);          /*r4 = b0a1 +rnd2*/
clear(opB);
clear(opA);

  xor(r5, r4);          /*r5 = a0b0 + d0 +b0a1 + rnd2*/
  store(r5, b_out, 0);

/*second output share*/
clear(opB);
  load(r7, b_in, 1);
clear(opB);
  load(r5, c_in, 0);
  and(r5, r7);          /*r5 = c0b1*/

  and(r6, r7);          /*r5 = d0b1*/

/*-----------------------------------------*/

  xor(r5, r6);          /*r5 = c0b1 + d0b1*/
clear(opB);
  load(r4, rnd_loc, 0);
  clear(opB);

  xor(r5, r4);          /*r5 = c0b1 + d0b1 + rnd0*/


  load(r4, rnd_loc, 1);
  xor(r6, r4);          /*r6 = d0b1 + rnd1*/

  load(r4, c_in, 1);
  xor(r6, r4);          /*r5 = d0b1 +rnd1 + c1*/

  and(r4, r7);          /*r4 = c1b1*/

  xor(r5, r4);          /*r5 = c0b1 + d0b1 + rnd0 + c1b1*/

  load(r4, d_in, 1);
  and(r4, r7);          /*r4 = d0b1*/

  xor(r6, r4);          /*r6 = d0b1 + rnd1 + c1 + d1b1*/
  store(r6, d_out, 1);

  load(r6, a_in, 1);
  xor(r5, r6);          /*r5 = c0b1 + d0b1 + rnd0 + c1b1 + a1*/

  and(r6, r7);          /*r6 = a1b1*/
  clear(opA);

  xor(r5, r4);          /*r5 = c0b1 + d0b1 + rnd0 + c1b1 + a1 + d1b1*/
  store(r5, a_out, 1);

  load(r5, d_in, 1);
  //clear(opA);
  clear(opB);
  xor(r6, r5);          /*r5 = a1b1 + d1*/

  store(r7, c_out, 1);

load_pub(r4);
clear(opR);
  load(r4, a_in, 0);
clear(opB);
  and(r7, r4);          /*r4 = b1a0*/

  load(r4, rnd_loc, 2);

clear(opB);
  xor(r6, r4);          /*r4 = b1a0 +rnd2*/
clear(opB);
clear(opA);

  xor(r5, r4);          /*r6 = a1b1 + d1 +b1a0 + rnd2*/
  store(r5, b_out, 1);

load_pub(r5);
load_pub(r6);
load_pub(r4);
load_pub(r7);

clear(opR);
clear(opW);
clear(opA);
clear(opB);

rnd_loc <- (rnd_loc +w32 (w32) (3 * 4));
}

macro calcB_opt (w32 in, w32 out, w32 rnd_loc)
  w32 a_in, w32 b_in, w32 c_in, w32 d_in, w32 a_out, w32 b_out, w32 c_out, w32 d_out
{
  a_in <- in;
  b_in <- in +w32 (w32) 8;
  c_in <- in +w32 (w32) 16;
  d_in <- in +w32 (w32) 24;

  a_out <- out;
  b_out <- out +w32 (w32) 8;
  c_out <- out +w32 (w32) 16;
  d_out <- out +w32 (w32) 24;

  load(r4, b_in, 0);
  load(r5, d_in, 0);
  xor(r5, r4);
  xor(r5, (w32) 255);
  store(r5, d_out, 0);

  load(r6, a_in, 0);
  xor(r6, r4);
  store(r6, a_out, 0);

  load(r5, c_in, 0);
  xor(r4, r5);
  load(r6,rnd_loc, 0);
  xor(r4, r6);
  store(r4, b_out, 0);
  store(r5, c_out, 0);

  /*second share*/

  load(r4, b_in, 1);
  load(r5, d_in, 1);
  xor(r5, r4);
  store(r5, d_out, 1);

  load(r6, a_in, 1);
  xor(r6, r4);
  store(r6, a_out, 1);

  load(r5, c_in, 1);
  xor(r4, r5);
  load(r6,rnd_loc, 0);
  xor(r4, r6);
  store(r4, b_out, 1);
  store(r5, c_out, 1);

load_pub(r4);
load_pub(r5);
load_pub(r6);
clear(opA);
clear(opB);
clear(opR);
clear(opW);

rnd_loc <- (rnd_loc +w32 (w32) (1 * 4));
}

macro calcA_opt (w32 in, w32 out, w32 rnd_loc)
  w32 a_in, w32 b_in, w32 c_in, w32 d_in, w32 a_out, w32 b_out, w32 c_out, w32 d_out
{
  a_in <- in;
  b_in <- in +w32 (w32) 8;
  c_in <- in +w32 (w32) 16;
  d_in <- in +w32 (w32) 24;

  a_out <- out;
  b_out <- out +w32 (w32) 8;
  c_out <- out +w32 (w32) 16;
  d_out <- out +w32 (w32) 24;

  load(r4, a_in, 0);
  store(r4, c_out, 0);

  load(r5, c_in, 0);
  xor(r5, r4);
  store(r5, a_out, 0);

  xor(r5, (w32) 255);
  load(r6, d_in, 0);
  xor(r5, r6);
  store(r5, d_out, 0);

  load(r5, b_in, 0);
  xor(r5, (w32) 255);
  store(r5, b_out, 0);

  /*second share*/

  load(r5, a_in, 1);
  store(r5, c_out, 1);
clear(opB);
  load(r4, c_in, 1);
  xor(r4, r4);
  store(r4, a_out, 1);

  load(r5, d_in, 1);
  xor(r4, r5);
  store(r4, d_out, 1);

  load(r5, b_in, 1);
  store(r5, b_out, 1);

load_pub(r4);
load_pub(r5);
load_pub(r6);
clear(opA);
clear(opB);
clear(opR);
clear(opW);
}
