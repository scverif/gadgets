        // Copyright 2020 - NXP, TU Darmstadt
        // the calling convention here is
        // to always get an entropy pointer which has a public scratch memory at offset 0
        // it is incremented to provide a scratch position followed by unused entropy

        .syntax unified
        .cpu    cortex-m0plus
        .thumb
        .text
        .align  2

        .global presentOrder1
        .align  2
        .thumb
        .thumb_func
        .type presentOrder1 STT_FUNC
        // presentOrder2(
        //   uint32_t *entropy,
        //   uint32_t outputs[2][4],
        //   uint32_t inputs[2][4]
        // )
        // r0 entropy ptr, r1 *outputs, r2 *inputs
presentOrder1:
        PUSH    {r4, r5, r6, r7}
        BL      calcBOrder1
        BL      calcGOrder1
        BL      calcGOrder1
        BL      calcAOrder1
        POP     {r4, r5, r6, r7}

        .global calcAOrder1
        .align  2
        .thumb
        .thumb_func
        .type calcAOrder1 STT_FUNC
        // calcAOrder2(
        //   uint32_t *entropy,
        //   uint32_t outputs[2][4],
        //   uint32_t inputs[2][4]
        // )
        // r0 entropy ptr, r1 *outputs, r2 *inputs
calcAOrder1:
        PUSH    {r8, r9}
        MOV     r8, r1          // r8 *outputs
        MOV     r9, r2          // r9 *inputs
        ADDS    r3, r9, #16     // c_in
        BL      xorOrder1       // r1 = a_out, r2 = a_in, r3 = c_in
        BL      notOrder1       // r1 = a_out, r2 = a_in, r3 = c_in
        BL      memcpyOrder1
        BL      xorOrder1
        BL      xorOrder1
        BL      notOrder1
        POP     {r8, r9}

        .global calcBOrder1
        .align  2
        .thumb
        .thumb_func
        .type calcBOrder1 STT_FUNC
        // calcBOrder2(
        //   uint32_t *entropy,
        //   uint32_t outputs[2][4],
        //   uint32_t inputs[2][4]
        // )
        // r0 entropy ptr, r1 *outputs, r2 *inputs
calcBOrder1:
        PUSH    {r4, r5, r6, r7}
        MOV     r1                      // d_out
        BL      andOrder1
        BL      xorOrder1
        POP     {r4, r5, r6, r7}

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
        PUSH    {r4, r5, r6, r7}
        MOV     r1                      // d_out
        BL      andOrder1
        BL      xorOrder1
        POP     {r4, r5, r6, r7}


        .global presentoptOrder1
        .align  2
        .thumb
        .thumb_func
        .type presentoptOrder1 STT_FUNC
        // presentOrder2(
        //   uint32_t *entropy,
        //   uint32_t outputs[2][4],
        //   uint32_t inputs[2][4]
        // )
        // r0 entropy ptr, r1 *outputs, r2 *inputs
presentoptOrder1:
        PUSH    {r4, r5, r6, r7}
        BL      calcBoptOrder1
        BL      calcGoptOrder1
        BL      calcGoptOrder1
        BL      calcAoptOrder1
        POP     {r4, r5, r6, r7}

        // Local Variables:
        // eval: (setq default-directory (concat (file-name-directory buffer-file-name) "..") compile-command (concat "scverif --il " (concat (file-name-directory buffer-file-name) "asmpresent_order1.il")))
        // End:
