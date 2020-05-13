/*
 * Copyright 2020 - NXP, TU Darmstadt 
 * SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications
 */

#ifndef ASMPRESENT_ORDER2_H
#define ASMPRESENT_ORDER2_H

#include <stdint.h>

/* entropy is a pointer to an array of undefined length,
 * the first position serves as a scratch space holding public data,
 * the rest is fresh (i.e. unused) uniformly distributed randomness
 * the function returns an updated pointer after execution
 */

uint32_t* presentOrder2( 	uint32_t*      entropy,  // advances by 20 positions
							uint32_t       output[4][3],
							const uint32_t input[4][3]);

#endif
