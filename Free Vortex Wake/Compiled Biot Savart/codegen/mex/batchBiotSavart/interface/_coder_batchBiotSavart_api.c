/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_batchBiotSavart_api.c
 *
 * Code generation for function '_coder_batchBiotSavart_api'
 *
 */

/* Include files */
#include "_coder_batchBiotSavart_api.h"
#include "batchBiotSavart.h"
#include "batchBiotSavart_data.h"
#include "batchBiotSavart_emxutil.h"
#include "batchBiotSavart_types.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRTEInfo kc_emlrtRTEI = { 1,/* lineNo */
  1,                                   /* colNo */
  "_coder_batchBiotSavart_api",        /* fName */
  ""                                   /* pName */
};

/* Function Declarations */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y);
static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *Gamma, const
  char_T *identifier, emxArray_real_T *y);
static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y);
static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret);
static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *startPoints,
  const char_T *identifier, emxArray_real_T *y);
static const mxArray *emlrt_marshallOut(const emxArray_real_T *u);
static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret);

/* Function Definitions */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y)
{
  e_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *Gamma, const
  char_T *identifier, emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  d_emlrt_marshallIn(sp, emlrtAlias(Gamma), &thisId, y);
  emlrtDestroyArray(&Gamma);
}

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y)
{
  f_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret)
{
  static const int32_T dims[2] = { 3, -1 };

  int32_T iv[2];
  int32_T i;
  const boolean_T bv[2] = { false, true };

  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims, &bv[0],
    iv);
  ret->allocatedSize = iv[0] * iv[1];
  i = ret->size[0] * ret->size[1];
  ret->size[0] = iv[0];
  ret->size[1] = iv[1];
  emxEnsureCapacity_real_T(sp, ret, i, (emlrtRTEInfo *)NULL);
  ret->data = (real_T *)emlrtMxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *startPoints,
  const char_T *identifier, emxArray_real_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(sp, emlrtAlias(startPoints), &thisId, y);
  emlrtDestroyArray(&startPoints);
}

static const mxArray *emlrt_marshallOut(const emxArray_real_T *u)
{
  static const int32_T iv[2] = { 0, 0 };

  const mxArray *m;
  const mxArray *y;
  y = NULL;
  m = emlrtCreateNumericArray(2, &iv[0], mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, &u->data[0]);
  emlrtSetDimensions((mxArray *)m, u->size, 2);
  emlrtAssign(&y, m);
  return y;
}

static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret)
{
  static const int32_T dims[2] = { 1, -1 };

  int32_T iv[2];
  int32_T i;
  const boolean_T bv[2] = { false, true };

  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims, &bv[0],
    iv);
  ret->allocatedSize = iv[0] * iv[1];
  i = ret->size[0] * ret->size[1];
  ret->size[0] = iv[0];
  ret->size[1] = iv[1];
  emxEnsureCapacity_real_T(sp, ret, i, (emlrtRTEInfo *)NULL);
  ret->data = (real_T *)emlrtMxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

void batchBiotSavart_api(const mxArray * const prhs[5], const mxArray *plhs[1])
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  emxArray_real_T *Gamma;
  emxArray_real_T *V;
  emxArray_real_T *endPoints;
  emxArray_real_T *rc;
  emxArray_real_T *samplePoints;
  emxArray_real_T *startPoints;
  st.tls = emlrtRootTLSGlobal;
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  emxInit_real_T(&st, &startPoints, 2, &kc_emlrtRTEI, true);
  emxInit_real_T(&st, &endPoints, 2, &kc_emlrtRTEI, true);
  emxInit_real_T(&st, &Gamma, 2, &kc_emlrtRTEI, true);
  emxInit_real_T(&st, &rc, 2, &kc_emlrtRTEI, true);
  emxInit_real_T(&st, &samplePoints, 2, &kc_emlrtRTEI, true);
  emxInit_real_T(&st, &V, 2, &kc_emlrtRTEI, true);

  /* Marshall function inputs */
  startPoints->canFreeData = false;
  emlrt_marshallIn(&st, emlrtAlias(prhs[0]), "startPoints", startPoints);
  endPoints->canFreeData = false;
  emlrt_marshallIn(&st, emlrtAlias(prhs[1]), "endPoints", endPoints);
  Gamma->canFreeData = false;
  c_emlrt_marshallIn(&st, emlrtAlias(prhs[2]), "Gamma", Gamma);
  rc->canFreeData = false;
  c_emlrt_marshallIn(&st, emlrtAlias(prhs[3]), "rc", rc);
  samplePoints->canFreeData = false;
  emlrt_marshallIn(&st, emlrtAlias(prhs[4]), "samplePoints", samplePoints);

  /* Invoke the target function */
  batchBiotSavart(&st, startPoints, endPoints, Gamma, rc, samplePoints, V);

  /* Marshall function outputs */
  V->canFreeData = false;
  plhs[0] = emlrt_marshallOut(V);
  emxFree_real_T(&V);
  emxFree_real_T(&samplePoints);
  emxFree_real_T(&rc);
  emxFree_real_T(&Gamma);
  emxFree_real_T(&endPoints);
  emxFree_real_T(&startPoints);
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

/* End of code generation (_coder_batchBiotSavart_api.c) */
