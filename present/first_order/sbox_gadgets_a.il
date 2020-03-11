/* Copyright 2020 - TU Darmstadt, NXP */

include il "first_order/basic_gadgets_a.il"

macro calcG (w32 in, w32 out, w32 rnd_loc, w32 sp)
  w32 a_in, w32 b_in, w32 c_in, w32 d_in, w32 a_out, w32 b_out, w32 c_out, w32 d_out
{
/*  a_in <- in;
  b_in <- in +w32 (w32) 8;
  c_in <- in +w32 (w32) 16;
  d_in <- in +w32 (w32) 24;

  a_out <- out;
  b_out <- out +w32 (w32) 8;
  c_out <- out +w32 (w32) 16;
  d_out <- out +w32 (w32) 24;*/

  load(r2,sp,0);
  load(r3,sp,0);
  load(r1,sp,1);
  r2 <- r2 +w32 (w32) (2*4);
  r3 <- r3 +w32 (w32) (6*4);
  r1 <- r1 +w32 (w32) (6*4);
  firstmult(r2, r3, r0, r1);

  r3 <- r3 -w32 (w32) (2*4);
  r1 <- r1 -w32 (w32) (6*4);
  firstmult(b_in, c_in, rnd_loc, a_out);

  copy(r2,r1);
  r3 <- r3 -w32 (w32) (4*4);
  firstxor(a_out, a_in, a_out);

  /*calc a'*/
  copy(r3,r1);
  r3 <- r3 +w32 (w32) (6*4);
  firstxor(a_out, d_out, a_out);

  /*calc d'*/
  copy(r1,r3);
  load(r2,sp,0);
  r2 <- r2 +w32 (w32) (4*4);
  firstxor(c_in, d_out, d_out);

  /*calc b'*/
  copy(r3,r2);
  r3 <- r3 -w32 (w32) (2*4);
  r2 <- r2 -w32 (w32) (4*4);
  r1 <- r1 -w32 (w32) (4*4);
  firstmult(a_in, b_in, rnd_loc, b_out);

  copy(r2,r1);
  r3 <- r3 +w32 (w32) (4*4);
  firstxor(b_out, d_in, b_out);

  /*calc c'*/
  r3 <- r3 -w32 (w32) (4*4);
  r1 <- r1 +w32 (w32) (2*4);
  firststore(b_in, c_out);
}

macro calcB (w32 in, w32 out, w32 rnd_loc, w32 sp)
  w32 a_in, w32 b_in, w32 c_in, w32 d_in, w32 a_out, w32 b_out, w32 c_out, w32 d_out
{
  /*a_in <- in;
  b_in <- in +w32 (w32) 8;
  c_in <- in +w32 (w32) 16;
  d_in <- in +w32 (w32) 24;

  a_out <- out;
  b_out <- out +w32 (w32) 8;
  c_out <- out +w32 (w32) 16;
  d_out <- out +w32 (w32) 24;*/

  load(r2,sp,0);
  load(r3,sp,0);
  load(r1,sp,1);

  r2 <- r2 +w32 (w32) (2*4);
  r3 <- r3 +w32 (w32) (6*4);
  r1 <- r1 +w32 (w32) (6*4);
  firstxor(b_in, d_in, d_out);

  copy(r3,r1);
  firstxorone(d_out, d_out);

  copy(r3,r2);
  r3 <- r3 +w32 (w32) (2*4);
  r1 <- r1 -w32 (w32) (2*4);
  firststore(c_in, c_out);

  r1 <- r1 -w32 (w32) (2*4);
  firstxor(b_in, c_in, b_out);

  copy(r3,r1);
  firstref(b_out, r2, b_out);

  copy(r3,r2);
  r2 <- r2 -w32 (w32) (2*4);
  r1 <- r1 -w32 (w32) (2*4);
  firstxor(a_in, b_in, a_out);

}

macro calcA (w32 in, w32 out, w32 rnd_loc, w32 sp)
  w32 a_in, w32 b_in, w32 c_in, w32 d_in, w32 a_out, w32 b_out, w32 c_out, w32 d_out
{
  /*a_in <- in;
  b_in <- in +w32 (w32) 8;
  c_in <- in +w32 (w32) 16;
  d_in <- in +w32 (w32) 24;

  a_out <- out;
  b_out <- out +w32 (w32) 8;
  c_out <- out +w32 (w32) 16;
  d_out <- out +w32 (w32) 24;*/


  load(r2,sp,0);
  load(r3,sp,0);
  load(r1,sp,1);

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

  copy(r2,r1);
  r3 <- r3 +w32 (w32) (2*4);
  firstxor();

  copy(r3,r1);
  firstxorone();
}

macro calcG_paraMult (w32 in, w32 out, w32 rnd_loc, int i)
  w32 a_in, w32 b_in, w32 c_in, w32 d_in, w32 a_out, w32 b_out, w32 c_out, w32 d_out
{
  a_in <- in +w32 (w32) (i * 32);
  b_in <- in +w32 (w32) 8 +w32 (w32) (i * 32);
  c_in <- in +w32 (w32) 16 +w32 (w32) (i * 32);
  d_in <- in +w32 (w32) 24 +w32 (w32) (i * 32);

  a_out <- out +w32 (w32) ((1-i) * 32);
  b_out <- out +w32 (w32) 8 +w32 (w32) ((1-i) * 32);
  c_out <- out +w32 (w32) 16 +w32 (w32) ((1-i) * 32);
  d_out <- out +w32 (w32) 24 +w32 (w32) ((1-i) * 32);

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

  clear_opR();
  load(r5, a_in, 0);
  xor(r6, r5);          /*r6 = c1b0 + d0b0 + rnd0 + c0b0 + a0*/

  and(r5, r4);          /*r5 = a0b0*/
  clear_opA();
  xor(r6, r7);          /*r6 = c1b0 + d0b0 + rnd0 + c0b0 + a0 + d1b0*/
  store(r6, a_out, 0);

  load(r6, d_in, 0);
  //clear_opA();
  clear_opB();
  xor(r5, r6);          /*r5 = a0b0 + d0*/

  store(r4, c_out, 0);

clear_opR();
  load(r7, a_in, 1);
  and(r4, r7);          /*r4 = b0a1*/

  load(r7, rnd_loc, 2);

clear_opB();
  xor(r5, r7);          /*r4 = b0a1 +rnd2*/
clear_opB();
clear_opA();

  xor(r5, r4);          /*r5 = a0b0 + d0 +b0a1 + rnd2*/
  store(r5, b_out, 0);

/*second output share*/
clear_opB();
  load(r7, b_in, 1);
clear_opB();
  load(r5, c_in, 0);
  and(r5, r7);          /*r5 = c0b1*/

  and(r6, r7);          /*r5 = d0b1*/

/*-----------------------------------------*/

  xor(r5, r6);          /*r5 = c0b1 + d0b1*/
clear_opB();
  load(r4, rnd_loc, 0);
  clear_opB();

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
  clear_opA();

  xor(r5, r4);          /*r5 = c0b1 + d0b1 + rnd0 + c1b1 + a1 + d1b1*/
  store(r5, a_out, 1);

  load(r5, d_in, 1);
  //clear_opA();
  clear_opB();
  xor(r6, r5);          /*r5 = a1b1 + d1*/

  store(r7, c_out, 1);

load_pub(r4);
clear_opR();
  load(r4, a_in, 0);
clear_opB();
  and(r7, r4);          /*r4 = b1a0*/

  load(r4, rnd_loc, 2);

clear_opB();
  xor(r6, r4);          /*r4 = b1a0 +rnd2*/
clear_opB();
clear_opA();

  xor(r5, r4);          /*r6 = a1b1 + d1 +b1a0 + rnd2*/
  store(r5, b_out, 1);

load_pub(r5);
load_pub(r6);
load_pub(r4);
load_pub(r7);

clear_opR();
clear_opW();
clear_opA();
clear_opB();

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
clear_opA();
clear_opB();
clear_opR();
clear_opW();

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
clear_opB();
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
clear_opA();
clear_opB();
clear_opR();
clear_opW();
}
