// Copyright 2020 - TU Darmstadt, NXP
// SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications

include il "models/pseudoisa-clearings.il"

macro firstxor ()
{
/*calculation of thefirst outputshare c0 = a0+b0*/

/*load a0 into register r4*/
  load(r4, r2, 0);
/*load b0 into register r5*/
  load(r5, r3, 0);

/*xor r4 and r5 s.t. r4 contains a0+b0*/
  xor(r4, r5);

/*store value of r4 = a0+b0 as output value c0*/
  store(r4, r1, 0);

clear(opW);

/*calculation of thefirst outputshare c0 = a0+b0*/

/*load a1 into register r5*/
  load(r5, r2, 1);
/*load b1 into register r6*/
  load(r6, r3, 1);

/*xor r5 and r6 s.t. r5 contains a1+b1*/
  xor(r5, r6);

/*store value of r5 = a1+b1 as output value c1*/
  store(r5, r1, 1);

scrub(r4);
scrub(r5);
scrub(r6);
clear(opW);
clear(opR);
clear(opA);
clear(opB);
}

macro firstmult ()
{
/*calculation of the first outputshare: c0 = a0*b0 + rnd0 +a0*b1*/

/*load b0 into register r4*/
  load(r4, r3, 0);
/*load a0 into register r5*/
  load(r5, r2, 0);

/*perform AND r4 and r5 s.t. r4 contains b0*a0*/
  and(r4, r5);

/*load rnd0 into register r6*/
  load(r6,r0, 0);

/*perform XOR r6 and r4 s.t r6 contains b0*a0 + rnd0*/
  xor(r6,r4);

/*load b1 into register r7*/
  load(r7, r3, 1);

/*perform AND with registers r5 and r7 s.t. r5 contains a0*b1*/
  and(r5, r7);
/*perform XOR with registers r5 and r4 s.t.t r5 contains a0*b1 + b0*a0 +rnd0*/
  xor(r5, r6);

/*store value of r5 = a0*b1 + b0*a0 +rnd0 as output value c0 */
  store(r5, r1, 0);

clear(opW);
scrub(r4);
scrub(r6);

/*load a1 into register r4*/
  load(r4, r2, 1);

/*perform AND with registers r7 and r4 s.t. r7 contains b1*a1*/
  and(r7, r4);

  load(r6,r0,0);
/*perform XOR with registers r6 and r7 s.t. r6 contains b1*a1 + rnd0*/
  xor(r6,r7);

/*load b0 into register r6*/
  load(r5, r3, 0);

/*perform AND with registers r6 and r4 s.t. r6 contains b0*a1*/
  and(r5, r4);

/*perform XOR with registers r6 and r7 s.t. r5 contains b0*a1 + b1*a1 + rnd0  */
  xor(r6, r5);

/*store value of r6 = b0a1 + b1*a1 +rnd0 as output value c1 */
  store(r6, r1, 1);
scrub(r4);
scrub(r5);
scrub(r6);
scrub(r7);
clear(opW);
clear(opR);
clear(opA);
clear(opB);

r0 <- (r0 +w32 (w32) (1 * 4));
}

macro firstref ()
{
/*calculation of the first outputshare: c0 = a0 +rnd0*/

/*load a0 into register r4*/
  load(r4, r3, 0);
/*load rnd0 into register r5*/
  load(r5, r0, 0);

/*perform XOR r4 and r5 s.t. r4 contains a0+rnd0*/
  xor(r4, r5);

/*store value of r4 = a0+rnd0 as output share c0 */
  store(r4, r1, 0);

clear(opW);

/*calculation of the second output share: c0 = a1 + rnd0*/

/*load a1 into register r4*/
  load(r6, r3, 1);

/*perform XOR r6 and r5 s.t. r6 contains a1+rnd0*/
  xor(r6, r5);

/*store value of r6 = a1+rnd0 as output share c1 */
  store(r6, r1, 1);
scrub(r4);
scrub(r5);
scrub(r6);
clear(opW);
clear(opR);
clear(opA);
clear(opB);

r0 <- (r0 +w32 (w32) (1 * 4));
}

macro firststore ()
{
  load(r4, r3, 0);
  store(r4, r1, 0);

clear(opW);
clear(opR);
clear(opA);
clear(opB);

  load(r5, r3, 1);
  store(r5, r1, 1);
scrub(r4);
scrub(r5);
clear(opW);
clear(opR);
clear(opA);
clear(opB);
}

macro firstxorone ()
{
/*calculation of thefirst outputshare c0 = a0+b0*/

/*load a0 into register r4*/
  load(r4, r3, 0);

/*xor r4 and r5 s.t. r4 contains a0+1*/
  xor(r4, (w32) 0xFFFF);

/*store value of r4 = a0+b0 as output value c0*/
  store(r4, r1, 0);

scrub(r4);
clear(opW);
clear(opR);
clear(opA);
clear(opB);

/*calculation of thefirst outputshare c0 = a0+b0*/

/*load a1 into register r5*/
  load(r5, r3, 1);


/*store value of r5 = a1+b1 as output value c1*/
  store(r5, r1, 1);

scrub(r5);
clear(opW);
clear(opR);
clear(opA);
clear(opB);
}
