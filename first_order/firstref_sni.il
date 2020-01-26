include il "isa/pseudoisa.il"

/*
printf "include il \"first_order/firstref_sni.il\"\n" | ./main.native | ../maskverif/tool2/main_input.native
*/

macro firstref ()
{
/*calculation of the first outputshare: c0 = a0 +rnd0*/

/*load a0 into register r4*/
  load(r4, r1, 0);
/*load rnd0 into register r5*/
  load(r5, r3, 0);

/*perform XOR r4 and r5 s.t. r4 contains a0+rnd0*/
  xor(r4, r5);

/*store value of r4 = a0+rnd0 as output share c0 */
  store(r4, r0, 0);

clear_opW();

/*calculation of the second output share: c0 = a1 + rnd0*/

/*load a1 into register r4*/
  load(r6, r1, 1);

/*perform XOR r6 and r5 s.t. r6 contains a1+rnd0*/
  xor(r6, r5);

/*store value of r6 = a1+rnd0 as output share c1 */
  store(r4, r0, 1);
}

annotate firstref
  region mem w32 a[0:1]
  region mem w32 c[0:1]
  region mem w32 rnd[0:1]
  init r0 [c 0]
  init r1 [a 0]
  init r3 [rnd 0]
  input sharing a
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
  target: firstref;

inlinecall:
  target: firstref;

print:
  kind: macrodef
  target: firstref
  verbosity: 0;

partialeval:
  target: firstref;

deadcodeelim:
  target: firstref;

print:
  kind: evaltrace
  target: firstref
  verbosity: 0;

check:
  target: firstref
  kind: SNI;
...
