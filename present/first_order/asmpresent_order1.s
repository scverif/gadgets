        // Copyright 2020 - NXP, TU Darmstadt
        // SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications
	//
        // the calling convention here is
        // to always get an entropy pointer which has a public scratch memory at offset 0
        // it is incremented to provide a scratch position followed by unused entropy

        .syntax unified
        .cpu    cortex-m0plus
        .thumb
        .text
        .align  2

        .global calcAOrder1
        .align  2
        .thumb
        .thumb_func
        .type calcAOrder1 STT_FUNC
        // calcAOrder1(
        //   uint32_t *entropy,
        //   uint32_t outputs[2][4],
        //   uint32_t inputs[2][4]
        // )
        // r0 entropy ptr, r1 *outputs, r2 *inputs
calcAOrder1:
        PUSH    {r4, r5, r6, lr}
        LDR     r4, [r2, #0]
        STR     r4, [r1, #16]
        LDR     r5, [r2, #16]
        EORS    r5, r4
        STR     r5, [r1, #0]
        MVNS    r5, r5
        LDR     r6, [r2, #24]
        EORS    r5, r6
        STR     r5, [r1, #24]
        LDR     r5, [r2, #8]
        MVNS    r5, r5
        STR     r5, [r1, #8]
        // second share
        LDR     r5, [r2, #4]
        STR     r5, [r1, #20]
        ANDS    r0, r0                  // clear(opB)
        LDR     r4, [r2, #20]
        ANDS    r0, r0                  // clear(opB)
        EORS    r4, r5
        STR     r4, [r1, #4]
        ANDS    r0, r0                  // clear(opB)
        LDR     r5, [r2, #28]
        ANDS    r0, r0                  // clear(opB)
        EORS    r4, r5
        STR     r4, [r1, #28]
        LDR     r5, [r2, #12]
        STR     r5, [r1, #12]
        ANDS    r0, r0                  // clear(opA), clear(opB)
        STR     r0, [r0, #0]            // clear(opW)
        POP     {r4, r5, r6, pc}        // scrub(r4), scrub(r5), scrub(r6)

        .global calcBOrder1
        .align  2
        .thumb
        .thumb_func
        .type calcBOrder1 STT_FUNC
        // calcBOrder1(
        //   uint32_t *entropy,
        //   uint32_t outputs[2][4],
        //   uint32_t inputs[2][4]
        // )
        // r0 entropy ptr, r1 *outputs, r2 *inputs
calcBOrder1:
        PUSH    {r4, r5, r6, lr}
        LDR     r4, [r2, #8]
        LDR     r5, [r2, #24]
        EORS    r5, r4
        MVNS    r5, r5
        STR     r5, [r1, #24]
        LDR     r6, [r2, #0]
        EORS    r6, r4
        STR     r6, [r1, #0]
        LDR     r5, [r2, #16]
        EORS    r4, r5
        LDR     r6, [r0, #4]
        EORS    r4, r6
        STR     r4, [r1, #8]
        STR     r5, [r1, #16]
        // second share
        LDR     r4, [r2, #12]
        LDR     r5, [r2, #28]
        EORS    r5, r4
        STR     r5, [r1, #28]
        LDR     r6, [r2, #4]
        EORS    r6, r4
        STR     r6, [r1, #4]
        LDR     r5, [r2, #20]
        EORS    r4, r5
        LDR     r6, [r0, #4]
        EORS    r4, r6
        STR     r4, [r1, #12]
        STR     r5, [r1, #20]
        ADDS    r0, #4                  // clear(opA), clear(opB)
        STR     r0, [r0, #0]            // clear(opW)
        POP     {r4, r5, r6, pc}        // scrub(r4), scrub(r5), scrub(r6)


        .global calcGOrder1
        .align  2
        .thumb
        .thumb_func
        .type calcGOrder1 STT_FUNC
        // calcGOrder2(
        //   uint32_t *entropy,
        //   uint32_t outputs[2][4],
        //   uint32_t inputs[2][4]
        // )
        // r0 entropy ptr, r1 *outputs, r2 *inputs
calcGOrder1:
        PUSH    {r4, r5, r6, r7, lr}
        LDR     r4, [r2, #8]
        LDR     r6, [r2, #20]
        ANDS    r6, r4
        LDR     r5, [r2, #24]
        ANDS    r5, r4
        EORS    r6, r5
        LDR     r7, [r0, #4]
        EORS    r6, r7
        LDR     r7, [r0, #8]
        EORS    r5, r7
        LDR     r7, [r2, #16]
        EORS    r5, r7
        ANDS    r7, r4
        EORS    r6, r7
        LDR     r7, [r2, #28]
        ANDS    r7, r4
        EORS    r5, r7
        STR     r5, [r1, #24]
        LDR     r5, [r0, #0]    // clear(opR)
        LDR     r5, [r2, #0]
        EORS    r6, r5
        ANDS    r5, r4
        ANDS    r0, r0          // clear(opA)
        EORS    r6, r7
        STR     r6, [r1, #0]
        LDR     r6, [r2, #24]
        ANDS    r0, r0          // clear(opB)
        EORS    r5, r6
        STR     r4, [r1, #16]
        LDR     r7, [r0, #0]    // clear(opR)
        LDR     r7, [r2, #4]
        ANDS    r4, r7
        LDR     r7, [r0, #12]
        ANDS    r0, r0          // clear(opB)
        EORS    r5, r7
        ANDS    r0, r0          // clear(opA), clear(opB)
        EORS    r5, r4
        STR     r5, [r1, #8]
        // second output share
        ANDS    r0, r0          // clear(opB)
        LDR     r7, [r2, #12]
        ANDS    r0, r0          // clear(opB)
        LDR     r5, [r2, #16]
        ANDS    r5, r7
        ANDS    r6, r7
        // -----------------------------------------*/
        EORS    r5, r6
        ANDS    r0, r0          // clear(opB)
        LDR     r4, [r0, #4]
        ANDS    r0, r0          // clear(opB)
        EORS    r5, r4
        LDR     r4, [r0, #8]
        EORS    r6, r4
        LDR     r4, [r2, #20]
        EORS    r6, r4
        ANDS    r4, r7
        EORS    r5, r4
        LDR     r4, [r2, #28]
        ANDS    r4, r7
        EORS    r6, r4
        STR     r6, [r1, #28]
        LDR     r6, [r2, #4]
        EORS    r5, r6
        ANDS    r6, r7
        ANDS    r0, r0          // clear(opA)
        EORS    r5, r4
        STR     r5, [r1, #4]
        LDR     r5, [r2, #28]
        ANDS    r0, r0          // clear(opB)
        EORS    r6, r5
        STR     r7, [r1, #20]
        LDR     r4, [r0, #0]    // scrub(r4), clear(opR)
        LDR     r4, [r2, #0]
        ANDS    r0, r0          // clear(opB)
        ANDS    r7, r4
        LDR     r4, [r0, #12]
        ANDS    r0, r0          // clear(opB)
        EORS    r6, r4
        ANDS    r0, r0          // clear(opA), clear(opB)
        EORS    r5, r4
        STR     r5, [r1, #12]
        ADDS    r0, #12         // clear(opA), clear(opB)
        STR     r0, [r0, #0]    // clear(opW), prepare scratch
        POP     {r4, r5, r6, r7, pc}    // scrub(r4), scrub(r5), scrub(r6), scrub(r7);


        .global presentOrder1
        .align  2
        .thumb
        .thumb_func
        .type presentOrder1 STT_FUNC
        // presentOrder1(
        //   uint32_t *entropy,
        //   uint32_t outputs[2][4],
        //   uint32_t inputs[2][4]
        // )
        // r0 entropy ptr, r1 *outputs, r2 *inputs
presentOrder1:
        PUSH    {lr}
        MOV     r3, r1
        SUB     sp, #32
        MOV     r1, sp
.psL1:  // labels needed for GAS checking with scverif, remove for assembling
        BL      calcBOrder1             // write to stack, read from input buffer
.psL1+4:
        MOV     r2, r1
        MOV     r1, r3
.psL2:
        BL      calcGOrder1             // write to output buffer, read from stack
.psL2+4:
        MOV     r2, r1
        MOV     r1, sp
.psL3:
        BL      calcGOrder1             // write to stack, read from output buffer
.psL3+4:
        MOV     r2, r1
        MOV     r1, r3
.psL4:
        BL      calcAOrder1             // read from stack, write to output buffer
.psL4+4:
        STMIA   r2!, {r0, r1, r3}   // clear(stack[0:2])
        STMIA   r2!, {r0, r1, r3}   // clear(stack[3:5])
        STMIA   r2!, {r0, r1}       // clear(stack[6:7])
        ADD     sp, #32
        POP     {pc}

        // Local Variables:
        // eval: (setq default-directory (concat (file-name-directory buffer-file-name) "..") compile-command (concat "scverif --il " (concat (file-name-directory buffer-file-name) "asmpresent_order1.il")))
        // End:
