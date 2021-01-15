/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * sum.c
 *
 * Code generation for function 'sum'
 *
 */

/* Include files */
#include "sum.h"
#include "batchBiotSavart_data.h"
#include "batchBiotSavart_emxutil.h"
#include "batchBiotSavart_types.h"
#include "eml_int_forloop_overflow_check.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRSInfo bb_emlrtRSI = { 20, /* lineNo */
  "sum",                               /* fcnName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\lib\\matlab\\datafun\\sum.m"/* pathName */
};

static emlrtRSInfo cb_emlrtRSI = { 99, /* lineNo */
  "sumprod",                           /* fcnName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\lib\\matlab\\datafun\\private\\sumprod.m"/* pathName */
};

static emlrtRSInfo db_emlrtRSI = { 133,/* lineNo */
  "combineVectorElements",             /* fcnName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\lib\\matlab\\datafun\\private\\combineVectorElements.m"/* pathName */
};

static emlrtRSInfo eb_emlrtRSI = { 173,/* lineNo */
  "colMajorFlatIter",                  /* fcnName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\lib\\matlab\\datafun\\private\\combineVectorElements.m"/* pathName */
};

static emlrtRSInfo mb_emlrtRSI = { 178,/* lineNo */
  "colMajorFlatIter",                  /* fcnName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\lib\\matlab\\datafun\\private\\combineVectorElements.m"/* pathName */
};

static emlrtRSInfo nb_emlrtRSI = { 196,/* lineNo */
  "colMajorFlatIter",                  /* fcnName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\lib\\matlab\\datafun\\private\\combineVectorElements.m"/* pathName */
};

static emlrtRSInfo rb_emlrtRSI = { 194,/* lineNo */
  "colMajorFlatIter",                  /* fcnName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\lib\\matlab\\datafun\\private\\combineVectorElements.m"/* pathName */
};

static emlrtRTEInfo fc_emlrtRTEI = { 166,/* lineNo */
  24,                                  /* colNo */
  "combineVectorElements",             /* fName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\lib\\matlab\\datafun\\private\\combineVectorElements.m"/* pName */
};

static emlrtRTEInfo hc_emlrtRTEI = { 20,/* lineNo */
  1,                                   /* colNo */
  "sum",                               /* fName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\lib\\matlab\\datafun\\sum.m"/* pName */
};

/* Function Definitions */
void b_sum(const emlrtStack *sp, const emxArray_real_T *x, emxArray_real_T *y)
{
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  emlrtStack st;
  int32_T j;
  int32_T vstride;
  int32_T xoffset;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &bb_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  b_st.site = &cb_emlrtRSI;
  if ((x->size[0] == 0) || (x->size[1] == 0)) {
    j = y->size[0] * y->size[1];
    y->size[0] = x->size[0];
    y->size[1] = x->size[1];
    emxEnsureCapacity_real_T(&b_st, y, j, &hc_emlrtRTEI);
    xoffset = x->size[0] * x->size[1];
    for (j = 0; j < xoffset; j++) {
      y->data[j] = 0.0;
    }
  } else {
    c_st.site = &db_emlrtRSI;
    vstride = x->size[0] * x->size[1];
    j = y->size[0] * y->size[1];
    y->size[0] = x->size[0];
    y->size[1] = x->size[1];
    emxEnsureCapacity_real_T(&c_st, y, j, &fc_emlrtRTEI);
    d_st.site = &mb_emlrtRSI;
    if ((1 <= vstride) && (vstride > 2147483646)) {
      e_st.site = &ab_emlrtRSI;
      check_forloop_overflow_error(&e_st);
    }

    for (j = 0; j < vstride; j++) {
      y->data[j] = x->data[j];
    }

    d_st.site = &nb_emlrtRSI;
    for (j = 0; j < vstride; j++) {
      y->data[j] += x->data[vstride + j];
    }

    xoffset = 2 * vstride;
    d_st.site = &nb_emlrtRSI;
    for (j = 0; j < vstride; j++) {
      y->data[j] += x->data[xoffset + j];
    }
  }
}

void c_sum(const emlrtStack *sp, const emxArray_real_T *x, emxArray_real_T *y)
{
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  emlrtStack st;
  int32_T i;
  int32_T k;
  int32_T npages;
  int32_T vlen;
  int32_T xpageoffset;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &bb_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  b_st.site = &cb_emlrtRSI;
  vlen = x->size[0];
  if ((x->size[0] == 0) || (x->size[1] == 0)) {
    i = y->size[0] * y->size[1] * y->size[2];
    y->size[0] = 1;
    y->size[1] = x->size[1];
    y->size[2] = 3;
    emxEnsureCapacity_real_T(&b_st, y, i, &hc_emlrtRTEI);
    xpageoffset = x->size[1] * 3;
    for (i = 0; i < xpageoffset; i++) {
      y->data[i] = 0.0;
    }
  } else {
    c_st.site = &db_emlrtRSI;
    npages = x->size[1] * x->size[2];
    i = y->size[0] * y->size[1] * y->size[2];
    y->size[0] = 1;
    y->size[1] = x->size[1];
    y->size[2] = 3;
    emxEnsureCapacity_real_T(&c_st, y, i, &fc_emlrtRTEI);
    d_st.site = &eb_emlrtRSI;
    if ((1 <= npages) && (npages > 2147483646)) {
      e_st.site = &ab_emlrtRSI;
      check_forloop_overflow_error(&e_st);
    }

    for (i = 0; i < npages; i++) {
      xpageoffset = i * x->size[0];
      y->data[i] = x->data[xpageoffset];
      d_st.site = &rb_emlrtRSI;
      if ((2 <= vlen) && (vlen > 2147483646)) {
        e_st.site = &ab_emlrtRSI;
        check_forloop_overflow_error(&e_st);
      }

      for (k = 2; k <= vlen; k++) {
        y->data[i] += x->data[(xpageoffset + k) - 1];
      }
    }
  }
}

void sum(const emlrtStack *sp, const emxArray_real_T *x, emxArray_real_T *y)
{
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  emlrtStack st;
  int32_T i;
  int32_T npages;
  int32_T xpageoffset;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &bb_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  b_st.site = &cb_emlrtRSI;
  if (x->size[1] == 0) {
    y->size[0] = 1;
    y->size[1] = 0;
  } else {
    c_st.site = &db_emlrtRSI;
    npages = x->size[1];
    xpageoffset = y->size[0] * y->size[1];
    y->size[0] = 1;
    y->size[1] = x->size[1];
    emxEnsureCapacity_real_T(&c_st, y, xpageoffset, &fc_emlrtRTEI);
    d_st.site = &eb_emlrtRSI;
    if (x->size[1] > 2147483646) {
      e_st.site = &ab_emlrtRSI;
      check_forloop_overflow_error(&e_st);
    }

    for (i = 0; i < npages; i++) {
      xpageoffset = i * 3;
      y->data[i] = (x->data[xpageoffset] + x->data[xpageoffset + 1]) + x->
        data[xpageoffset + 2];
    }
  }
}

/* End of code generation (sum.c) */
