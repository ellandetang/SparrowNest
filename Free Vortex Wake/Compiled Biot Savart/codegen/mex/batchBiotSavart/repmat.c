/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * repmat.c
 *
 * Code generation for function 'repmat'
 *
 */

/* Include files */
#include "repmat.h"
#include "assertValidSizeArg.h"
#include "batchBiotSavart_data.h"
#include "batchBiotSavart_emxutil.h"
#include "batchBiotSavart_types.h"
#include "eml_int_forloop_overflow_check.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRSInfo lb_emlrtRSI = { 28, /* lineNo */
  "repmat",                            /* fcnName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\lib\\matlab\\elmat\\repmat.m"/* pathName */
};

static emlrtRSInfo mb_emlrtRSI = { 64, /* lineNo */
  "repmat",                            /* fcnName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\lib\\matlab\\elmat\\repmat.m"/* pathName */
};

static emlrtRSInfo nb_emlrtRSI = { 69, /* lineNo */
  "repmat",                            /* fcnName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\lib\\matlab\\elmat\\repmat.m"/* pathName */
};

static emlrtRSInfo ob_emlrtRSI = { 71, /* lineNo */
  "repmat",                            /* fcnName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\lib\\matlab\\elmat\\repmat.m"/* pathName */
};

static emlrtRSInfo pb_emlrtRSI = { 66, /* lineNo */
  "repmat",                            /* fcnName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\lib\\matlab\\elmat\\repmat.m"/* pathName */
};

static emlrtRTEInfo kc_emlrtRTEI = { 59,/* lineNo */
  28,                                  /* colNo */
  "repmat",                            /* fName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\lib\\matlab\\elmat\\repmat.m"/* pName */
};

/* Function Definitions */
void b_repmat(const emlrtStack *sp, const emxArray_real_T *a, const real_T
              varargin_1[2], emxArray_real_T *b)
{
  emlrtStack b_st;
  emlrtStack st;
  int32_T ibmat;
  int32_T itilerow;
  int32_T jcol;
  int32_T ncols;
  int32_T ntilerows;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &lb_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  assertValidSizeArg(&st, varargin_1);
  ncols = b->size[0] * b->size[1];
  b->size[0] = (int32_T)varargin_1[0];
  b->size[1] = a->size[1];
  emxEnsureCapacity_real_T(sp, b, ncols, &kc_emlrtRTEI);
  ncols = a->size[1];
  ntilerows = (int32_T)varargin_1[0];
  st.site = &mb_emlrtRSI;
  st.site = &pb_emlrtRSI;
  if ((1 <= a->size[1]) && (a->size[1] > 2147483646)) {
    b_st.site = &eb_emlrtRSI;
    check_forloop_overflow_error(&b_st);
  }

  for (jcol = 0; jcol < ncols; jcol++) {
    ibmat = jcol * ntilerows;
    st.site = &nb_emlrtRSI;
    if ((1 <= ntilerows) && (ntilerows > 2147483646)) {
      b_st.site = &eb_emlrtRSI;
      check_forloop_overflow_error(&b_st);
    }

    for (itilerow = 0; itilerow < ntilerows; itilerow++) {
      b->data[ibmat + itilerow] = a->data[jcol];
    }
  }
}

void c_repmat(const emlrtStack *sp, const emxArray_real_T *a, emxArray_real_T *b)
{
  emlrtStack b_st;
  emlrtStack st;
  int32_T iacol_tmp;
  int32_T ibmat;
  int32_T ibtile;
  int32_T jcol;
  int32_T jtilecol;
  int32_T k;
  int32_T ncols;
  int32_T nrows;
  boolean_T overflow;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  nrows = b->size[0] * b->size[1] * b->size[2];
  b->size[0] = a->size[0];
  b->size[1] = a->size[1];
  b->size[2] = 3;
  emxEnsureCapacity_real_T(sp, b, nrows, &kc_emlrtRTEI);
  nrows = a->size[0];
  ncols = a->size[1];
  overflow = ((1 <= a->size[1]) && (a->size[1] > 2147483646));
  for (jtilecol = 0; jtilecol < 3; jtilecol++) {
    ibtile = jtilecol * (nrows * ncols) - 1;
    st.site = &pb_emlrtRSI;
    if (overflow) {
      b_st.site = &eb_emlrtRSI;
      check_forloop_overflow_error(&b_st);
    }

    for (jcol = 0; jcol < ncols; jcol++) {
      iacol_tmp = jcol * nrows;
      ibmat = ibtile + iacol_tmp;
      st.site = &ob_emlrtRSI;
      if ((1 <= nrows) && (nrows > 2147483646)) {
        b_st.site = &eb_emlrtRSI;
        check_forloop_overflow_error(&b_st);
      }

      for (k = 0; k < nrows; k++) {
        b->data[(ibmat + k) + 1] = a->data[iacol_tmp + k];
      }
    }
  }
}

void repmat(const emlrtStack *sp, const emxArray_real_T *a, const real_T
            varargin_1[2], emxArray_real_T *b)
{
  emlrtStack b_st;
  emlrtStack st;
  int32_T ibtile;
  int32_T jtilecol;
  int32_T k;
  int32_T nrows;
  int32_T ntilecols;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &lb_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  assertValidSizeArg(&st, varargin_1);
  nrows = b->size[0] * b->size[1];
  b->size[0] = a->size[0];
  b->size[1] = (int32_T)varargin_1[1];
  emxEnsureCapacity_real_T(sp, b, nrows, &kc_emlrtRTEI);
  nrows = a->size[0];
  ntilecols = (int32_T)varargin_1[1];
  st.site = &mb_emlrtRSI;
  if ((1 <= (int32_T)varargin_1[1]) && ((int32_T)varargin_1[1] > 2147483646)) {
    b_st.site = &eb_emlrtRSI;
    check_forloop_overflow_error(&b_st);
  }

  for (jtilecol = 0; jtilecol < ntilecols; jtilecol++) {
    ibtile = jtilecol * nrows;
    st.site = &nb_emlrtRSI;
    st.site = &ob_emlrtRSI;
    if ((1 <= nrows) && (nrows > 2147483646)) {
      b_st.site = &eb_emlrtRSI;
      check_forloop_overflow_error(&b_st);
    }

    for (k = 0; k < nrows; k++) {
      b->data[ibtile + k] = a->data[k];
    }
  }
}

/* End of code generation (repmat.c) */
