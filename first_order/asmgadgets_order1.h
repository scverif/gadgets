/* Copyright 2020 - NXP, TU Darmstadt, Ruhr University Bochum */

#ifndef ASMGADGETS_ORDER1_H
#define ASMGADGETS_ORDER1_H

#include <stdint.h>

/* entropy is a pointer to an array of undefined length,
 * the first position serves as a scratch space holding public data,
 * the rest is fresh (i.e. unused) uniformly distributed randomness
 * all functions return such an updated pointer after execution
 */

uint32_t* xorOrder1( uint32_t*      entropy   ,  // advances by 0 positions
                     uint32_t       output[2] ,
                     const uint32_t input1[2] ,
                     const uint32_t input2[2] );

uint32_t* andOrder1( uint32_t*      entropy   ,  // advances by 1 position
                     uint32_t       output[2] ,
                     const uint32_t input1[2] ,
                     const uint32_t input2[2] );

uint32_t* refOrder1( uint32_t*      entropy   ,  // advances by 1 position
                     uint32_t       output[2] ,
                     const uint32_t input [2] );

uint32_t* notOrder1( uint32_t*      entropy   ,  // advances by 0 positions
                     uint32_t       inplacedata[2]);

uint32_t* notOrder1( uint32_t*      entropy   ,  // advances by 0 positions
                     uint32_t       inplacedata[2]);

#endif
