// Copyright 2020 - TU Darmstadt, NXP
// SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications

include il "models/pseudoisa-clearings.il"

// ptr_in1 is a pointer to ....
macro firstxor (w32 op1, w32 op2, w32 str)
{
/*calculation of thefirst outputshare c0 = a0+b0*/

/*load a0 into register r4*/
  load(r4, op1, 0);
/*load b0 into register r5*/
  load(r5, op2, 0);

/*xor r4 and r5 s.t. r4 contains a0+b0*/
  xor(r4, r5);

/*store value of r4 = a0+b0 as output value c0*/
  store(r4, str, 0);

clear(opW);

/*calculation of thefirst outputshare c0 = a0+b0*/

/*load a1 into register r5*/
  load(r5, op1, 1);
/*load b1 into register r6*/
  load(r6, op2, 1);

/*xor r5 and r6 s.t. r5 contains a1+b1*/
  xor(r5, r6);

/*store value of r5 = a1+b1 as output value c1*/
  store(r5, str, 1);

load_pub(r4);
load_pub(r5);
load_pub(r6);
clear(opW);
clear(opR);
clear(opA);
clear(opB);
}

macro firstmult (w32 op1, w32 op2, w32 rnd_loc, w32 str)
{
/*calculation of the first outputshare: c0 = a0*b0 + rnd0 +a0*b1*/

/*load b0 into register r4*/
  load(r4, op2, 0);
/*load a0 into register r5*/
  load(r5, op1, 0);

/*perform AND r4 and r5 s.t. r4 contains b0*a0*/
  and(r4, r5);

/*load rnd0 into register r6*/
  load(r6,rnd_loc, 0);

/*perform XOR r6 and r4 s.t r6 contains b0*a0 + rnd0*/
  xor(r6,r4);

/*load b1 into register r7*/
  load(r7, op2, 1);

/*perform AND with registers r5 and r7 s.t. r5 contains a0*b1*/
  and(r5, r7);
/*perform XOR with registers r5 and r4 s.t.t r5 contains a0*b1 + b0*a0 +rnd0*/
  xor(r5, r6);

/*store value of r5 = a0*b1 + b0*a0 +rnd0 as output value c0 */
  store(r5, str, 0);

clear(opW);
load_pub(r4);
load_pub(r6);

/*load a1 into register r4*/
  load(r4, op1, 1);

/*perform AND with registers r7 and r4 s.t. r7 contains b1*a1*/
  and(r7, r4);

  load(r6,rnd_loc,0);
/*perform XOR with registers r6 and r7 s.t. r6 contains b1*a1 + rnd0*/
  xor(r6,r7);

/*load b0 into register r6*/
  load(r5, op2, 0);

/*perform AND with registers r6 and r4 s.t. r6 contains b0*a1*/
  and(r5, r4);

/*perform XOR with registers r6 and r7 s.t. r5 contains b0*a1 + b1*a1 + rnd0  */
  xor(r6, r5);

/*store value of r6 = b0a1 + b1*a1 +rnd0 as output value c1 */
  store(r6, str, 1);
load_pub(r4);
load_pub(r5);
load_pub(r6);
load_pub(r7);
clear(opW);
clear(opR);
clear(opA);
clear(opB);

rnd_loc <- (rnd_loc +w32 (w32) (1 * 4));
}

macro firstref (w32 op1, w32 rnd_loc, w32 str)
{
/*calculation of the first outputshare: c0 = a0 +rnd0*/

/*load a0 into register r4*/
  load(r4, op1, 0);
/*load rnd0 into register r5*/
  load(r5, rnd_loc, 0);

/*perform XOR r4 and r5 s.t. r4 contains a0+rnd0*/
  xor(r4, r5);

/*store value of r4 = a0+rnd0 as output share c0 */
  store(r4, str, 0);

clear(opW);

/*calculation of the second output share: c0 = a1 + rnd0*/

/*load a1 into register r4*/
  load(r6, op1, 1);

/*perform XOR r6 and r5 s.t. r6 contains a1+rnd0*/
  xor(r6, r5);

/*store value of r6 = a1+rnd0 as output share c1 */
  store(r6, str, 1);
load_pub(r4);
load_pub(r5);
load_pub(r6);
clear(opW);
clear(opR);
clear(opA);
clear(opB);

rnd_loc <- (rnd_loc +w32 (w32) (1 * 4));
}

macro firststore (w32 op1, w32 str)
{
  load(r4, op1, 0);
  store(r4, str, 0);

clear(opW);
clear(opR);
clear(opA);
clear(opB);

  load(r5, op1, 1);
  store(r5, str, 1);
load_pub(r4);
load_pub(r5);
clear(opW);
clear(opR);
clear(opA);
clear(opB);
}

macro firstxorone (w32 op1, w32 str)
{
/*calculation of thefirst outputshare c0 = a0+b0*/

/*load a0 into register r4*/
  load(r4, op1, 0);

/*xor r4 and r5 s.t. r4 contains a0+1*/
  xor(r4, (w32) 0xFFFF);

/*store value of r4 = a0+b0 as output value c0*/
  store(r4, str, 0);

load_pub(r4);
clear(opW);
clear(opR);
clear(opA);
clear(opB);

/*calculation of thefirst outputshare c0 = a0+b0*/

/*load a1 into register r5*/
  load(r5, op1, 1);


/*store value of r5 = a1+b1 as output value c1*/
  store(r5, str, 1);

load_pub(r5);
clear(opW);
clear(opR);
clear(opA);
clear(opB);
}
