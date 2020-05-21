# Copyright 2020 - NXP
# SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications

.PHONY: all

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

test-order1: $(wildcard first_order/*.il)

test-order2: $(wildcard second_order/*.il)

test-presentorder1: $(wildcard present/first_order/*.il)

test-presentorder2: $(wildcard present/second_order/*.il)

test-all: test-models test-order1 test-order2 test-presentorder1 test-presentorder2
