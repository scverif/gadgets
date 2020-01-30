// Copyright 2020 - TU Darmstadt, Ruhr University Bochum, NXP

        .text
	.align
        .syntax unified

	.global xorMaskedOrder2
	//xorMaskedOrder2( uint32_t output[ 3 ], uint32_t input1[ 3 ], uint32_t input2[ 3 ], uint32_t entropy[ 2 ] )
	//R0 output, R1 input1 pointer, R2 input2 pointer, R3 entropy pointer
xorMaskedOrder2:
	PUSH {R4-R5}

	ldr r4, [r1, #0]	//r4: a0
	ldr r5, [r2, #0]	//r5: b0
	eors r4, r5			//r4: a0+b0		<- a0
	ldr r5, [r3, #0]	//r5: e0			<- b0
	eors r4, r5			//r4: a0+b0+e0	<- a0+b0
	str r4, [r0, #0]

	//clear_opA()//
	//clear_opB()//
	//clear_opR()//
	//clear_opW()//

	ldr r5, [r1, #4]	//r5: a1			<- e0
	ldr r4, [r2, #4]	//r4: b1			<- a0+b0+e0
	eors r5, r4			//r5: a1+b1		<- a1
	ldr r4, [r3, #4]	//r4: e1			<- b1
	eors r5, r4			//r5: a1+b1+e1	<- a1+b1
	str r5, [r0, #4]

	//clear_opA()//
	//clear_opB()//
	//clear_opR()//
	//clear_opW()//

	ldr r4, [r3, #0]	//r4: e0			<- e1
	ldr r5, [r3, #4]	//r5: e1			<- e1	Why?
	//eors r4, r5		//r4: e0+e1		<- e0
	//ldr r4, [r1, #8]	//r4: a2			<- e0+e1
	//eors r4, r5		//r4: a2+e1		<- a2
	//ldr r5, [r2, #8]	//r5: b2			<- e1
	//eors r4, r5		//r4: a2+e1+b2	<- a2+e1

	//Corrected:
	eors r5, r4			//r5: e1+e0			<- e1
	ldr r4, [r1, #8]	//r4: a2				<- e0
	eors r4, r5			//r4: a2+e1+e0		<- a2
	ldr r5, [r2, #8]	//r5: b2				<- e1
	eors r4, r5			//r4: a2+e1+e0+b2	<- a2+e1
	str r4, [r0, #8]

	POP {R4-R5}
	bx lr

	.global andMaskedOrder2
	//andMaskedOrder2( uint32_t output[ 3 ], uint32_t input1[ 3 ], uint32_t input2[ 3 ], uint32_t *entropy )
	//R0 output, R1 input1 pointer, R2 input2 pointer, R3 entropy pointer
andMaskedOrder2:
	LDR r5, [r1, #0]		//r5: a0
	LDR r4, [r2, #0]		//r4: b0
	ANDS r4, r4, r5			//r4: b0*a0						<- b0
	LDR r6, [r3, #0]		//r6: e0
	EORS r6, r6, r4			//r6: e0+b0*a0					<- e0
	ANDS r0, r0				//clear_opB()///*Load Operand*/
	LDR r7, [r2, #4]		//r7: b1
	ANDS r7, r7, r5			//r7: b1*a0						<- b1
	EORS r6, r6, r7			//r6: e0+b0*a0+b1*a0	<- e0+b0*a0
	MOVS r4, #0				//load_pub(r4)///*Load Transition*/
	LDR r4, [r1, #4]		//r4: a1							<- 0
	LDR r5, [r2, #0]		//r5: b0							<- a0
	ANDS r4, r4, r5			//r4: a1*b0						<- a1
	EORS r6, r6, r4			//r6: e0+b0*a0+b1*a0+a1*b0		<- e0+b0*a0+b1*a0
	ANDS r0, r0				//clear_opA()///*Xor OparANDS A*/

	MOVS r5, #0				//load_pub(r5)///*Load Transition*/
	LDR r5, [r3, #4]		//r5: e1							<- 0
	EORS r6, r6, r5			//r6: e0+b0*a0+b1*a0+a1*b0+e1	<- e0+b0*a0+b1*a0+a1*b0
	STR r6, [r0, #0]

	STR r0, [r0, #4]		//clear_opW()//
	MOVS r4, #0				//load_pub(r4)//
	MOVS r5, #0				//load_pub(r5)//
	MOVS r7, #0				//load_pub(r7)//


	LDR r5, [r1, #4]		//r5: a1							<- 0
	LDR r4, [r2, #4]		//r4: b1							<- 0
	ANDS r4, r4, r5			//r4: b1*a1						<- b1
	LDR r6, [r3, #4]		//r6: e1							<- e0+b0*a0+b1*a0+a1*b0+e1
	EORS r6, r6, r4			//r6: e1+b1*a1					<- e1
	ANDS r0, r0				//clear_opB()//
	LDR r7, [r2, #8]		//r7: b2							<- 0
	ANDS r7, r7, r5			//r7: b2*a1						<- b2
	EORS r6, r6, r7			//r6: e1+b1*a1+b2*a1				<- e1+b1*a1
	MOVS r4, #0				//load_pub(r4)//
	MOVS r5, #0				//load_pub(r5)//
	LDR r5, [r1, #8]		//r5: a2							<- 0
	LDR r4, [r2, #4]		//r4: b1							<- 0
	ANDS r4, r4, r5			//r4: b1*a2						<- b1
	EORS r6, r6, r4			//r6: e1+b1*a1+b2*a1+b1*a2		<- e1+b1*a1+b2*a1
	ANDS r0, r0				//clear_opA()//
	MOVS r5, #0				//load_pub(r5)//
	LDR r5, [r3, #8]		//r5: e2							<- 0
	EORS r6, r6, r5			//r6: e1+b1*a1+b2*a1+b1*a2+e2	<- e1+b1*a1+b2*a1+b1*a2
	STR r6, [r0, #4]

	STR r0, [r0, #8]		//clear_opW()//
	MOVS r4, #0				//load_pub(r4)//
	MOVS r5, #0				//load_pub(r5)//


	LDR r5, [r1, #8]		//r5: a2							<- 0
	LDR r4, [r2, #8]		//r4: b2							<- 0
	ANDS r4, r4, r5			//r4: b2*a2						<- b2
	LDR r6, [r3, #8]		//r6: e2							<- e1+b1*a1+b2*a1+b1*a2+e2
	EORS r6, r6, r4			//r6: e2+b2*a2					<- e2
	MOVS r4, #0				//load_pub(r4)//
	LDR r4, [r2, #0]		//r4: b0							<- 0
	ANDS r4, r4, r5			//r4: b0*a2						<- b0
	EORS r6, r6, r4			//r6: e2+b2*a2+b0*a2				<- e2+b2*a2
	MOVS r4, #0				//load_pub(r4)//
	MOVS r5, #0				//load_pub(r5)//
	LDR r5, [r1, #0]		//r5: a0							<- 0
	LDR r4, [r2, #8]		//r4: b2							<- 0
	ANDS r4, r4, r5			//r4: b2*a0						<- b2
	EORS r6, r6, r4			//r6: e2+b2*a2+b0*a2+b2*a0		<- e2+b2*a2+b0*a2
	ANDS r0, r0				//clear_opA()//
	MOVS r5, #0				//load_pub(r5)//
	LDR r5, [r3, #0]		//r5: e0							<- 0
	EORS r6, r6, r5			//r6: e2+b2*a2+b0*a2+b2*a0+e0	<- e2+b2*a2+b0*a2+b2*a0
	STR r6, [r0, #8]

	.global andMaskedOrder2_5E
	//andMaskedOrder2_5E( uint32_t output[ 3 ], uint32_t input1[ 3 ], uint32_t input2[ 3 ], uint32_t *entropy )
	//R0 output, R1 input1 pointer, R2 input2 pointer, R3 entropy pointer
andMaskedOrder2_5E:
	PUSH {R4-R7}

	//Calculation of the first output-share c0
	//c0 = b0*a0+rnd0+b1*a0+rnd1+rnd3+a0*b2
	//register r5 will contain a0
	//the order of the calculation is chosen to use the loading and xoring of randomness needed to naturaly reset opA and opB
	ldr r5, [r1, #0]	//r5: a0
	ldr r4, [r2, #0]	//r4: b0
	ands r4, r5			//r4: b0*a0							<- b0
	ldr r6, [r3, #0]	//r6: e0
	eors r6, r4			//r6: e0+b0*a0						<- e0
	//rnd3 is preloaded to register r7 to reset opB
	ldr r7, [r3, #12]	//r7: e3
	ldr r4, [r2, #4]	//r4: b1								<- b0*a0		!!!
	ands r4, r5			//r4: b1*a0
	eors r4, r6			//r4: b1*a0+e0+b0*a0					<- b1*a0
	ldr r6, [r3, #4]	//r6: e1								<- e0+b0*a0
	eors r6, r4			//r6: e1+b1*a0+e0+b0*a0				<- e1
	eors r6, r7			//r6: e1+b1*a0+e0+b0*a0+e3			<- e1+b1*a0+e0+b0*a0
	ldr r4, [r2, #8]	//r4: b2								<- b1*a0+e0+b0*a0
	ands r4, r5			//r4: b2*a0							<- b2
	eors r4, r6			//r4: b2*a0+e1+b1*a0+e0+b0*a0+e3		<- b2*a0
	str r4, [r0, #0]

	//register r5 needs to be reset because it contains a0 and a1 is going to be loaded in this register and a0 and a1 can not be leaked together
	//load_pub(r5)//
	MOVS r5, #0			//r5: 0								<- a0
	//opW needs to be reset after each store, because otherwise the next store would leak the last and the current store and one probe would give two output-shares
	//clear_opW()//

	//Calculation of the second output-share c1
	//c1 = b1*a1+rnd1+b2*a1+rnd2+rnd4+b0*a1
	//register r5 will contain a1
	//the order of the calculation is chosen to use the loading and xoring of randomness needed to naturaly reset opA and opB
	ldr r5, [r1, #4]	//r5: a1								<- 0
	ldr r4, [r2, #4]	//r4: b1								<- b2*a0+e1+b1*a0+e0+b0*a0+e3
	ands r4, r5			//r4: b1*a1							<- b1
	ldr r6, [r3, #4]	//r6: e1								<- e1+b1*a0+e0+b0*a0+e3
	eors r6, r4			//r6: e1+b1*a1						<- e1
	//rnd4 is preloaded to register r7 to reset opB
	ldr r7, [r3, #16]	//r7: e4								<- e3
	ldr r4, [r2, #8]	//r4: b2								<- b1*a1		!!!
	ands r4, r5			//r4: b2*a1							<- b2
	eors r4, r6			//r4: b2*a1+e1+b1*a1					<- b2*a1
	ldr r6, [r3, #8]	//r6: e2								<- e1+b1*a1
	eors r6, r4			//r6: e2+b2*a1+e1+b1*a1				<- e2
	eors r6, r7			//r6: e2+b2*a1+e1+b1*a1+e4			<- e2+b2*a1+e1+b1*a1
	ldr r4, [r2, #0]	//r4: b0								<- b2*a1+e1+b1*a1
	ands r4, r5			//r4: b0*a1							<- b0
	eors r4, r6			//r4: b0*a1+e2+b2*a1+e1+b1*a1+e4		<- b0*a1
	str r4, [r0, #4]

	//register r5 needs to be cleared because it contains a1 and a2 is going to be loaded in this register and a1 and a2 can not be leaked together
	//load_pub(r5)//
	MOVS r5, #0			//r5: 0								<- a1
	//clear_opW()//

	//Calculation of the third output-share c2
	//c2 = a2*b2+rnd2+rnd4+a2*b0+rnd0+rnd3+a2*b1
	//register r5 will contain a1
	//the order of the calculation is chosen to use the loading and xoring of randomness needed to naturaly reset opA and opB
	ldr r5, [r1, #8]	//r5: a2								<- 0
	ldr r4, [r2, #8]	//r4: b2								<- b0*a1+e2+b2*a1+e1+b1*a1+e4
	ands r4, r5			//r4: b2*a2							<- b2
	ldr r6, [r3, #8]	//r6: e2								<- e2+b2*a1+e1+b1*a1+e4
	eors r6, r4			//r6: e2+b2*a2						<- e2
	//register r7 still contains rnd4 the following xor is used to reset opB
	eors r6, r7			//r6: e2+b2*a2+e4					<- e2+b2*a2
	ldr r4, [r2, #0]	//r4: b0								<- b2*a2		!!!
	ands r4, r5			//r4: b0*a2							<- b0
	eors r4, r6			//r4: b0*a2+e2+b2*a2+e4				<- b0*a2
	ldr r6, [r3, #0]	//r6: e0								<- e2+b2*a2+e4
	eors r6, r4			//r6: e0+b0*a2+e2+b2*a2+e4			<- e0
	ldr r7, [r3, #12]	//r7: e3								<- e4
	eors r6, r7			//r6: e0+b0*a2+e2+b2*a2+e4+e3		<- e0+b0*a2+e2+b2*a2+e4
	ldr r4, [r2, #4]	//r4: b1								<- b0*a2+e2+b2*a2+e4
	ands r4, r5			//r4: b1*a2							<- b1
	eors r4, r6			//r4: b1*a2+e0+b0*a2+e2+b2*a2+e4+e3	<- b1*a2
	str r4, [r0, #8]

	POP {R4-R7}
	bx lr

	.global andMaskedOrder2_fix
	//andMaskedOrder2_fix( uint32_t output[ 3 ], uint32_t input1[ 3 ], uint32_t input2[ 3 ], uint32_t *entropy )
	//R0 output, R1 input1 pointer, R2 input2 pointer, R3 entropy pointer
andMaskedOrder2_fix:
	PUSH {R4-R7}

	//Calculation of the first output-share c0
	//c0 = b0*a0+rnd0+b1*a0+rnd1+rnd3+a0*b2
	//register r5 will contain a0
	//the order of the calculation is chosen to use the loading and xoring of randomness needed to naturaly reset opA and opB
	ldr r5, [r1, #0]	//r5: a0
	ldr r4, [r2, #0]	//r4: b0
	ands r4, r5			//r4: b0*a0							<- b0
	ldr r6, [r3, #0]	//r6: e0
	eors r6, r4			//r6: e0+b0*a0						<- e0
	//rnd3 is preloaded to register r7 to reset opB
	ldr r4, [r3, #12]	//r4: e3								<- b0*a0
	ldr r7, [r2, #4]	//r7: b1
	ands r7, r5			//r7: b1*a0							<- b1
	eors r7, r6			//r7: b1*a0+e0+b0*a0					<- b1*a0
	ldr r6, [r3, #4]	//r6: e1								<- e0+b0*a0
	eors r6, r7			//r6: e1+b1*a0+e0+b0*a0				<- b1*a0+e0+b0*a0
	eors r6, r4			//r6: e1+b1*a0+e0+b0*a0+e3			<- e1
	ldr r4, [r2, #8]	//r4: b2								<- e3
	ands r4, r5			//r4: b2*a0							<- b2
	eors r4, r6			//r4: b2*a0+e1+b1*a0+e0+b0*a0+e3		<- b2*a0
	str r4, [r0, #0]

	//register r5 needs to be reset because it contains a0 and a1 is going to be loaded in this register and a0 and a1 can not be leaked together
	MOVS r4, #0			//r4: 0								<- b2*a0+e1+b1*a0+e0+b0*a0+e3
	MOVS r5, #0			//r5: 0								<- a0
	MOVS r6, #0			//r6: 0								<- e1+b1*a0+e0+b0*a0+e3
	MOVS r7, #0			//r7: 0								<- b1*a0+e0+b0*a0
	//opW needs to be reset after each store, because otherwise the next store would leak the last and the current store and one probe would give two output-shares
	str r0, [r0, #4]

	//Calculation of the second output-share c1
	//c1 = b1*a1+rnd1+b2*a1+rnd2+rnd4+b0*a1
	//register r5 will contain a1
	//the order of the calculation is chosen to use the loading and xoring of randomness needed to naturaly reset opA and opB
	ldr r5, [r1, #4]	//r5: a1								<- 0
	ldr r4, [r2, #4]	//r4: b1								<- 0
	ands r4, r5			//r4: b1*a1							<- b1
	ldr r6, [r3, #4]	//r6: e1								<- 0
	eors r6, r4			//r6: e1+b1*a1						<- e1
	//rnd4 is preloaded to register r7 to reset opB
	ldr r4, [r3, #16]	//r4: e4								<- b1*a1
	ldr r7, [r2, #8]	//r7: b2								<- 0
	ands r7, r5			//r7: b2*a1							<- b2
	eors r7, r6			//r7: b2*a1+e1+b1*a1					<- b2*a1
	ldr r6, [r3, #8]	//r6: e2								<- e1+b1*a1
	eors r6, r7			//r6: e2+b2*a1+e1+b1*a1				<- b2*a1+e1+b1*a1
	eors r6, r4			//r6: e2+b2*a1+e1+b1*a1+e4			<- e2+b2*a1+e1+b1*a1
	ldr r4, [r2, #0]	//r4: b0								<- e4
	ands r4, r5			//r4: b0*a1							<- b0
	eors r4, r6			//r4: b0*a1+e2+b2*a1+e1+b1*a1+e4		<- b0*a1
	str r4, [r0, #4]

	//register r5 needs to be cleared because it contains a1 and a2 is going to be loaded in this register and a1 and a2 can not be leaked together
	MOVS r4, #0			//r4: 0								<- b0*a1+e2+b2*a1+e1+b1*a1+e4
	MOVS r5, #0			//r5: 0								<- a1
	MOVS r6, #0			//r6: 0								<- e2+b2*a1+e1+b1*a1+e4
	MOVS r7, #0			//r7: 0								<- b2*a1+e1+b1*a1
	str r0, [r0, #8]

	//Calculation of the third output-share c2
	//c2 = a2*b2+rnd2+rnd4+a2*b0+rnd0+rnd3+a2*b1
	//register r5 will contain a1
	//the order of the calculation is chosen to use the loading and xoring of randomness needed to naturaly reset opA and opB
	ldr r5, [r1, #8]	//r5: a2								<- 0
	ldr r4, [r2, #8]	//r4: b2								<- b0*a1+e2+b2*a1+e1+b1*a1+e4
	ands r4, r5			//r4: b2*a2							<- b2
	ldr r6, [r3, #8]	//r6: e2								<- e2+b2*a1+e1+b1*a1+e4
	eors r6, r4			//r6: e2+b2*a2						<- e2
	//register r7 still contains rnd4 the following xor is used to reset opB
	ldr r7, [r3, #16]	//r7: e4								<- 0
	eors r6, r7			//r6: e2+b2*a2+e4					<- e2+b2*a2
	ldr r7, [r2, #0]	//r7: b0								<- e4
	ands r7, r5			//r7: b0*a2							<- b0
	eors r7, r6			//r7: b0*a2+e2+b2*a2+e4				<- b0*a2
	ldr r6, [r3, #0]	//r6: e0								<- e2+b2*a2+e4
	eors r6, r7			//r6: e0+b0*a2+e2+b2*a2+e4			<- e0
	ldr r7, [r3, #12]	//r7: e3								<- b0*a2+e2+b2*a2+e4
	eors r6, r7			//r6: e0+b0*a2+e2+b2*a2+e4+e3		<- e0+b0*a2+e2+b2*a2+e4
	ldr r7, [r2, #4]	//r7: b1								<- e3
	ands r7, r5			//r7: b1*a2							<- b1
	eors r7, r6			//r7: b1*a2+e0+b0*a2+e2+b2*a2+e4+e3	<- b1*a2
	str r7, [r0, #8]

	POP {R4-R7}
	bx lr

	.global andMaskedOrder2_Prop
	//andMaskedOrder2_Prop( uint32_t output[ 3 ], uint32_t input1[ 3 ], uint32_t input2[ 3 ], uint32_t *entropy )
	//R0 output, R1 input1 pointer, R2 input2 pointer, R3 entropy pointer
andMaskedOrder2_Prop:
	//c = (a0+a1+a2)(b0+b1+b2)
	//  = a0*b0 + a0*b1 + a0*b2 + a1*b0 + a1*b1 + a1*b2 + a2*b0 + a2*b1 + a2*b2

	//c0 = a0*b0 + a0*b1 + a1*b0 + a1*b1 + e0
	//c1 = a1*b2 + a2*b1 + a2*b2 + e1
	//c2 = a0*b2 + a2*b0 + e0 + e1

	push {r4-r7}

	ldr r4, [r1, #0]	//r4: a0
	ldr r5, [r2, #0]	//r5: b0
	ldr r6, [r3, #0]	//r6: e0
	ands r4, r5			//r4: a0*b0						<- a0
	eors r4, r6			//r4: a0*b0+e0					<- a0b0
	ldr r6, [r1, #4]	//r6: a1							<- e0
	ands r5, r6			//r5: b0*a1						<- b0
	eors r5, r4			//r5: b0*a1+a0*b0+e0				<- b0*a1
	ldr r4, [r2, #4]	//r4: b1							<- a0*b0+e0
	ands r6, r4			//r6: a1*b1						<- a1
	eors r5, r6			//r5: b0*a1+a0*b0+e0+a1*b1		<- b0*a1+a0*b0+e0
	movs r6, r4			//r6: b1							<- a1*b1
	ands r6, r7			//r6: b1*a0						<- b1
	eors r5, r6			//r5: b0*a1+a0*b0+e0+a1*b1+b1*a0	<- b1*a0
	str r5, [r0, #0]

	movs r5, #0			//r5: 0							<- b0*a1+a0*b0+e0+a1*b1+b1*a0
	ldr r5, [r1, #8]	//r5: a2							<- 0
	ands r4, r5			//r4: b1*a2						<- b1
	ldr r6, [r3, #4]	//r6: e1							<- a1*b1
	eors r4, r6			//r4: b1*a2+e1					<- b1*a2
	ldr r3, [r2, #8]	//r3: b2							<- [e]
	str r0, [r0, #4]
	movs r1, r3			//r1: b2							<- [a]
	ands r1, r5			//r1: b2*a2						<- b2
	eors r4, r1			//r4: b1*a2+e1+b2*a2				<- b1*a2+e1
	ands r7, r3			//r7: a0*b2						<- a0
	eors r4, r7			//r4: b1*a2+e1+b2*a2+a0*b2		<- b1*a2+e1+b2*a2
	str r4, [r0, #4]

	movs r4, #0			//r4: 0							<- b1*a2+e1+b2*a2+a0*b2
	mov r4, r10			//r4: b0							<- 0
	ands r5, r4			//r5: a2*b0						<- a2
	eors r5, r6			//r4: a2*b0+e1					<- a2*b0
	mov r4, r9			//r4: a1							<- b0
	str r0, [r0, #8]
	mov r6, r8			//r6: e0							<- e1
	ands r3, r4			//r3: b2*a1						<- b2
	eors r3, r6			//r3: b2*a2+e0					<- b2*a2
	eors r3, r5			//r3: b2*a2+e0+a2*b0+e1			<- b2*a2+e0
	str r3, [r0, #8]

	pop {r4-r6}
	mov r8, r4
	mov r9, r5
	mov r10, r6
	pop {r4-r7}
	bx lr
