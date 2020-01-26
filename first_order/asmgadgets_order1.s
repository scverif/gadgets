	.text
	.align
        .syntax unified

	.global xorOrder1
	// xorOrder1(uint32_t *entropy, uint32_t output[2], uint32_t input1[2], uint32_t input2[2])
	// r0 entropy ptr, r1 *output ptr, r2 *input1 ptr, r3 *input2
xorOrder1:
	PUSH    {r0, r4, r5}
	LDR     r0, [r2, #0]
	LDR     r4, [r3, #0]
	EORS    r0, r4
	STR     r0, [r1, #0]
	LDR     r4, [r2, #4]
	LDR     r5, [r3, #4]
	EORS    r4, r5
	STR     r0, [r1, #4]
	STR     r4, [r1, #4]
	POP     {r0, r4, r5}
	BX      lr

	.global andOrder1
	// andOrder1(uint32_t *entropy, uint32_t output[2], uint32_t input1[2], uint32_t input2[2])
	// r0 entropy ptr, r1 *output ptr, r2 *input1 ptr, r3 *input2
andOrder1:
	PUSH    {r4, r5, r6, r7}
	LDR     r4, [r3, #0]
	LDR     r5, [r2, #0]
	ANDS    r4, r5
	LDR     r6, [r0, #0]
	EORS    r6, r4
	LDR     r7, [r3, #4]
	ANDS    r5, r7
	EORS    r5, r6
	STR     r5, [r1, #0]
	STR     r0, [r1, #4]
	EORS    r4, r4
	EORS    r6, r6
	LDR     r4, [r2, #4]
	ANDS    r7, r4
	LDR     r6, [r0, #0]
	EORS    r7, r6
	LDR     r5, [r3, #0]
	ANDS    r5, r4
	EORS    r7, r5
	STR     r7, [r1, #4]
	POP     {r4, r5, r6, r7}
	ADDS    r0, r0, #4
	STR     r4, [sp, #-4]
	BX      lr

	.global refOrder1
	// refOrder1(uint32_t *entropy, uint32_t output[2], uint32_t input[2])
	// r0 = entropy ptr, r1 = output ptr, r2 = input ptr
refOrder1:
	PUSH    {r4, r5}
	LDR     r3, [r2, #0]
	LDR     r4, [r0, #0]
	EORS    r3, r4
	STR     r3, [r1, #0]
	STR     r4, [r0, #0]
	LDR     r5, [r2, #4]
	EORS    r5, r4
	STR     r5, [r1, #4]
	POP     {r4, r5}
	ADDS    r0, r0, #4
	BX      lr

	.global notOrder1
	// notOrder1(uint32_t *entropy, uint32_t input[2])
	// r0 entropy ptr, r1 *input1 ptr
        // in-place modification of input
notOrder1:
	LDR     r2, [r1, #0]
	MVNS    r2, r2
	STR     r2, [r1, #0]
	BX      lr

	.global leakage
	// leakage(uint32_t *entropy, uint32_t input[2])
	// r0 entropy ptr, r1 *input1 ptr
leakage:
	LDR     r2, [r1, #0]
	LDMIA   r0!, {r1}
	LDR     r1, [r1, #4]
	EORS    r2, r1
	MOVS    r2, #0
	BX      lr
