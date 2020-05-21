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

        .global calcAOrder2
        .align  2
        .thumb
        .thumb_func
        .type calcAOrder2 STT_FUNC
        // calcAOrder2(
        //   uint32_t *entropy,
        //   uint32_t outputs[3][4],
        //   uint32_t inputs[3][4]
        // )
        // r0 enropy ptr, r1 *outputs, r2 *inputs
calcAOrder2:
        LDR     r4, [r2, #0]    // a0
        STR     r4, [r1, #24]   // c0' //
        LDR     r5, [r2, #24]   // c0
        EORS	r5, r4
        STR	r5, [r1, #0]    // a0'
        MVNS	r5, r5
        LDR	r6, [r2, #36]   // d0
        EORS	r5, r6
        STR	r5, [r1, #36]   // c0' //
        LDR	r5, [r2, #12]   // b0
        MVNS	r5, r5
        STR	r5, [r1, #12]   // b0'
        // second share
        LDR	r5, [r2, #4]    // a1
        STR	r5, [r1, #28]   // c1'
        ANDS    r0, r0          // clear(opB)
        LDR	r4, [r2, #28]   // c1
        ANDS    r0, r0          // clear(opB)
        EORS	r4, r5
        STR	r4, [r1, #4]    // a1'
        LDR	r5, [r2, #40]   // d1
        EORS	r4, r5
        STR	r4, [r1, #40]   // d1'
        LDR	r5, [r2, #16]   // b1
        STR	r5, [r1, #16]   // b1'
        // third share
        LDR	r5, [r2, #8]    // a2
        STR	r5, [r1, #32]   // c2'
        ANDS    r0, r0          // clear(opB)
        LDR	r4, [r2, #32]   // c2
        ANDS    r0, r0          // clear(opB)
        EORS	r4, r5
        STR	r4, [r1, #8]    // a2'
        LDR	r5, [r2, #44]   // d2
        EORS	r4, r5
        STR	r4, [r1, #44]   // d2'
        LDR	r5, [r2, #20]   // b2
        STR	r5, [r1, #20]   // b2'
        BX      lr

        .global calcBOrder2
        .align  2
        .thumb
        .thumb_func
        .type calcBOrder2 STT_FUNC
        // calcBOrder2(
        //   uint32_t *entropy,
        //   uint32_t outputs[3][4],
        //   uint32_t inputs[3][4]
        // )
        // r0 entropy ptr, r1 *outputs, r2 *inputs
calcBOrder2:
        LDR	r4, [r2, #12]   // b0
        LDR	r5, [r2, #36]   // d0
        EORS	r5, r4
        MVNS	r5, r5
        LDR	r6, [r0, #4]    // rnd0
        EORS	r5, r6
        STR	r5, [r1, #36]   // d0'
        LDR	r6, [r2, #0]    // a0
        EORS	r6, r4
        LDR	r5, [r0, #12]   // rnd2
        EORS	r6, r5
        STR	r6, [r1, #0]    // a0'
        LDR	r5, [r2, #24]   // c0
        EORS	r4, r5
        LDR	r6, [r0, #20]   // rnd4
        EORS	r4, r6
        STR	r4, [r1, #12]   // b0'
        LDR	r6, [r0, #28]   // rnd6
        EORS	r5, r6
        STR	r5, [r1, #24]   // c0'
        LDR     r4, [r0, #0]    // scrub(r4), clear(opR)
        STR     r4, [r0, #0]    // clear(opW)
        ADDS    r5, r1, r4      // scrub(r5), clear(opA), clear(opB)
        ADDS    r6, r0, r5      // scrub(r6)
        // second share
        LDR	r4, [r2, #16]   // b1
        LDR	r5, [r2, #40]   // d1
        EORS	r5, r4
        LDR	r6, [r0, #8]    // rnd1
        EORS	r5, r6
        STR	r5, [r1, #40]   // d1'
        LDR	r6, [r2, #4]    // a1
        EORS	r6, r4
        LDR	r5, [r0, #16]   // rnd3
        EORS	r6, r5
        STR	r6, [r1, #4]    // a1'
        LDR	r5, [r2, #28]   // c1
        EORS	r4, r5
        LDR	r6, [r0, #24]   // rnd5
        EORS	r4, r6
        STR	r4, [r1, #16]   // b1'
        LDR	r6, [r0, #32]   // rnd7
        EORS	r5, r6
        STR	r5, [r1, #28]   // c1'
        LDR     r4, [r0, #0]    // scrub(r4), clear(opR)
        STR     r4, [r0, #0]    // clear(opW)
        ADDS    r5, r1, r4      // scrub(r5), clear(opA), clear(opB)
        ADDS    r6, r0, r5      // scrub(r6)
        // third share
        LDR	r4, [r2, #20]   // b2
        LDR	r5, [r2, #44]   // d2
        EORS	r5, r4
        LDR	r6, [r0, #4]    // rnd0
        LDR	r7, [r0, #8]    // rnd1
        EORS	r6, r7
        ANDS    r1, r1          // clear(opA), clear(opB)
        EORS	r5, r6
        STR	r5, [r1, #44]   // d2'
        LDR	r6, [r2, #8]    // a2
        EORS	r6, r4
        MOV     r5, r1          // scrub(r5)
        LDR	r5, [r0, #12]   // rnd2
        LDR	r7, [r0, #16]   // rnd3
        EORS	r5, r7
        ANDS    r1, r1          // clear(opA), clear(opB)
        EORS	r6, r5
        STR	r6, [r1, #8]    // a2'
        LDR	r5, [r2, #32]   // c2
        ANDS    r1, r1          // clear(opB)
        EORS	r4, r5
        MOV     r6, r1          // scrub(r6)
        LDR	r6, [r0, #20]   // rnd4
        LDR	r7, [r0, #24]   // rnd5
        EORS	r6, r7
        ANDS    r1, r1          // clear(opA), clear(opB)
        EORS	r4, r6
        STR	r4, [r1, #20]   // b2'
        MOV     r6, r1          // scrub(r6)
        LDR	r6, [r0, #28]   // rnd6
        LDR	r7, [r0, #32]   // rnd7
        EORS	r6, r7
        ANDS    r1, r1          // clear(opA), clear(opB)
        EORS	r5, r6
        STR	r5, [r1, #32]   // c2'
        ADDS    r4, r0, r1      // scrub(r4)
        ADDS    r5, r2, r0      // scrub(r5)
        ADDS    r6, r2, r1      // scrub(r6)
        ADDS    r7, r5, r4      // scrub(r7)
        ADDS    r0, r0, #32     // clear(opA), increment rnd ptr
        STR     r0, [r0, #0]    // clear(opW), prepare scratch word
        LDR     r0, [r0, #0]    // clear(opR), clear(opB)
        BX      lr

        .global calcGOrder2
        .align  2
        .thumb
        .thumb_func
        .type calcGOrder2 STT_FUNC
        // calcGOrder2(
        //   uint32_t *entropy,
        //   uint32_t outputs[3][4],
        //   uint32_t inputs[3][4]
        // )
        // r0 entropy ptr, r1 *outputs, r2 *inputs
calcGOrder2:
        LDR	r4, [r2, #12]   // b0
        LDR	r5, [r2, #40]   // d1
        LDR	r6, [r2, #28]   // c1
        LDR	r7, [r2, #4]    // a1

        ANDS	r5, r4
        ANDS	r6, r4
        ANDS	r7, r4

        EORS	r6, r5

        ANDS    r1, r1          // 
        LDR     r3, [r0, #0]    // scrub(r3), clear(opR) 
        LDR	r3, [r0, #4]    // rnd0
        ANDS    r1, r1          // clear(opA), clear(opB) 
        EORS	r5, r3
        LDR	r3, [r0, #16]   // rnd3
        EORS	r6, r3
        LDR	r3, [r0, #28]   // rnd6
        EORS	r7, r3

        LDR	r3, [r2, #0]    // a0
        EORS	r6, r3
        ANDS	r3, r4
        EORS	r7, r3
        LDR	r3, [r2, #24]   // c0
        EORS	r5, r3
        ANDS	r3, r4
        EORS	r6, r3

        LDR	r3, [r2, #36]   // d0
        EORS	r7, r3
        ANDS	r3, r4
        EORS	r5, r3
        EORS	r6, r3

        LDR     r3, [r0, #0]    // scrub(r3), clear(opR)
        LDR	r3, [r0, #8]    // rnd1
        ANDS    r1, r1          // clear(opA), clear(opB)
        EORS	r5, r3
        LDR	r3, [r0, #20]   // rnd4
        EORS	r6, r3
        LDR	r3, [r0, #32]   // rnd7
        EORS	r7, r3

        LDR	r3, [r2, #8]    // a2
        ANDS	r3, r4
        EORS	r7, r3
        LDR	r3, [r2, #32]   // c2
        ANDS	r3, r4
        EORS	r6, r3

        LDR	r3, [r2, #44]   // d2
        ANDS	r3, r4
        EORS	r5, r3
        EORS	r6, r3

        STR	r6, [r1, #0]    // a0'
        STR	r7, [r1, #12]   // b0'
        STR	r4, [r1, #24]   // c0'
        STR	r5, [r1, #36]   // d0'

        LDR     r4, [r0, #0]    // scrub(r4), clear(opR)
        STR     r4, [r0, #0]    // clear(opW)
        ADDS    r3, r2, r5      // scrub(r3)
        ADDS    r5, r1, r4      // scrub(r5)
        ADDS    r6, r0, r5      // scrub(r6)
        ADDS    r7, r1, r2      // scrub(r7), clear(opA), clear(opB)

        LDR	r4, [r2, #16]   // b1
        LDR	r5, [r2, #44]   // d2
        LDR	r6, [r2, #32]   // c2
        LDR	r7, [r2, #8]    // a2

        ANDS    r5, r4
        ANDS	r6, r4
        ANDS	r7, r4

        EORS	r6, r5

        LDR     r3, [r0, #0]    // scrub(r3), clear(opR) 
        LDR	r3, [r0, #8]    // rnd1
        ANDS    r1, r1          // clear(opA), clear(opB) 
        EORS	r5, r3
        LDR	r3, [r0, #20]   // rnd4
        EORS	r6, r3
        LDR	r3, [r0, #32]   // rnd7
        EORS	r7, r3

        LDR	r3, [r2, #4]    // a1
        EORS	r6, r3
        ANDS	r3, r4
        EORS	r7, r3
        LDR	r3, [r2, #28]   // c1
        EORS	r5, r3
        ANDS	r3, r4
        EORS	r6, r3

        LDR	r3, [r2, #40]   // d1
        EORS	r7, r3
        ANDS	r3, r4
        EORS	r5, r3
        EORS	r6, r3

        LDR     r3, [r0, #0]    // scrub(r3), clear(opR)
        LDR	r3, [r0, #12]   // rnd2
        ANDS    r1, r1          // clear(opA), clear(opB)
        EORS	r5, r3 //
        LDR	r3, [r0, #24]   // rnd5
        EORS	r6, r3
        LDR	r3, [r0, #36]   // rnd8
        EORS	r7, r3

        LDR	r3, [r2, #0]    // a0
        ANDS	r3, r4
        EORS	r7, r3
        LDR	r3, [r2, #24]   // c0
        ANDS	r3, r4
        EORS	r6, r3

        LDR	r3, [r2, #36]   // d0
        ANDS	r3, r4
        EORS	r5, r3
        EORS	r6, r3

        STR	r6, [r1, #4]    // a1'
        STR	r7, [r1, #16]   // b1'
        STR	r4, [r1, #28]   // c1'
        STR	r5, [r1, #40]   // d1'

        LDR     r4, [r0, #0]    // scrub(r4), clear(opR)
        STR     r4, [r0, #0]    // clear(opW)
        ADDS    r3, r2, r5      // scrub(r3)
        ADDS    r5, r1, r4      // scrub(r5)
        ADDS    r6, r0, r5      // scrub(r6)
        ADDS    r7, r1, r2      // scrub(r7), clear(opA), clear(opB)
        ANDS    r1, r1          // clear(opA), clear(opB)

        LDR	r4, [r2, #20]   // b2
        LDR	r5, [r2, #36]   // d0
        LDR	r6, [r2, #24]   // c0
        LDR	r7, [r2, #0]    // a0

        ANDS	r5, r4
        ANDS	r6, r4
        ANDS	r7, r4

        EORS	r6, r5

        LDR	r3, [r0, #0]    // scrub(r3), clear(opR) 
        LDR	r3, [r0, #12]   // rnd2
        ANDS    r1, r1          // clear(opA), clear(opB) 
        EORS	r5, r3
        LDR	r3, [r0, #24]   // rnd5
        EORS	r6, r3
        LDR	r3, [r0, #36]   // rnd8
        EORS	r7, r3

        LDR	r3, [r2, #8]    // a2
        EORS	r6, r3
        ANDS	r3, r4
        EORS	r7, r3
        LDR	r3, [r2, #32]   // c2
        EORS	r5, r3
        ANDS	r3, r4
        EORS	r6, r3

        LDR	r3, [r2, #44]   // d2
        EORS	r7, r3
        ANDS	r3, r4
        EORS	r5, r3
        EORS	r6, r3

        LDR     r3, [r0, #0]    // scrub(r3), clear(opR)
        LDR	r3, [r0, #4]    // rnd0
        ANDS    r1, r1          // clear(opA), clear(opB)
        EORS	r5, r3
        LDR	r3, [r0, #16]   // rnd3
        EORS	r6, r3
        LDR	r3, [r0, #28]   // rnd6
        EORS	r7, r3

        LDR	r3, [r2, #4]    // a1
        ANDS	r3, r4
        EORS	r7, r3
        LDR	r3, [r2, #28]   // c1
        ANDS	r3, r4
        EORS	r6, r3

        LDR	r3, [r2, #40]   // d1
        ANDS	r3, r4
        EORS	r5, r3
        EORS	r6, r3

        STR	r6, [r1, #8]    // a2'
        STR	r7, [r1, #20]   // b2'
        STR	r4, [r1, #32]   // c2'
        STR	r5, [r1, #44]   // d2'

        LDR     r4, [r0, #0]    // scrub(r4), clear(opR)
        ADDS    r3, r2, r5      // scrub(r3)
        ADDS    r5, r1, r4      // scrub(r5)
        ADDS    r6, r0, r5      // scrub(r6)
        ADDS    r7, r1, r2      // scrub(r7), clear(opA), clear(opB)
        ADDS    r0, r0, #36     // update randomness pointer
        STR     r4, [r0, #0]    // clear(opW), prepare scratch
        BX      lr

        .global presentOrder2
        .align  2
        .thumb
        .thumb_func
        .type presentOrder2 STT_FUNC
        // presentOrder2(
        //   uint32_t *entropy,
        //   uint32_t outputs[3][4],
        //   uint32_t inputs[3][4]
        // )
        // r0 entropy ptr, r1 *outputs, r2 *inputs
presentOrder2:
        PUSH    {r4, r5, r6, r7, lr}
        MOV     r8, r1
        SUB     sp, #48
        MOV     r1, sp
.psL1:  // labels needed for GAS checking with scverif, remove for assembling
        BL      calcBOrder2             // write to stack, read from input buffer
.psL1+4:
        MOV     r2, r1
        MOV     r1, r8
.psL2:
        BL      calcGOrder2             // write to output buffer, read from stack
.psL2+4:
        MOV     r2, r1
        MOV     r1, sp
.psL3:
        BL      calcGOrder2             // write to stack, read from output buffer
.psL3+4:
        MOV     r2, r1
        MOV     r1, r8
.psL4:
        BL      calcAOrder2             // read from stack, write to output buffer
.psL4+4:
        MOV     r3, sp
        STMIA   r2!, {r0, r1, r3}   // clear(stack[0:2])
        STMIA   r2!, {r0, r1, r3}   // clear(stack[3:5])
        STMIA   r2!, {r0, r1, r3}   // clear(stack[6:8])
        STMIA   r2!, {r0, r1, r3}   // clear(stack[9:11])
        ADD     sp, #48
        POP     {r4, r5, r6, r7, pc}

        // Local Variables:
        // eval: (setq default-directory (concat (file-name-directory buffer-file-name) "../..") compile-command (concat "scverif --il " (concat (file-name-directory buffer-file-name) "asmpresent_order2.il")))
        // End:
