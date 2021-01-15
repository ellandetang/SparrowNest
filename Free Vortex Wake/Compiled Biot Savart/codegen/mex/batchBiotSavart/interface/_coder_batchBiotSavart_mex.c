/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_batchBiotSavart_mex.c
 *
 * Code generation for function '_coder_batchBiotSavart_mex'
 *
 */

/* Include files */
#include "_coder_batchBiotSavart_mex.h"
#include "_coder_batchBiotSavart_api.h"
#include "batchBiotSavart_data.h"
#include "batchBiotSavart_initialize.h"
#include "batchBiotSavart_terminate.h"
#include "rt_nonfinite.h"

/* Function Definitions */
void batchBiotSavart_mexFunction(int32_T nlhs, mxArray *plhs[1], int32_T nrhs,
  const mxArray *prhs[5])
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  const mxArray *outputs[1];
  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 5) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 5, 4,
                        15, "batchBiotSavart");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 15,
                        "batchBiotSavart");
  }

  /* Call the function. */
  batchBiotSavart_api(prhs, outputs);

  /* Copy over outputs to the caller. */
  emlrtReturnArrays(1, plhs, outputs);
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(&batchBiotSavart_atexit);

  /* Module initialization. */
  batchBiotSavart_initialize();

  /* Dispatch the entry-point. */
  batchBiotSavart_mexFunction(nlhs, plhs, nrhs, prhs);

  /* Module termination. */
  batchBiotSavart_terminate();
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_batchBiotSavart_mex.c) */
