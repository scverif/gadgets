/*
printf "include il \"present/first_order/present.il\"\n" | ./main.native | ../maskverif/tool2/main_input.native
printf "include il \"present/first_order/present.il\"\n" | ./main.native | sed -e 's/NI/Probing/g'  | ../maskverif/tool2/main_input.native
*/

include il "isa/pseudoisa.il"
include il "present/first_order/sbox_gadgets.il"

//helper register for intermediate outputs between calculations 
w32 rai1;
w32 rbi1;
w32 rci1;
w32 rdi1;
w32 rai2;
w32 rbi2;
w32 rci2;
w32 rdi2;

//register for in and output adresses
w32 rain;
w32 rbin;
w32 rcin;
w32 rdin;
w32 rao;
w32 rbo;
w32 rco;
w32 rdo;



macro present ()
{ 
  /*present with optimzed gadgets */  
  
  calcB_opt(rain, rbin, rcin, rdin, rai1, rbi1, rci1, rdi1, r3, 0);
  calcG_paraMult(rai1, rbi1, rci1, rdi1, rai2, rbi2, rci2, rdi2, r3, 3);
  calcG_paraMult(rai2, rbi2, rci2, rdi2, rai1, rbi1, rci1, rdi1, r3, 6);
  calcA_opt(rai1, rbi1, rci1, rdi1, rao, rbo, rco, rdo, r3, 7);

  /*compostion of first order gadgets
 
  calcB(rain, rbin, rcin, rdin, rai1, rbi1, rci1, rdi1, r3, 0);
  firstref(rci1, r3, 1 ,rci1);
  calcG(rai1, rbi1, rci1, rdi1, rai2, rbi2, rci2, rdi2, r3, 3);
  calcG(rai2, rbi2, rci2, rdi2, rai1, rbi1, rci1, rdi1, r3, 6);
  calcA(rai1, rbi1, rci1, rdi1, rao, rbo, rco, rdo, r3, 7);*/

}

annotate present
  region mem w32 a[0:1]
  region mem w32 b[0:1]
  region mem w32 c[0:1]
  region mem w32 d[0:1]
  region mem w32 ao[0:1]
  region mem w32 bo[0:1]
  region mem w32 co[0:1]
  region mem w32 do[0:1]
  region mem w32 ai1[0:1]
  region mem w32 bi1[0:1]
  region mem w32 ci1[0:1]
  region mem w32 di1[0:1]
  region mem w32 ai2[0:1]
  region mem w32 bi2[0:1]
  region mem w32 ci2[0:1]
  region mem w32 di2[0:1]
  region mem w32 rnd[0:9]
  init r3 [rnd 0]
  init rain [a 0]
  init rbin [b 0]
  init rcin [c 0]
  init rdin [d 0]
  init rao [ao 0]
  init rbo [bo 0]
  init rco [co 0]
  init rdo [do 0]
  init rai1 [ai1 0]
  init rbi1 [bi1 0]
  init rci1 [ci1 0]
  init rdi1 [di1 0]
  init rai2 [ai2 0]
  init rbi2 [bi2 0]
  init rci2 [ci2 0]
  init rdi2 [di2 0]
  input sharing a
  input sharing b
  input sharing c
  input sharing d
  input urandom rnd
  output sharing ao
  output sharing bo
  output sharing co
  output sharing do
  /*helper variables to simulate mv of intermediate result values*/
  output sharing ai1
  output sharing bi1
  output sharing ci1
  output sharing di1
  output sharing ai2
  output sharing bi2
  output sharing ci2
  output sharing di2
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
  target: present;

inlinecall:
  target: present;

print:
  kind: macrodef
  target: present
  verbosity: 0;

partialeval:
  target: present;

deadcodeelim:
  target: present;

/* remove all ...OperandA and ...OperandB leakages */
filterleak:
  target: present
  inverse: false
  leaks: "*Operand?";

print:
  kind: evaltrace
  target: present
  verbosity: 1;

check:
  target: present
  kind: NI;
...
