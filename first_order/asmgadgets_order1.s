	// Copyright 2020 - NXP, Ruhr University Bochum, TU Darmstadt
    // the calling convention here is
    // to always get an entropy pointer which has a public scratch memory at offset 0
    // it is incremented to provide a scratch position followed by unused entropy

    .syntax unified
    .cpu    cortex-m0plus
    .thumb
	.text
	.align  2

	.global xorOrder1
    .align  2
    .thumb
    .thumb_func
    .type xorOrder1 STT_FUNC
	// xorOrder1(uint32_t *entropy, uint32_t output[2], uint32_t input1[2], uint32_t input2[2])
	// r0 entropy ptr, r1 *output ptr, r2 *input1 ptr, r3 *input2
xorOrder1:
	PUSH    {r4, r5}
	LDR     r4, [r2, #0]
	LDR     r5, [r3, #0]
	EORS    r4, r5
	STR     r4, [r1, #0]
	STR     r0, [r1, #4]            // clear_opW
	LDR     r5, [r2, #4]
	LDR     r4, [r1, #4]            // scrub(r4), clear_opR
	LDR     r4, [r3, #4]
	EORS    r4, r5
	STR     r4, [r1, #4]
    ANDS    r0, r0                  // clear_flags
	STR     r0, [r0, #0]            // clear_opW
	POP     {r4, r5}
	BX      lr

	.global andOrder1
    .align  2
    .thumb
    .thumb_func
    .type andOrder1 STT_FUNC
	// andOrder1(uint32_t *entropy, uint32_t output[2], uint32_t input1[2], uint32_t input2[2])
	// r0 entropy ptr, r1 *output ptr, r2 *input1 ptr, r3 *input2
andOrder1:
	PUSH    {r4, r5, r6, r7}
	LDR     r4, [r3, #0]
	LDR     r5, [r2, #0]
	ANDS    r4, r5
	LDR     r6, [r0, #4]
	EORS    r6, r4
	LDR     r7, [r3, #4]
	ANDS    r5, r7
	EORS    r5, r6
	STR     r5, [r1, #0]
	STR     r0, [r1, #4]    // clear_opW
	EORS    r4, r4          // scrub(r4)
	EORS    r6, r6          // scrub(r6)
	LDR     r4, [r2, #4]
	ANDS    r7, r4
    LDR     r6, [r0, #4]
    EORS    r6, r7
    LDR     r5, [r3, #0]
	ANDS    r5, r4
	EORS    r6, r5
	STR     r6, [r1, #4]
	POP     {r4, r5, r6, r7}
	ADDS    r0, r0, #4      // clear_flags
	STR     r0, [r0, #0]	// clear_opW
	BX      lr

	.global refOrder1
    .align  2
    .thumb
    .thumb_func
    .type refOrder1 STT_FUNC
	// refOrder1(uint32_t *entropy, uint32_t output[2], uint32_t input[2])
	// r0 = entropy ptr, r1 = output ptr, r2 = input ptr
refOrder1:
	PUSH    {r4, r5}
	LDR     r3, [r2, #0]
	LDR     r4, [r0, #4]
	EORS    r3, r4
	STR     r3, [r1, #0]
	STR     r0, [r0, #0]    // clear_opW
	LDR     r5, [r2, #4]
	EORS    r5, r4
	STR     r5, [r1, #4]
	POP     {r4, r5}
    EORS    r3, r3
	ADDS    r0, r0, #4      // STMIA r0!, {r0}
	STR     r0, [r0, #0]
	BX      lr

	.global notOrder1
    .align  2
    .thumb
    .thumb_func
    .type notOrder1 STT_FUNC
	// notOrder1(uint32_t *entropy, uint32_t input[2])
	// r0 *entropy, r1 *input1  == * output
    // in-place modification of input
notOrder1:
	LDR     r2, [r1, #0]
	MVNS    r2, r2
	STR     r2, [r1, #0]
    LDR     r2, [r0, #0]    // scrub(r2), clear_opR
    STR     r2, [r0, #0]    // clear_opW
    ANDS    r0, r0			// clear flags, clear_opA, clear_opB
	BX      lr

	.global leakOrder1
    .align  2
    .thumb
    .thumb_func
    .type leakOrder1 STT_FUNC
	// leakage(uint32_t *entropy, uint32_t input[2])
	// r0 entropy ptr, r1 *input1 ptr
leakOrder1:
	LDR     r2, [r1, #0]
	LDR		r3, [r0, #0]	// clear_opR, clear_opB
	LDR     r1, [r1, #4]
	EORS    r2, r1			// leakage
    LDR     r2, [r0, #0]    // scrub(r2), clear_opR, still leakage
    STR     r2, [r0, #0]    // clear_opW
    ANDS    r0, r0          // clear flags, clear_opA, clear_opB
	BX      lr

    // Local Variables:
    // eval: (setq default-directory (concat (file-name-directory buffer-file-name) "..") compile-command (concat "scverif --il " (concat (file-name-directory buffer-file-name) "asmgadgets_order1.il")))
    // End:
