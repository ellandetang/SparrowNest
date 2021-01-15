/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * batchBiotSavart.h
 *
 * Code generation for function 'batchBiotSavart'
 *
 */

#pragma once

/* Include files */
#include "batchBiotSavart_types.h"
#include "rtwtypes.h"
#include "emlrt.h"
#include "mex.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function Declarations */
void batchBiotSavart(const emlrtStack *sp, const emxArray_real_T *startPoints,
                     const emxArray_real_T *endPoints, const emxArray_real_T
                     *Gamma, const emxArray_real_T *rc, const emxArray_real_T
                     *samplePoints, emxArray_real_T *V);

/* End of code generation (batchBiotSavart.h) */
