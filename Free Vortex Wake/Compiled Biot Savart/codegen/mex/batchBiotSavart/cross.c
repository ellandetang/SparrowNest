/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * cross.c
 *
 * Code generation for function 'cross'
 *
 */

/* Include files */
#include "cross.h"
#include "batchBiotSavart_data.h"
#include "batchBiotSavart_emxutil.h"
#include "batchBiotSavart_types.h"
#include "eml_int_forloop_overflow_check.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRSInfo vb_emlrtRSI = { 67, /* lineNo */
  "cross",                             /* fcnName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\lib\\matlab\\specfun\\cross.m"/* pathName */
};

static emlrtRSInfo wb_emlrtRSI = { 69, /* lineNo */
  "cross",                             /* fcnName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\lib\\matlab\\specfun\\cross.m"/* pathName */
};

static emlrtRTEInfo f_emlrtRTEI = { 36,/* lineNo */
  19,                                  /* colNo */
  "cross",                             /* fName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\lib\\matlab\\specfun\\cross.m"/* pName */
};

static emlrtRTEInfo g_emlrtRTEI = { 19,/* lineNo */
  19,                                  /* colNo */
  "eml_int_forloop_overflow_check",    /* fName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\lib\\matlab\\eml\\eml_int_forloop_overflow_check.m"/* pName */
};

static emlrtRTEInfo oc_emlrtRTEI = { 38,/* lineNo */
  24,                                  /* colNo */
  "cross",                             /* fName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\lib\\matlab\\specfun\\cross.m"/* pName */
};

/* Function Definitions */
void cross(const emlrtStack *sp, const emxArray_real_T *a, const emxArray_real_T
           *b, emxArray_real_T *c)
{
  emlrtStack b_st;
  emlrtStack st;
  int32_T i1;
  int32_T i2;
  int32_T i3;
  int32_T iNext;
  int32_T iStart;
  int32_T stride;
  uint32_T varargin_1[3];
  uint32_T varargin_2[3];
  boolean_T b_p;
  boolean_T exitg1;
  boolean_T p;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  varargin_1[0] = (uint32_T)a->size[0];
  varargin_2[0] = (uint32_T)b->size[0];
  varargin_1[1] = (uint32_T)a->size[1];
  varargin_2[1] = (uint32_T)b->size[1];
  varargin_1[2] = (uint32_T)a->size[2];
  varargin_2[2] = (uint32_T)b->size[2];
  p = true;
  stride = 0;
  exitg1 = false;
  while ((!exitg1) && (stride < 3)) {
    if ((int32_T)varargin_1[stride] != (int32_T)varargin_2[stride]) {
      p = false;
      exitg1 = true;
    } else {
      stride++;
    }
  }

  b_p = (int32_T)p;
  if (!b_p) {
    emlrtErrorWithMessageIdR2018a(sp, &f_emlrtRTEI,
      "MATLAB:cross:InputSizeMismatch", "MATLAB:cross:InputSizeMismatch", 0);
  }

  stride = c->size[0] * c->size[1] * c->size[2];
  c->size[0] = a->size[0];
  c->size[1] = a->size[1];
  c->size[2] = 3;
  emxEnsureCapacity_real_T(sp, c, stride, &oc_emlrtRTEI);
  if ((a->size[0] != 0) && (a->size[1] != 0)) {
    stride = a->size[0] * a->size[1];
    iNext = stride * 3;
    st.site = &vb_emlrtRSI;
    if (iNext == 0) {
      emlrtErrorWithMessageIdR2018a(&st, &g_emlrtRTEI,
        "Coder:builtins:VectorStride", "Coder:builtins:VectorStride", 0);
    }

    if ((iNext != 0) && (1 > MAX_int32_T - iNext)) {
      b_st.site = &eb_emlrtRSI;
      check_forloop_overflow_error(&b_st);
    }

    for (iStart = 1; iNext < 0 ? iStart >= 1 : iStart <= 1; iStart += iNext) {
      st.site = &wb_emlrtRSI;
      if ((1 <= stride) && (stride > 2147483646)) {
        b_st.site = &eb_emlrtRSI;
        check_forloop_overflow_error(&b_st);
      }

      for (i1 = 1; i1 <= stride; i1++) {
        i2 = (i1 + stride) - 1;
        i3 = i2 + stride;
        c->data[i1 - 1] = a->data[i2] * b->data[i3] - a->data[i3] * b->data[i2];
        c->data[i2] = a->data[i3] * b->data[i1 - 1] - a->data[i1 - 1] * b->
          data[i3];
        c->data[i3] = a->data[i1 - 1] * b->data[i2] - a->data[i2] * b->data[i1 -
          1];
      }
    }
  }
}

/* End of code generation (cross.c) */
