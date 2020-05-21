[//1]: # (Copyright 2020 - NXP)
[//2]: # (SPDX-License-Identifier: BSD-3-Clause-Clear WITH modifications)

## Introduction ##
This repository contains masked implementations for Arm Cortex-M
micro-controllers and code to guide their analysis using "scVerif" and
[maskverif](https://gitlab.com/benjgregoire/maskverif/tree/SPINI). Most
implementations have been manually verified to achieve threshold
(strong) non-interference at orders one or two. An optimized masked
implementation of the PRESENT sbox is provided at order one and
two. The implementations are provided in forms of gnu assembler code,
the higher-level intermediate language of scVerif and as dumps of
executable files.

## Setup ##
1. install scVerif using `make install`
2. link the models provided by scVerif in the `models` directory
   For example using the command `ln -s <PATH TO SCVERIF HOME>/models models`

## Contributors ##
The software tool scVerif has been developed by the following
organizations and authors.

* VeriSec Consortium, consisting of
  * NXP Semiconductors
  * Ruhr University Bochum chair for embedded security
  * Ruhr University Bochum chair for security engineering
  * Technical University of Darmstadt chair for applied cryptography
  * TÜViT
* Inria

## License ##
This project is licensed under a modified BSD 3-Clause Clear License.
See the `LICENSE.txt` file in the root of this project.

## Acknowledgments ##
The research in this work was supported in part by the VeriSec project
16KIS0601K and 16KIS0634, from the Federal Ministry of Education and
Research (BMBF).
