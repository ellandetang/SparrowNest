/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * power.c
 *
 * Code generation for function 'power'
 *
 */

/* Include files */
#include "power.h"
#include "batchBiotSavart_data.h"
#include "batchBiotSavart_emxutil.h"
#include "batchBiotSavart_types.h"
#include "eml_int_forloop_overflow_check.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRSInfo ab_emlrtRSI = { 70, /* lineNo */
  "power",                             /* fcnName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\lib\\matlab\\ops\\power.m"/* pathName */
};

static emlrtRSInfo bb_emlrtRSI = { 79, /* lineNo */
  "fltpower",                          /* fcnName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\lib\\matlab\\ops\\power.m"/* pathName */
};

static emlrtRSInfo cb_emlrtRSI = { 66, /* lineNo */
  "applyBinaryScalarFunction",         /* fcnName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\eml\\+coder\\+internal\\applyBinaryScalarFunction.m"/* pathName */
};

static emlrtRSInfo db_emlrtRSI = { 188,/* lineNo */
  "flatIter",                          /* fcnName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\eml\\+coder\\+internal\\applyBinaryScalarFunction.m"/* pathName */
};

static emlrtRTEInfo ic_emlrtRTEI = { 46,/* lineNo */
  6,                                   /* colNo */
  "applyBinaryScalarFunction",         /* fName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\eml\\+coder\\+internal\\applyBinaryScalarFunction.m"/* pName */
};

/* Function Definitions */
void b_power(const emlrtStack *sp, const emxArray_real_T *a, emxArray_real_T *y)
{
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  emlrtStack st;
  int32_T k;
  int32_T nx;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &ab_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  b_st.site = &bb_emlrtRSI;
  nx = y->size[0] * y->size[1] * y->size[2];
  y->size[0] = a->size[0];
  y->size[1] = a->size[1];
  y->size[2] = 3;
  emxEnsureCapacity_real_T(&b_st, y, nx, &ic_emlrtRTEI);
  c_st.site = &cb_emlrtRSI;
  nx = a->size[0] * a->size[1] * 3;
  d_st.site = &db_emlrtRSI;
  if ((1 <= nx) && (nx > 2147483646)) {
    e_st.site = &eb_emlrtRSI;
    check_forloop_overflow_error(&e_st);
  }

  for (k = 0; k < nx; k++) {
    y->data[k] = a->data[k] * a->data[k];
  }
}

void c_power(const emlrtStack *sp, const emxArray_real_T *a, emxArray_real_T *y)
{
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  emlrtStack st;
  int32_T k;
  int32_T nx;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &ab_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  b_st.site = &bb_emlrtRSI;
  nx = y->size[0] * y->size[1];
  y->size[0] = a->size[0];
  y->size[1] = a->size[1];
  emxEnsureCapacity_real_T(&b_st, y, nx, &ic_emlrtRTEI);
  c_st.site = &cb_emlrtRSI;
  nx = a->size[0] * a->size[1];
  d_st.site = &db_emlrtRSI;
  if ((1 <= nx) && (nx > 2147483646)) {
    e_st.site = &eb_emlrtRSI;
    check_forloop_overflow_error(&e_st);
  }

  for (k = 0; k < nx; k++) {
    y->data[k] = a->data[k] * a->data[k];
  }
}

void power(const emlrtStack *sp, const emxArray_real_T *a, emxArray_real_T *y)
{
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  emlrtStack st;
  int32_T k;
  int32_T nx;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &ab_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  b_st.site = &bb_emlrtRSI;
  nx = y->size[0] * y->size[1];
  y->size[0] = 3;
  y->size[1] = a->size[1];
  emxEnsureCapacity_real_T(&b_st, y, nx, &ic_emlrtRTEI);
  c_st.site = &cb_emlrtRSI;
  nx = 3 * a->size[1];
  d_st.site = &db_emlrtRSI;
  if ((1 <= nx) && (nx > 2147483646)) {
    e_st.site = &eb_emlrtRSI;
    check_forloop_overflow_error(&e_st);
  }

  for (k = 0; k < nx; k++) {
    y->data[k] = a->data[k] * a->data[k];
  }
}

/* End of code generation (power.c) */
