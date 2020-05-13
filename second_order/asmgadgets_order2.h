/*
 * Copyright 2020 - NXP, TU Darmstadt, Ruhr University Bochum
 * SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications
 */

#ifndef ASMGADGETS_ORDER2_H
#define ASMGADGETS_ORDER2_H

#include <stdint.h>

/* entropy is a pointer to an array of undefined length,
 * the first position serves as a scratch space holding public data,
 * the rest is fresh (i.e. unused) uniformly distributed randomness
 * all functions return such an updated pointer after execution
 */

uint32_t* xorOrder2( uint32_t*      entropy   ,  // advances by 0 positions
                     uint32_t       output[3] ,
                     const uint32_t input1[3] ,
                     const uint32_t input2[3] );

uint32_t* andOrder2( uint32_t*      entropy   ,  // advances by 3 positions
                     uint32_t       output[3] ,
                     const uint32_t input1[3] ,
                     const uint32_t input2[3] );

uint32_t* refOrder2( uint32_t*      entropy   ,  // advances by 2 positions
                     uint32_t       output[3] ,
                     const uint32_t input [3] );

uint32_t* notOrder2( uint32_t*      entropy   ,  // advances by 0 positions
                     uint32_t       inplacedata[3]);

uint32_t* cpyOrder2( uint32_t*      entropy   ,  // advances by 0 position
                     uint32_t       output[3] ,
                     const uint32_t input [3] );

uint32_t* leakOrder2(uint32_t*      entropy   ,  // advances by 0 positions
                     uint32_t       inplacedata[3]);

#endif
