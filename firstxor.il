// Copyright 2019 - TU Darmstadt, NXP

include il "isa/pseudoisa.il"
/*
printf "include il \"first_order/firstxor.il\"\n" | ./main.native | ../maskverif/tool2/main_input.native
*/
macro firstxor ()
{
/*calculation of thefirst outputshare c0 = a0+b0*/

/*load a0 into register r4*/
  load(r4, r1, 0);
/*load b0 into register r5*/ 
  load(r5, r2, 0);

/*xor r4 and r5 s.t. r4 contains a0+b0*/
  xor(r4, r5);

/*store value of r4 = a0+b0 as output value c0*/
  store(r4, r0, 0);

clear_opW();

/*calculation of thefirst outputshare c0 = a0+b0*/

/*load a1 into register r5*/
  load(r5, r1, 1);
/*load b1 into register r6*/
  load(r6, r2, 1);

/*xor r5 and r6 s.t. r5 contains a1+b1*/
  xor(r5, r6);

/*store value of r5 = a1+b1 as output value c1*/
  store(r5, r0, 1);

}

annotate firstxor
  region mem w32 a[0:1]
  region mem w32 b[0:1]
  region mem w32 c[0:1]
  region mem w32 rnd[0:0]
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
  target: firstxor;

inlinecall:
  target: firstxor;

print:
  kind: macrodef
  target: firstxor
  verbosity: 0;

partialeval:
  target: firstxor;

deadcodeelim:
  target: firstxor;

print:
  kind: evaltrace
  target: firstxor
  verbosity: 0;

check:
  target: firstxor
  kind: NI;
...
