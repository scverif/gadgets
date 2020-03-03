// Copyright 2020 - TU Darmstadt, NXP
// SPDX-License-Identifier: AGPL-3.0-or-later

include il "models/pseudoisa.il"

macro secref ()
{
  load(r4, r3, 0);
  load(r6, r1, 0);

clear_opR();

  load(r5, r3, 1);
  xor(r6, r4);
  store(r6, r0, 0);

clear_opW();
load_pub(r6);

  load(r7, r1, 1);
clear_opA();
  xor(r7, r5);

  store(r7, r0, 1);

clear_opW();
clear_opB();

  xor(r4, r5);
load_pub(r5);
clear_opB();
  load(r5, r1, 2);
  xor(r5, r4);

  store(r5, r0, 2);

load_pub(r4);
load_pub(r5);
load_pub(r6);
load_pub(r7);
clear_opA();
clear_opB();
clear_opR();
clear_opW();
}


annotate secref
  region mem w32 a[0:2]
  region mem w32 c[0:2]
  region mem w32 rnd[0:2]
  init r0 [c 0]
  init r1 [a 0]
  init r3 [rnd 0]
  input sharing a
  input urandom rnd
  output sharing c
  ;

---
print:
  kind: macrodef
  target: load
  verbosity: 0;

addleakage:
  target: secref;

inlinecall:
  target: secref;

partialeval:
  target: secref;

rewriteformv:
  target: secref
  inferinput: true
  inferoutput: true;

print:
  kind: evaltrace
  target: secref
  verbosity: 0;

check:
  target: secref
  kind: "Stateful SNI";
...

// Local Variables:
// eval: (setq default-directory (concat (file-name-directory buffer-file-name) "..") compile-command (concat "scverif --il " buffer-file-name))
// End:
