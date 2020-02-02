// Copyright 2019-2020 - NXP, TU Darmstadt

include il "models/pseudoisa.il"
include il "present/first_order/sbox_gadgets.il"

macro calcA_inst() {
  calcA(r2, r1, r0);
}

annotate calcA_inst
  region mem w32 min[0:7]
  region mem w32 mout[0:7]
  region mem w32 mrnd[0:9]
  init r2 [min 0]
  init r1 [mout 0]
  init r0 [mrnd 0]
  input sharing a [min[0:1]]
  input sharing b [min[2:3]]
  input sharing c [min[4:5]]
  input sharing d [min[6:7]]
  input urandom mrnd
  output sharing a [mout[0:1]]
  output sharing b [mout[2:3]]
  output sharing c [mout[4:5]]
  output sharing d [mout[6:7]]
  input public pub
  input public opA
  input public opB
  input public opR
  input public opW
  input public r0
  input public r1
  input public r2
  input public r3
  input public r4
  input public r5
  input public r6
  input public r7
  ;

macro calcB_inst() {
  calcB(r2, r1, r0);
}

annotate calcB_inst
  region mem w32 min[0:7]
  region mem w32 mout[0:7]
  region mem w32 mrnd[0:9]
  init r2 [min 0]
  init r1 [mout 0]
  init r0 [mrnd 0]
  input sharing a [min[0:1]]
  input sharing b [min[2:3]]
  input sharing c [min[4:5]]
  input sharing d [min[6:7]]
  input urandom mrnd
  output sharing a [mout[0:1]]
  output sharing b [mout[2:3]]
  output sharing c [mout[4:5]]
  output sharing d [mout[6:7]]
  input public pub
  input public opA
  input public opB
  input public opR
  input public opW
  input public r0
  input public r1
  input public r2
  input public r3
  input public r4
  input public r5
  input public r6
  input public r7
  ;

macro calcG_inst() {
  calcG(r2, r1, r0);
}

annotate calcG_inst
  region mem w32 min[0:7]
  region mem w32 mout[0:7]
  region mem w32 mrnd[0:9]
  init r2 [min 0]
  init r1 [mout 0]
  init r0 [mrnd 0]
  input sharing a [min[0:1]]
  input sharing b [min[2:3]]
  input sharing c [min[4:5]]
  input sharing d [min[6:7]]
  input urandom mrnd
  output sharing a [mout[0:1]]
  output sharing b [mout[2:3]]
  output sharing c [mout[4:5]]
  output sharing d [mout[6:7]]
  input public pub
  input public opA
  input public opB
  input public opR
  input public opW
  input public r0
  input public r1
  input public r2
  input public r3
  input public r4
  input public r5
  input public r6
  input public r7
  ;

---
inlinecall:
  target: [calcA_inst, calcB_inst, calcG_inst];

partialeval:
  target: [calcA_inst, calcB_inst];

rewriteformv:
  target: [calcA_inst, calcB_inst, calcG_inst]
  inferinput: false
  inferoutput: true;

print:
  kind: maskverif
  target: [calcA_inst, calcB_inst, calcG_inst]
  verbosity: 0;

check:
  target: [calcA_inst, calcB_inst, calcG_inst]
  kind: "Stateful NI";
...

// Local Variables:
// eval: (setq default-directory (concat (file-name-directory buffer-file-name) "../..") compile-command (concat "scverif --il " buffer-file-name))
// End:
