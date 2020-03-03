// Copyright 2019-2020 - TU Darmstadt, NXP
// SPDX-License-Identifier: AGPL-3.0-or-later

include il "models/pseudoisa.il"

macro secxor ()
{
  load(r4, r1, 0);
  load(r5, r2, 0);
  xor(r4, r5);
  store(r4, r0, 0);

clear_opB();
clear_opW();

  load(r6, r1, 1);
  load(r7, r2, 1);
  xor(r7, r6);
  store(r7, r0, 1);

clear_opB();
clear_opW();
load_pub(r6);

  load(r5, r1, 2);
  load(r6, r2, 2);
  xor(r5, r6);
  store(r5, r0, 2);

  scrub(r4);
  scrub(r5);
  scrub(r6);
  scrub(r7);
  clear_opB();
  clear_opR();
  clear_opW();
}

annotate secxor
  region mem w32 a[0:2]
  region mem w32 b[0:2]
  region mem w32 c[0:2]
  region mem w32 rnd[0:9]
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
inlinecall:
  target: secxor;

print:
  kind: macrodef
  target: secxor
  verbosity: 0;

partialeval:
  target: secxor;

rewriteformv:
  target: secxor
  inferinput: true
  inferoutput: true;

print:
  kind: evaltrace
  target: secxor
  verbosity: 0;

check:
  target: secxor
  kind: "Stateful NI";
...

// Local Variables:
// eval: (setq default-directory (concat (file-name-directory buffer-file-name) "..") compile-command (concat "scverif --il " buffer-file-name))
// End:
