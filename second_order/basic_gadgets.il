// Copyright 2020 - TU Darmstadt, NXP
// SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications

// rin1ptr shares[0:2], rin2ptr shares[0:2], rdstptr output[0:2]
macro secxor (w32 rin1ptr, w32 rin2ptr, w32 rdstptr)
{
  load(r4, rin1ptr, 0);
  load(r5, rin2ptr, 0);
  xor(r4, r5);
  store(r4, rdstptr, 0);

clear(opW);

  load(r6, rin1ptr, 1);
  load(r7, rin2ptr, 1);
  xor(r7, r6);
  store(r7, rdstptr, 1);

load_pub(r6);
clear(opB);
clear(opW);

  load(r5, rin1ptr, 2);
  load(r6, rin2ptr, 2);
  xor(r5, r6);
  store(r5, rdstptr, 2);

load_pub(r4);
load_pub(r5);
load_pub(r6);
load_pub(r7);
clear(opA);
clear(opB);
clear(opR);
clear(opW);
}

// rin1ptr shares[0:2], rin2ptr shares[0:2], rdstptr output[0:2]
macro secmult (w32 rin1ptr, w32 rin2ptr, w32 rnd_loc, w32 rdstptr)
{
/*a0 is loaded into register r5*/
  load(r5, rin1ptr, 0);

/*b0 is loaded into register r4*/
  load(r4, rin2ptr, 0);

/*in r4 the result b0*a0 is stored*/
  and(r4, r5);

/*rnd0 is loaded into register r6*/
  load(r6,rnd_loc, 0);

/*in register r6 the result rnd0+b0*a0 is stored*/
  xor(r6,r4);

clear(opB);/*This clearing is needed to remove b0*a0 from opB otherwise (Load Operand) would leak*/

/*In register r7 b1 is loaded and a0 still is in register r5*/
  load(r7, rin2ptr, 1);

/*in r7 the result b1*a0 is stored*/
  and(r7, r5);

/*in register r6 the result rnd0+b0*a0+b1*a0 is stored*/
  xor(r6,r7);

/*To load a1 into register r4 register r4 needs to be cleared by loading a public value into it*/
load_pub(r4);/*Load Transition*/

/*a1 is loaded to register r4*/
  load(r4, rin1ptr, 1);

/*b0 is loaded to register r5*/
  load(r5, rin2ptr, 0);

clear(opB);/*load opA*/
/*in register r4 the result a1*b0 is stored*/
  and(r4, r5);

/*in register r6 the result rnd0+b0*a0+b1*a0+a1*b0 is stored*/
  xor(r6, r4);

/* To achieve SNI security the randomness is not allowed to be leaked with much other values therefore the following clearings are needed */
clear(opA);/*Xor Oparand A*/
load_pub(r5);/*Load Transition*/

/*rnd1 is loaded into register r5*/
  load(r5, rnd_loc,  1);

/*in regsister r6 the result rnd0+b0*a0+b1*a0+a1*b0+rnd1 is stored*/
  xor(r6, r5);

/*The first outptvalue c0 = rnd0+b0*a0+b1*a0+a1*b0+rnd1 is stored to memory*/
  store(r6, rdstptr, 0);

/*After the calculation of the first output-share these clearings are used to reset the hardware to make the calculation of the output-shares independent*/

/*opW needs to be cleared because of StoreTranistion-Leakages*/
clear(opW);

/*Register r4, r5 and r7 need to be cleared*/
load_pub(r4);
load_pub(r5);
load_pub(r7);



/*a1 is loaded into register r5*/
  load(r5, rin1ptr, 1);

/*b1 is loaded into register r4*/
  load(r4, rin2ptr, 1);

/*in r4 the result b1*a1 is stored*/
  and(r4, r5);

/*rnd1 is loaded into register r6*/
  load(r6,rnd_loc, 1);

/*in register r6 the result rnd1+b1*a1 is stored*/
  xor(r6,r4);

clear(opB);/*This clearing is needed to remove b1*a1 from opB otherwise (Load Operand) would leak*/

/*In register r7 b2 is loaded and a1 still is in register r5*/
  load(r7, rin2ptr, 2);

/*in r7 the result b2*a1 is stored*/
  and(r7, r5);

/*in register r6 the result rnd1+b1*a1+b2*a1 is stored*/
  xor(r6,r7);

/*To load a2 into register r4 register r4 needs to be cleared by loading a public value into it*/
load_pub(r4);/*Load Transition*/

/*a2 is loaded to register r4*/
  load(r4, rin1ptr, 2);

/*b1 is loaded to register r5*/
  load(r5, rin2ptr, 1);

clear(opB);/*load opA*/
/*in register r4 the result a2*b1 is stored*/
  and(r4, r5);

/*in register r6 the result rnd1+b1*a1+b2*a1+a2*b1 is stored*/
  xor(r6,r4);

/*To achieve SNI security the randomness is not allowed to be leaked with much other values therefore the following clearings are needed*/
clear(opA);/*Xor Oparand A*/
load_pub(r5);/*Load Transition*/

/*rnd2 is loaded into register r5*/
  load(r5, rnd_loc,  2);

/*in regsister r6 the result rnd1+b1*a1+b2*a1+a2*b1+rnd2 is stored*/
  xor(r6, r5);

/*The first outptvalue c1 = rnd1+b1*a1+b2*a1+a2*b1+rnd2 is stored to memory*/
  store(r6, rdstptr, 1);

/*After the calculation of the second output-share these clearings are used to reset the hardware to make the calculation of the output-shares independent*/

/*opW needs to be cleared because of StoreTranistion-Leakages*/
clear(opW);

/*Register r4, r5 and r7 need to be cleared*/
load_pub(r4);
load_pub(r5);
load_pub(r7);


/*a2 is loaded into register r5*/
  load(r5, rin1ptr, 2);

/*b2 is loaded into register r4*/
  load(r4, rin2ptr, 2);

/*in r4 the result b2*a2 is stored*/
  and(r4, r5);

/*rnd2 is loaded into register r6*/
  load(r6,rnd_loc, 2);

/*in register r6 the result rnd2+b2*a2 is stored*/
  xor(r6,r4);

clear(opB);/*This clearing is needed to remove b2*a2 from opB otherwise (Load Operand) would leak*/

/*In register r7 b0 is loaded and a1 still is in register r5*/
  load(r7, rin2ptr, 0);

/*in r7 the result b0*a2 is stored*/
  and(r7, r5);

/*in register r6 the result rnd2+b2*a2+b0*a2 is stored*/
  xor(r6,r7);

/*To load a0 into register r4 register r4 needs to be cleared by loading a public value into it*/
load_pub(r4);/*Load Transition*/

/*a0 is loaded to register r4*/
  load(r4, rin1ptr, 0);

/*b2 is loaded to register r5*/
  load(r5, rin2ptr, 2);

clear(opB);/*load opA*/
/*in register r4 the result a0*b2 is stored*/
  and(r4, r5);

/*in register r6 the result rnd2+b2*a2+b0*a2+a0*b2 is stored*/
  xor(r6,r4);

/*To achieve SNI security the randomness is not allowed to be leaked with much other values therefore the following clearings are needed*/
clear(opA);/*Xor Oparand A*/
load_pub(r5);/*Load Transition*/

/*rnd0 is loaded into register r5*/
  load(r5, rnd_loc,  0);

/*in regsister r6 the result rnd2+b2*a2+b0*a2+a0*b2+rnd0 is stored*/
  xor(r6, r5);

/*The first outptvalue c1 = rnd2+b2*a2+b0*a2+a0*b2+rnd0 is stored to memory*/
  store(r6, rdstptr, 2);

load_pub(r4);
load_pub(r5);
load_pub(r6);
load_pub(r7);
clear(opA);
clear(opB);
clear(opR);
clear(opW);

rnd_loc <- (rnd_loc +w32 (w32) (3 * 4));
}

// rin1ptr shares[0:2], rin2ptr shares[0:2], rdstptr output[0:2]
macro secref (w32 rin1ptr, w32 rnd_loc, w32 rdstptr)
{
  load(r4, rnd_loc, 0);

  load(r6, rin1ptr, 0);
clear(opR);
  load(r5, rnd_loc, 1);

  xor(r6, r4);

  store(r6, rdstptr, 0);

clear(opW);
load_pub(r6);

  load(r7, rin1ptr, 1);
clear(opA);
  xor(r7, r5);

  store(r7, rdstptr, 1);

clear(opW);
clear(opB);

  xor(r4, r5);
load_pub(r5);
clear(opB);
  load(r5, rin1ptr, 2);
  xor(r5, r4);

  store(r5, rdstptr, 2);

load_pub(r4);
load_pub(r5);
load_pub(r6);
load_pub(r7);
clear(opA);
clear(opB);
clear(opR);
clear(opW);

rnd_loc <- (rnd_loc +w32 (w32) (2 * 4));
}

// rin1ptr shares[0:2], rin2ptr shares[0:2], rdstptr output[0:2]
macro secstore (w32 rin1ptr, w32 rdstptr)
{
  load(r4, rin1ptr, 0);
  store(r4, rdstptr, 0);

clear(opW);
clear(opR);
clear(opA);
clear(opB);

  load(r5, rin1ptr, 1);
  store(r5, rdstptr, 1);

clear(opW);
clear(opR);
clear(opA);
clear(opB);

  load(r6, rin1ptr, 2);
  store(r5, rdstptr, 2);

load_pub(r4);
load_pub(r5);
load_pub(r6);
clear(opW);
clear(opR);
clear(opA);
clear(opB);
}

// rin1ptr shares[0:2], rdstptr output[0:2]
macro secnot (w32 rin1ptr, w32 rdstptr)
{
/*calculation of thefirst outputshare c0 = a0+b0*/

/*load a0 into register r4*/
  load(r4, rin1ptr, 0);

/*xor r4 and r5 s.t. r4 contains a0+1*/
  xor(r4, (w32) 0xFF);

/*store value of r4 = a0+b0 as output value c0*/
  store(r4, rdstptr, 0);

load_pub(r4);
clear(opW);
clear(opR);
clear(opA);
clear(opB);

/*calculation of thefirst outputshare c0 = a0+b0*/

  load(r5, rin1ptr, 1);

  store(r5, rdstptr, 1);

load_pub(r5);
clear(opW);
clear(opR);
clear(opA);
clear(opB);

  load(r6, rin1ptr, 2);

  store(r6, rdstptr, 2);

load_pub(r6);
clear(opW);
clear(opR);
clear(opA);
clear(opB);
}
