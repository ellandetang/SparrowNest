/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * dot.c
 *
 * Code generation for function 'dot'
 *
 */

/* Include files */
#include "dot.h"
#include "batchBiotSavart_data.h"
#include "batchBiotSavart_emxutil.h"
#include "batchBiotSavart_types.h"
#include "eml_int_forloop_overflow_check.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRSInfo ob_emlrtRSI = { 70, /* lineNo */
  "dot",                               /* fcnName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\lib\\matlab\\specfun\\dot.m"/* pathName */
};

static emlrtRTEInfo e_emlrtRTEI = { 12,/* lineNo */
  23,                                  /* colNo */
  "dot",                               /* fName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\lib\\matlab\\specfun\\dot.m"/* pName */
};

static emlrtRTEInfo ic_emlrtRTEI = { 60,/* lineNo */
  20,                                  /* colNo */
  "dot",                               /* fName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\lib\\matlab\\specfun\\dot.m"/* pName */
};

/* Function Definitions */
void dot(const emlrtStack *sp, const emxArray_real_T *a, const emxArray_real_T
         *b, emxArray_real_T *c)
{
  emlrtStack b_st;
  emlrtStack st;
  real_T b_c;
  int32_T i1;
  int32_T ic;
  int32_T ix_tmp;
  int32_T j;
  int32_T vstride;
  uint32_T sz[3];
  uint32_T varargin_2[3];
  boolean_T b_p;
  boolean_T exitg1;
  boolean_T p;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  sz[0] = (uint32_T)a->size[0];
  varargin_2[0] = (uint32_T)b->size[0];
  sz[1] = (uint32_T)a->size[1];
  varargin_2[1] = (uint32_T)b->size[1];
  sz[2] = (uint32_T)a->size[2];
  varargin_2[2] = (uint32_T)b->size[2];
  p = true;
  vstride = 0;
  exitg1 = false;
  while ((!exitg1) && (vstride < 3)) {
    if ((int32_T)sz[vstride] != (int32_T)varargin_2[vstride]) {
      p = false;
      exitg1 = true;
    } else {
      vstride++;
    }
  }

  b_p = (int32_T)p;
  if (!b_p) {
    emlrtErrorWithMessageIdR2018a(sp, &e_emlrtRTEI,
      "MATLAB:dot:InputSizeMismatch", "MATLAB:dot:InputSizeMismatch", 0);
  }

  vstride = c->size[0] * c->size[1];
  c->size[0] = a->size[0];
  c->size[1] = a->size[1];
  emxEnsureCapacity_real_T(sp, c, vstride, &ic_emlrtRTEI);
  vstride = a->size[0] * a->size[1];
  ic = -1;
  i1 = -1;
  st.site = &ob_emlrtRSI;
  if ((1 <= vstride) && (vstride > 2147483646)) {
    b_st.site = &ab_emlrtRSI;
    check_forloop_overflow_error(&b_st);
  }

  for (j = 0; j < vstride; j++) {
    ic++;
    i1++;
    ix_tmp = i1 + vstride;
    b_c = a->data[i1] * b->data[i1] + a->data[ix_tmp] * b->data[ix_tmp];
    b_c += a->data[ix_tmp + vstride] * b->data[ix_tmp + vstride];
    c->data[ic] = b_c;
  }
}

/* End of code generation (dot.c) */
