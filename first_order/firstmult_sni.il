include il "isa/pseudoisa.il"

/*
printf "include il \"first_order/firstmult_sni.il\"\n" | ./main.native | ../maskverif/tool2/main_input.native
*/

macro firstmult ()
{
/*calculation of the first outputshare: c0 = a0*b0 + rnd0 +a0*b1*/

/*load b0 into register r4*/
  load(r4, r2, 0);
/*load a0 into register r5*/
  load(r5, r1, 0);

/*perform AND r4 and r5 s.t. r4 contains b0*a0*/
  and(r4, r5);

/*load rnd0 into register r6*/
  load(r6,r3,0);

/*perform XOR r6 and r4 s.t r6 contains b0*a0 + rnd0*/
  xor(r6,r4);

/*load b1 into register r7*/
  load(r7, r2, 1);

/*perform AND with registers r5 and r7 s.t. r5 contains a0*b1*/
  and(r5, r7);
/*perform XOR with registers r5 and r4 s.t.t r5 contains a0*b1 + b0*a0 +rnd0*/
  xor(r5, r6);

/*store value of r5 = a0*b1 + b0*a0 +rnd0 as output value c0 */
  store(r5, r0, 0);

clear_opW();
load_pub(r4);
load_pub(r6);

/*load a1 into register r4*/
  load(r4, r1, 1);

/*perform AND with registers r7 and r4 s.t. r7 contains b1*a1*/
  and(r7, r4);

  load(r6,r3,0);
/*perform XOR with registers r6 and r7 s.t. r6 contains b1*a1 + rnd0*/
  xor(r6,r7);

/*load b0 into register r6*/
  load(r5, r2, 0);

/*perform AND with registers r6 and r4 s.t. r6 contains b0*a1*/
  and(r5, r4);

/*perform XOR with registers r6 and r7 s.t. r5 contains b0*a1 + b1*a1 + rnd0  */
  xor(r6, r5);

/*store value of r6 = b0a1 + b1*a1 +rnd0 as output value c1 */
  store(r6, r0, 1);
}

annotate firstmult
  region mem w32 a[0:1]
  region mem w32 b[0:1]
  region mem w32 c[0:1]
  region mem w32 rnd[0:1]
  init r0 [c 0]
  init r1 [a 0]
  init r2 [b 0]
  init r3 [rnd 0]
  input sharing a
  input sharing b
  input urandom rnd
  output sharing c
  ;

---
verbosity:
  verbosity: 1;

print:
  kind: macrodef
  target: load
  verbosity: 0;

print:
  kind: macrodef
  target: load
  verbosity: 0;

addleakage:
  target: firstmult;

inlinecall:
  target: firstmult;

print:
  kind: macrodef
  target: firstmult
  verbosity: 0;

partialeval:
  target: firstmult;

deadcodeelim:
  target: firstmult;

print:
  kind: evaltrace
  target: firstmult
  verbosity: 0;

check:
  target: firstmult
  kind: SNI;
...
