# Copyright 2020 - NXP
# SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications

.PHONY: all
MAKEFLAGS    += --silent

SCVERIF      := scverif
LOGDIR	     := logs

all: test-all

logdir:
	mkdir -p $(LOGDIR)

clean:
	rm -rf $(LOGDIR)

%.il: logdir
	$(SCVERIF) --il $@ | tee $(LOGDIR)/$(notdir $@)

test-models: models/isa-cortex-m0plus-metrics.il models/pseudoisa-cortexmclearings.il models/pseudoisa.il models/isa-cortex-m0plus.il models/pseudoisa-clearings.il models/pseudoisa-metrics.il

test-order1: first_order/basic_gadgets_a.il first_order/firstref_sni.il first_order/basic_gadgets.il first_order/asmgadgets_order1-obj.il first_order/firstxor.il first_order/asmgadgets_order1.il first_order/firstmult_sni.il

test-order2: second_order/asmgadgets_order2-obj.il second_order/secxor.il second_order/secref_sni.il second_order/basic_gadgets.il second_order/secmult_sni_rrnd.il second_order/asmgadgets_order2.il

test-presentorder1: present/first_order/sbox_gadgets_check.il present/first_order/present_a.il present/first_order/sbox_gadgets.il present/first_order/present.il present/first_order/sbox_gadgets_a.il

test-presentorder2: present/second_order/sbox_gadgets.il present/second_order/present.il

test-all: test-models test-order1 test-order2 test-presentorder1 test-presentorder2
