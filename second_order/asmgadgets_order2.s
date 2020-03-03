        // Copyright 2020 - NXP, TU Darmstadt
        // SPDX-License-Identifier: AGPL-3.0-or-later
        //
        // the calling convention here is
        // to always get an entropy pointer which has a public scratch memory at offset 0
        // it is incremented to provide a scratch position followed by unused entropy

        .syntax unified
        .cpu    cortex-m0plus
        .thumb
	.text
	.align  2

	.global xorOrder2
        .align  2
        .thumb
        .thumb_func
        .type xorOrder2 STT_FUNC
	// xorOrder2(uint32_t *entropy, uint32_t output[3], uint32_t input1[3], uint32_t input2[3])
	// r0 entropy ptr, r1 *output ptr, r2 *input1 ptr, r3 *input2
xorOrder2:
        PUSH    {r4, r5, r6, r7}
        LDR     r4, [r2, #0]
        LDR     r5, [r3, #0]
        EORS    r4, r5
        STR     r4, [r1, #0]
        ANDS    r0, r0                  // clear_opB
        STR     r0, [r0, #0]            // clear_opW
        LDR     r6, [r2, #4]
        LDR     r7, [r3, #4]
        EORS    r7, r6
        STR     r7, [r1, #4]
        MOVS    r6, r0                  // clear_opB, scrub(r6)
        LDR     r4, [r0, #0]            // clear_opR, scrub(r4)
        STR     r0, [r0, #0]            // clear_opW
        LDR     r5, [r2, #8]
        LDR     r6, [r3, #8]
        EORS    r5, r6
        STR     r5, [r1, #8]
        MOVS    r4, r0                  // scrub(r4)
        MOVS    r7, r0                  // clear_opB, scrub(r7), clear_flags
        POP     {r4, r5, r6, r7}
        STR     r0, [r0, #0]            // clear_opW
        BX      lr

	.global andOrder2
        .align  2
        .thumb
        .thumb_func
        .type andOrder2 STT_FUNC
	// andOrder2(uint32_t *entropy, uint32_t output[3], uint32_t input1[3], uint32_t input2[3])
	// r0 entropy ptr, r1 *output ptr, r2 *input1 ptr, r3 *input2
andOrder2:
	PUSH    {r4, r5, r6, r7}
        LDR     r5, [r2, #0]
        LDR     r4, [r3, #0]
        ANDS    r4, r5
        LDR     r6, [r0, #4]
        EORS    r6, r4
        ANDS    r0, r0          // clear_opA, clear_opB
        LDR     r7, [r3, #4]
        ANDS    r7, r5
        EORS    r6, r7
        ANDS    r0, r0
        LDR     r4, [r0, #0]    // scrub(r4), clear_opR, clear_opB
        LDR     r4, [r2, #4]
        LDR     r5, [r3, #0]
        ANDS    r0, r0          // clear_opA, clear_opB
        ANDS    r4, r5
        EORS    r6, r4
        ANDS    r0, r0          // clear_opA, clear_opB
        LDR     r5, [r0, #0]    // scrub(r5), clear_opR, clear_opB
        LDR     r5, [r0, #8]
        EORS    r6, r5
        STR     r6, [r1, #0]
        ANDS    r0, r0          // clear_opA, clear_opB
        STR     r0, [r0, #0]    // clear_opW
        LDR     r4, [r0, #0]    // scrub(r4), clear_opR
        ANDS    r0, r0          // clear_opA, clear_opB
        MOVS    r5, r0          // scrub(r5)
        ANDS    r0, r0          // clear_opA, clear_opB
        MOVS    r7, r0          // scrub(r7)
        LDR     r5, [r2, #4]
        LDR     r4, [r3, #4]
        ANDS    r4, r5
        LDR     r6, [r0, #8]
        EORS    r6, r4
        ANDS    r0, r0          // clear_opA, clear_opB
        LDR     r7, [r3, #8]
        ANDS    r7, r5
        EORS    r6, r7
        ANDS    r0, r0          // clear_opA, clear_opB
        LDR     r4, [r0, #0]    // scrub(r4), clear_opR, clear_opB
        LDR     r4, [r2, #8]
        ANDS    r0, r0          // clear_opA, clear_opB
        LDR     r5, [r3, #4]
        ANDS    r0, r0          // clear_opA, clear_opB
        ANDS    r4, r5
        EORS    r6, r4
        ANDS    r0, r0          // clear_opA
        LDR     r5, [r0, #0]    // scrub(r4), clear_opR, clear_opB
        LDR     r5, [r0, #12]
        EORS    r6, r5
        STR     r6, [r1, #4]
        STR     r0, [r0, #0]    // clear_opW
        ANDS    r0, r0          // clear_opA, clear_opB
        LDR     r4, [r0, #0]    // scrub(r4), clear_opR
        ANDS    r0, r0          // clear_opA, clear_opB
        MOVS    r5, r0          // scrub(r5)
        ANDS    r0, r0          // clear_opA, clear_opB
        MOVS    r7, r0          // scrub(r7)
        LDR     r5, [r2, #8]
        LDR     r4, [r3, #8]
        ANDS    r4, r5
        LDR     r6, [r0, #12]
        EORS    r6, r4
        ANDS    r0, r0          // clear_opA, clear_opB
        LDR     r7, [r3, #0]
        ANDS    r7, r5
        EORS    r6, r7
        ANDS    r0, r0          // clear_opA, clear_opB
        LDR     r4, [r0, #0]    // scrub(r4), clear_opR
        LDR     r4, [r2, #0]
        LDR     r5, [r3, #8]
        ANDS    r0, r0          // clear_opA, clear_opB
        ANDS    r4, r5
        EORS    r6, r4
        ANDS    r0, r0          // clear_opA, clear_opB
        LDR     r5, [r0, #0]    // scrub(r5), clear_opR
        LDR     r5, [r0, #4]
        EORS    r6, r5
        STR     r6, [r1, #8]
        LDR     r4, [r0, #0]    // scrub(r4), clear_opR, clear_opB
        POP     {r4, r5, r6, r7}
        STR     r0, [r0, #12]   // clear_opW, prepare scratch out
        ADDS    r0, r0, #12     // clear_opA, clear_opB
	BX lr

	.global refOrder2
        .align  2
        .thumb
        .thumb_func
        .type refOrder2 STT_FUNC
	// refOrder2(uint32_t *entropy, uint32_t output[3], uint32_t input[3])
	// r0 = entropy ptr, r1 = output ptr, r2 = input ptr
refOrder2:
	PUSH    {r4, r5, r6}
        LDR     r4, [r0, #4]
        LDR     r6, [r2, #0]
        LDR     r5, [r0, #0]    // clear_opR
        LDR     r5, [r0, #8]
        EORS    r6, r4
        STR     r6, [r1, #0]
        STR     r0, [r0, #0]    // clear_opW
        LDR     r6, [r0, #0]    // scrub(r6), clear_opR
        LDR     r3, [r2, #4]
        ANDS    r0, r0          // clear_opA, clear_opB
        EORS    r3, r5
        STR     r3, [r1, #4]
        STR     r0, [r0, #0]    // clear_opW
        ANDS    r0, r0          // clear_opA, clear_opB
        EORS    r4, r5
        LDR     r5, [r0, #0]    // scrub(r5), clear_opR
        ANDS    r0, r0          // clear_opA, clear_opB
        LDR     r5, [r2, #8]
        EORS    r5, r4
        STR     r5, [r1, #8]
        POP     {r4, r5, r6}
        EORS    r3, r3
        STR     r0, [r0, #8]   // clear_opW, prepare scratch out
        ADDS    r0, r0, #8     // clear_opA, clear_opB
	BX      lr

	.global notOrder2
        .align  2
        .thumb
        .thumb_func
        .type notOrder2 STT_FUNC
	// notOrder2(uint32_t *entropy, uint32_t input[3])
	// r0 *entropy, r1 *input1  == * output
        // in-place modification of input
notOrder2:
        LDR     r2, [r1, #0]
        MVNS    r2, r2
        STR     r2, [r1, #0]
        LDR     r2, [r0, #0]            // scrub(r2), clear_opR
        STR     r2, [r0, #0]            // clear_opW
        ADDS    r0, r0, #0              // clear flags, clear_opA, clear_opB, scrub(r2)
        BX      lr

        .global cpyOrder2
        .align  2
        .thumb
        .thumb_func
        .type cpyOrder2 STT_FUNC
        // cpyOrder2(uint32_t *entropy, uint32_t output[3], uint32_t input1[3])
        // r0 entropy ptr, r1 *output ptr, r2 *input1 ptr
cpyOrder2:
        LDR     r3, [r2, #0]
        STR     r3, [r1, #0]
        ANDS    r0, r0                  // clear_opA, clear_opB
        STR     r0, [r0, #0]            // clear_opW
        LDR     r0, [r0, #0]            // scrub(r3), clear_opR
        LDR     r3, [r2, #4]
        STR     r3, [r1, #4]
        ANDS    r0, r0                  // clear_opA, clear_opB
        STR     r0, [r0, #0]            // clear_opW
        LDR     r0, [r0, #0]            // scrub(r3), clear_opR
        LDR     r3, [r2, #8]
        STR     r3, [r1, #8]
        ANDS    r0, r0                  // clear_opA, clear_opB
        STR     r0, [r0, #0]            // clear_opW
        LDR     r0, [r0, #0]            // scrub(r3), clear_opR
        BX      lr

        .global leakOrder2
        .align  2
        .thumb
        .thumb_func
        .type leakOrder2 STT_FUNC
	// leakOrder2(uint32_t *entropy, uint32_t input[3])
	// r0 entropy ptr, r1 *input1 ptr
leakOrder2:
        LDR     r2, [r1, #0]
        LDR     r3, [r1, #4]
        EORS    r2, r3
        ANDS    r0, r0                  // clear_opA, clear_opB
        LDR     r3, [r1, #8]
        EORS    r2, r3                  // leakage
        EORS    r2, r2                  // scrub(r2), still leakage
        ANDS    r0, r0                  // clear_opA, clear_opB, still leakage
        LDR     r3, [r0, #0]            // scrub(r3), clear_opR
        STR     r3, [r0, #0]            // clear_opW
        ANDS    r0, r0                  // clear_opA, clear_opB
        ADDS    r0, r0, #0              // clear flags
        BX      lr


        // Local Variables:
        // eval: (setq default-directory (concat (file-name-directory buffer-file-name) "..") compile-command (concat "scverif --il " (concat (file-name-directory buffer-file-name) "asmgadgets_order2.il")))
        // End:
