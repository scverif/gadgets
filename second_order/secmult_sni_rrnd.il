include il "isa/pseudoisa.il"

/*
 * This gadget is a SNI-multiplication in the leakage-model defined by pseudoisa.il
 * It uses SNI-multiplication with 3 fresh random words and clearings
 * c0 = ((a0*b0+rnd0)+a0*b1)+a1*b0+rnd1
 * c1 = ((a1*b1+rnd1)+a1*b2)+a2*b1+rnd2
 * c2 = ((a2*b2+rnd2)+a2*b0)+a0*b2+rnd0
*/

macro secmult ()
{
  load(r5, r1, 0);      /*a0 is loaded into register r5*/
  load(r4, r2, 0);      /*b0 is loaded into register r4*/

  and(r4, r5);          /*in r4 the result b0*a0 is stored*/

  load(r6,r3,0);        /*rnd0 is loaded into register r6*/

  xor(r6,r4);           /*in register r6 the result rnd0+b0*a0 is stored*/

clear_opB();            /*This clearing is needed to remove b0*a0 from opB otherwise (Load Operand) would leak*/

  load(r7, r2, 1);      /*In register r7 b1 is loaded and a0 still is in register r5*/

  and(r7, r5);          /*in r7 the result b1*a0 is stored*/

  xor(r6,r7);           /*in register r6 the result rnd0+b0*a0+b1*a0 is stored*/

/*To load a1 into register r4 register r4 needs to be cleared by loading a public value into it*/
load_pub(r4);/*Load Transition*/

  load(r4, r1, 1);      /*a1 is loaded to register r4*/

  load(r5, r2, 0);      /*b0 is loaded to register r5*/

clear_opB();

  and(r4, r5);          /*in register r4 the result a1*b0 is stored*/

  xor(r6,r4);           /*in register r6 the result rnd0+b0*a0+b1*a0+a1*b0 is stored*/

/*To achieve SNI security the randomness is not allowed to be leaked with much other values therefore the following clearings are needed*/
clear_opA();/*Xor Oparand A*/
load_pub(r5);/*Load Transition*/

/*rnd1 is loaded into register r5*/
  load(r5, r3, 1);

/*in register r6 the result rnd0+b0*a0+b1*a0+a1*b0+rnd1 is stored*/
  xor(r6, r5);

/*The first outputvalue c0 = rnd0+b0*a0+b1*a0+a1*b0+rnd1 is stored to memory*/
  store(r6, r0, 0);

/*After the calculation of the first output-share these clearings are used to reset the hardware to make the calculation of the output-shares independent*/

/*opW needs to be cleared because of StoreTranistion-Leakages*/
clear_opW();

/*Register r4, r5 and r7 need to be cleared*/
load_pub(r4);
load_pub(r5);
load_pub(r7);



/*a1 is loaded into register r5*/
  load(r5, r1, 1);

/*b1 is loaded into register r4*/
  load(r4, r2, 1);

/*in r4 the result b1*a1 is stored*/
  and(r4, r5);

/*rnd1 is loaded into register r6*/
  load(r6,r3,1);

/*in register r6 the result rnd1+b1*a1 is stored*/
  xor(r6,r4);

clear_opB();/*This clearing is needed to remove b1*a1 from opB otherwise (Load Operand) would leak*/

/*In register r7 b2 is loaded and a1 still is in register r5*/
  load(r7, r2, 2);

/*in r7 the result b2*a1 is stored*/
  and(r7, r5);

/*in register r6 the result rnd1+b1*a1+b2*a1 is stored*/
  xor(r6,r7);

/*To load a2 into register r4 register r4 needs to be cleared by loading a public value into it*/
load_pub(r4);/*Load Transition*/

/*a2 is loaded to register r4*/
  load(r4, r1, 2);

/*b1 is loaded to register r5*/
  load(r5, r2, 1);

clear_opB();/*load opA*/
/*in register r4 the result a2*b1 is stored*/
  and(r4, r5);

/*in register r6 the result rnd1+b1*a1+b2*a1+a2*b1 is stored*/
  xor(r6,r4);

/*To achieve SNI security the randomness is not allowed to be leaked with much other values therefore the following clearings are needed*/
clear_opA();/*Xor Oparand A*/
load_pub(r5);/*Load Transition*/

/*rnd2 is loaded into register r5*/
  load(r5, r3, 2);

/*in regsister r6 the result rnd1+b1*a1+b2*a1+a2*b1+rnd2 is stored*/
  xor(r6, r5);

/*The second outputvalue c1 = rnd1+b1*a1+b2*a1+a2*b1+rnd2 is stored to memory*/
  store(r6, r0, 1);

/*After the calculation of the second output-share these clearings are used to reset the hardware to make the calculation of the output-shares independent*/

/*opW needs to be cleared because of StoreTranistion-Leakages*/
clear_opW();

/*Register r4, r5 and r7 need to be cleared*/
load_pub(r4);
load_pub(r5);
load_pub(r7);


/*a2 is loaded into register r5*/
  load(r5, r1, 2);

/*b2 is loaded into register r4*/
  load(r4, r2, 2);

/*in r4 the result b2*a2 is stored*/
  and(r4, r5);

/*rnd2 is loaded into register r6*/
  load(r6,r3,2);

/*in register r6 the result rnd2+b2*a2 is stored*/
  xor(r6,r4);

clear_opB();/*This clearing is needed to remove b2*a2 from opB otherwise (Load Operand) would leak*/

/*In register r7 b0 is loaded and a1 still is in register r5*/
  load(r7, r2, 0);

/*in r7 the result b0*a2 is stored*/
  and(r7, r5);

/*in register r6 the result rnd2+b2*a2+b0*a2 is stored*/
  xor(r6,r7);

/*To load a0 into register r4 register r4 needs to be cleared by loading a public value into it*/
load_pub(r4);/*Load Transition*/

/*a0 is loaded to register r4*/
  load(r4, r1, 0);

/*b2 is loaded to register r5*/
  load(r5, r2, 2);

clear_opB();/*load opA*/
/*in register r4 the result a0*b2 is stored*/
  and(r4, r5);

/*in register r6 the result rnd2+b2*a2+b0*a2+a0*b2 is stored*/
  xor(r6,r4);

/*To achieve SNI security the randomness is not allowed to be leaked with much other values therefore the following clearings are needed*/
clear_opA();/*Xor Oparand A*/
load_pub(r5);/*Load Transition*/

/*rnd0 is loaded into register r5*/
  load(r5, r3, 0);

/*in regsister r6 the result rnd2+b2*a2+b0*a2+a0*b2+rnd0 is stored*/
  xor(r6, r5);

/*The first outptvalue c1 = rnd2+b2*a2+b0*a2+a0*b2+rnd0 is stored to memory*/
  store(r6, r0, 2);

load_pub(r4);
load_pub(r5);
load_pub(r6);
load_pub(r7);
clear_opA();
clear_opB();
clear_opR();
clear_opW();
}


annotate secmult
  region mem w32 a[0:2]
  region mem w32 b[0:2]
  region mem w32 c[0:2]
  region mem w32 rnd[0:2]
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

/* put all leakages of a macro in a single leak statement at the beginning.
accumulate:
  target: [load,store,xor,and]
  leaks: any
  keep: false; // remove the old leakages
*/

print:
  kind: macrodef
  target: load
  verbosity: 0;

addleakage:
  target: secmult;

inlinecall:
  target: secmult;

print:
  kind: macrodef
  target: secmult
  verbosity: 0;

partialeval:
  target: secmult;

rewriteformv:
target: secmult
inferinput: true
inferoutput: true;

print:
  kind: evaltrace
  target: secmult
  verbosity: 0;

check:
  target: secmult
  kind: SNI;
...
