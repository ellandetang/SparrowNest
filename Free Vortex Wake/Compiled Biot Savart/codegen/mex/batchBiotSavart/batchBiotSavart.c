/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * batchBiotSavart.c
 *
 * Code generation for function 'batchBiotSavart'
 *
 */

/* Include files */
#include "batchBiotSavart.h"
#include "abs.h"
#include "batchBiotSavart_emxutil.h"
#include "batchBiotSavart_types.h"
#include "cross.h"
#include "dot.h"
#include "power.h"
#include "repmat.h"
#include "rt_nonfinite.h"
#include "sqrt.h"
#include "sum.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 14,    /* lineNo */
  "batchBiotSavart",                   /* fcnName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pathName */
};

static emlrtRSInfo b_emlrtRSI = { 20,  /* lineNo */
  "batchBiotSavart",                   /* fcnName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pathName */
};

static emlrtRSInfo c_emlrtRSI = { 21,  /* lineNo */
  "batchBiotSavart",                   /* fcnName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pathName */
};

static emlrtRSInfo d_emlrtRSI = { 22,  /* lineNo */
  "batchBiotSavart",                   /* fcnName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pathName */
};

static emlrtRSInfo e_emlrtRSI = { 24,  /* lineNo */
  "batchBiotSavart",                   /* fcnName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pathName */
};

static emlrtRSInfo f_emlrtRSI = { 31,  /* lineNo */
  "batchBiotSavart",                   /* fcnName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pathName */
};

static emlrtRSInfo g_emlrtRSI = { 32,  /* lineNo */
  "batchBiotSavart",                   /* fcnName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pathName */
};

static emlrtRSInfo h_emlrtRSI = { 33,  /* lineNo */
  "batchBiotSavart",                   /* fcnName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pathName */
};

static emlrtRSInfo i_emlrtRSI = { 35,  /* lineNo */
  "batchBiotSavart",                   /* fcnName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pathName */
};

static emlrtRSInfo j_emlrtRSI = { 38,  /* lineNo */
  "batchBiotSavart",                   /* fcnName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pathName */
};

static emlrtRSInfo k_emlrtRSI = { 39,  /* lineNo */
  "batchBiotSavart",                   /* fcnName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pathName */
};

static emlrtRSInfo l_emlrtRSI = { 40,  /* lineNo */
  "batchBiotSavart",                   /* fcnName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pathName */
};

static emlrtRSInfo m_emlrtRSI = { 42,  /* lineNo */
  "batchBiotSavart",                   /* fcnName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pathName */
};

static emlrtRSInfo n_emlrtRSI = { 46,  /* lineNo */
  "batchBiotSavart",                   /* fcnName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pathName */
};

static emlrtRSInfo o_emlrtRSI = { 47,  /* lineNo */
  "batchBiotSavart",                   /* fcnName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pathName */
};

static emlrtRSInfo p_emlrtRSI = { 48,  /* lineNo */
  "batchBiotSavart",                   /* fcnName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pathName */
};

static emlrtRSInfo q_emlrtRSI = { 49,  /* lineNo */
  "batchBiotSavart",                   /* fcnName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pathName */
};

static emlrtRSInfo r_emlrtRSI = { 50,  /* lineNo */
  "batchBiotSavart",                   /* fcnName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pathName */
};

static emlrtRSInfo s_emlrtRSI = { 51,  /* lineNo */
  "batchBiotSavart",                   /* fcnName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pathName */
};

static emlrtRSInfo t_emlrtRSI = { 53,  /* lineNo */
  "batchBiotSavart",                   /* fcnName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pathName */
};

static emlrtRSInfo u_emlrtRSI = { 55,  /* lineNo */
  "batchBiotSavart",                   /* fcnName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pathName */
};

static emlrtRSInfo v_emlrtRSI = { 56,  /* lineNo */
  "batchBiotSavart",                   /* fcnName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pathName */
};

static emlrtRSInfo w_emlrtRSI = { 59,  /* lineNo */
  "batchBiotSavart",                   /* fcnName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pathName */
};

static emlrtRSInfo x_emlrtRSI = { 67,  /* lineNo */
  "batchBiotSavart",                   /* fcnName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pathName */
};

static emlrtRSInfo y_emlrtRSI = { 69,  /* lineNo */
  "batchBiotSavart",                   /* fcnName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pathName */
};

static emlrtRSInfo yb_emlrtRSI = { 22, /* lineNo */
  "cat",                               /* fcnName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\eml\\+coder\\+internal\\cat.m"/* pathName */
};

static emlrtECInfo emlrtECI = { 2,     /* nDims */
  13,                                  /* lineNo */
  5,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtECInfo b_emlrtECI = { 2,   /* nDims */
  31,                                  /* lineNo */
  13,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtECInfo c_emlrtECI = { 2,   /* nDims */
  32,                                  /* lineNo */
  13,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtECInfo d_emlrtECI = { 2,   /* nDims */
  33,                                  /* lineNo */
  13,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtECInfo e_emlrtECI = { -1,  /* nDims */
  31,                                  /* lineNo */
  1,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtECInfo f_emlrtECI = { -1,  /* nDims */
  32,                                  /* lineNo */
  1,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtECInfo g_emlrtECI = { -1,  /* nDims */
  33,                                  /* lineNo */
  1,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtECInfo h_emlrtECI = { 2,   /* nDims */
  38,                                  /* lineNo */
  13,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtECInfo i_emlrtECI = { 2,   /* nDims */
  39,                                  /* lineNo */
  13,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtECInfo j_emlrtECI = { 2,   /* nDims */
  40,                                  /* lineNo */
  13,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtECInfo k_emlrtECI = { -1,  /* nDims */
  38,                                  /* lineNo */
  1,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtECInfo l_emlrtECI = { -1,  /* nDims */
  39,                                  /* lineNo */
  1,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtECInfo m_emlrtECI = { -1,  /* nDims */
  40,                                  /* lineNo */
  1,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtECInfo n_emlrtECI = { -1,  /* nDims */
  20,                                  /* lineNo */
  1,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtECInfo o_emlrtECI = { -1,  /* nDims */
  21,                                  /* lineNo */
  1,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtECInfo p_emlrtECI = { -1,  /* nDims */
  22,                                  /* lineNo */
  1,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtECInfo q_emlrtECI = { 2,   /* nDims */
  46,                                  /* lineNo */
  22,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtECInfo r_emlrtECI = { 2,   /* nDims */
  47,                                  /* lineNo */
  22,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtECInfo s_emlrtECI = { 2,   /* nDims */
  53,                                  /* lineNo */
  21,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtECInfo t_emlrtECI = { 2,   /* nDims */
  53,                                  /* lineNo */
  10,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtECInfo u_emlrtECI = { 2,   /* nDims */
  59,                                  /* lineNo */
  47,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtECInfo v_emlrtECI = { 2,   /* nDims */
  59,                                  /* lineNo */
  12,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtECInfo w_emlrtECI = { 2,   /* nDims */
  59,                                  /* lineNo */
  79,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtECInfo x_emlrtECI = { 2,   /* nDims */
  65,                                  /* lineNo */
  10,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtECInfo y_emlrtECI = { 3,   /* nDims */
  67,                                  /* lineNo */
  14,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo emlrtRTEI = { 20,  /* lineNo */
  15,                                  /* colNo */
  "rdivide_helper",                    /* fName */
  "F:\\Program Files\\MATLAB\\R2020b\\toolbox\\eml\\eml\\+coder\\+internal\\rdivide_helper.m"/* pName */
};

static emlrtBCInfo emlrtBCI = { -1,    /* iFirst */
  -1,                                  /* iLast */
  48,                                  /* lineNo */
  1,                                   /* colNo */
  "c1",                                /* aName */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo b_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  49,                                  /* lineNo */
  1,                                   /* colNo */
  "c1",                                /* aName */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo c_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  50,                                  /* lineNo */
  1,                                   /* colNo */
  "c2",                                /* aName */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo d_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  51,                                  /* lineNo */
  1,                                   /* colNo */
  "c2",                                /* aName */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo e_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  65,                                  /* lineNo */
  1,                                   /* colNo */
  "AvMatrix",                          /* aName */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m",/* pName */
  0                                    /* checkKind */
};

static emlrtRTEInfo i_emlrtRTEI = { 13,/* lineNo */
  1,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo j_emlrtRTEI = { 19,/* lineNo */
  1,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo k_emlrtRTEI = { 20,/* lineNo */
  21,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo l_emlrtRTEI = { 21,/* lineNo */
  21,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo m_emlrtRTEI = { 22,/* lineNo */
  21,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo n_emlrtRTEI = { 24,/* lineNo */
  17,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo o_emlrtRTEI = { 30,/* lineNo */
  1,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo p_emlrtRTEI = { 31,/* lineNo */
  20,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo q_emlrtRTEI = { 31,/* lineNo */
  44,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo r_emlrtRTEI = { 32,/* lineNo */
  20,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo s_emlrtRTEI = { 32,/* lineNo */
  44,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo t_emlrtRTEI = { 33,/* lineNo */
  20,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo u_emlrtRTEI = { 33,/* lineNo */
  44,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo v_emlrtRTEI = { 37,/* lineNo */
  1,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo w_emlrtRTEI = { 38,/* lineNo */
  20,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo x_emlrtRTEI = { 38,/* lineNo */
  44,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo y_emlrtRTEI = { 39,/* lineNo */
  20,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo ab_emlrtRTEI = { 39,/* lineNo */
  44,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo bb_emlrtRTEI = { 40,/* lineNo */
  20,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo cb_emlrtRTEI = { 40,/* lineNo */
  44,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo db_emlrtRTEI = { 46,/* lineNo */
  22,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo eb_emlrtRTEI = { 48,/* lineNo */
  8,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo fb_emlrtRTEI = { 48,/* lineNo */
  4,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo gb_emlrtRTEI = { 1,/* lineNo */
  16,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo hb_emlrtRTEI = { 49,/* lineNo */
  8,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo ib_emlrtRTEI = { 49,/* lineNo */
  4,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo jb_emlrtRTEI = { 50,/* lineNo */
  8,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo kb_emlrtRTEI = { 50,/* lineNo */
  4,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo lb_emlrtRTEI = { 51,/* lineNo */
  8,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo mb_emlrtRTEI = { 51,/* lineNo */
  4,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo nb_emlrtRTEI = { 59,/* lineNo */
  54,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo ob_emlrtRTEI = { 59,/* lineNo */
  19,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo pb_emlrtRTEI = { 59,/* lineNo */
  43,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo qb_emlrtRTEI = { 65,/* lineNo */
  10,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo rb_emlrtRTEI = { 65,/* lineNo */
  19,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo sb_emlrtRTEI = { 65,/* lineNo */
  32,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo tb_emlrtRTEI = { 65,/* lineNo */
  45,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo ub_emlrtRTEI = { 67,/* lineNo */
  14,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo vb_emlrtRTEI = { 69,/* lineNo */
  1,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo wb_emlrtRTEI = { 14,/* lineNo */
  1,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo xb_emlrtRTEI = { 24,/* lineNo */
  1,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo yb_emlrtRTEI = { 35,/* lineNo */
  1,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo ac_emlrtRTEI = { 42,/* lineNo */
  1,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo bc_emlrtRTEI = { 46,/* lineNo */
  1,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo cc_emlrtRTEI = { 47,/* lineNo */
  1,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo dc_emlrtRTEI = { 53,/* lineNo */
  1,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo ec_emlrtRTEI = { 59,/* lineNo */
  1,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo fc_emlrtRTEI = { 67,/* lineNo */
  1,                                   /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo gc_emlrtRTEI = { 14,/* lineNo */
  17,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

static emlrtRTEInfo hc_emlrtRTEI = { 35,/* lineNo */
  18,                                  /* colNo */
  "batchBiotSavart",                   /* fName */
  "E:\\Desktop\\Git\\SparrowNest\\Free Vortex Wake\\Compiled Biot Savart\\batchBiotSavart.m"/* pName */
};

/* Function Definitions */
void batchBiotSavart(const emlrtStack *sp, const emxArray_real_T *startPoints,
                     const emxArray_real_T *endPoints, const emxArray_real_T
                     *Gamma, const emxArray_real_T *rc, const emxArray_real_T
                     *samplePoints, emxArray_real_T *V)
{
  emlrtStack b_st;
  emlrtStack st;
  emxArray_boolean_T *r3;
  emxArray_boolean_T *r8;
  emxArray_int32_T *r4;
  emxArray_int32_T *r5;
  emxArray_int32_T *r6;
  emxArray_int32_T *r7;
  emxArray_int32_T *r9;
  emxArray_real_T *AvMatrix;
  emxArray_real_T *V_temp;
  emxArray_real_T *b_l;
  emxArray_real_T *b_r1;
  emxArray_real_T *b_r2;
  emxArray_real_T *c1;
  emxArray_real_T *c2;
  emxArray_real_T *h;
  emxArray_real_T *l;
  emxArray_real_T *l12;
  emxArray_real_T *l12mag;
  emxArray_real_T *lmag;
  emxArray_real_T *r;
  emxArray_real_T *r1;
  emxArray_real_T *r1mag;
  emxArray_real_T *r2;
  emxArray_real_T *r2mag;
  emxArray_real_T *y;
  real_T b_startPoints[2];
  int32_T c_startPoints[2];
  int32_T b_loop_ub;
  int32_T i;
  int32_T loop_ub;
  int32_T trueCount;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  emxInit_real_T(sp, &l, 2, &i_emlrtRTEI, true);

  /*  startPoints 3xn matrix of start coordinates for filaments */
  /*  endPoints 3xn matrix of start coordinates for filaments, must be same */
  /*  size as startPoints */
  /*  Gamma 1xn array of vortex strengths */
  /*  rc 1xn array of core sizes */
  /*  samplePoints 3xm matrix of coordinates to sample */
  /*  Filament vector */
  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])endPoints->size, *(int32_T (*)[2])
    startPoints->size, &emlrtECI, sp);
  i = l->size[0] * l->size[1];
  l->size[0] = 3;
  l->size[1] = endPoints->size[1];
  emxEnsureCapacity_real_T(sp, l, i, &i_emlrtRTEI);
  loop_ub = endPoints->size[0] * endPoints->size[1];
  for (i = 0; i < loop_ub; i++) {
    l->data[i] = endPoints->data[i] - startPoints->data[i];
  }

  emxInit_real_T(sp, &lmag, 2, &wb_emlrtRTEI, true);
  emxInit_real_T(sp, &l12, 3, &j_emlrtRTEI, true);
  emxInit_real_T(sp, &r, 2, &gc_emlrtRTEI, true);
  st.site = &emlrtRSI;
  power(&st, l, r);
  st.site = &emlrtRSI;
  sum(&st, r, lmag);
  st.site = &emlrtRSI;
  b_sqrt(&st, lmag);

  /*  Split sample vector into components row is filament, column is sample, */
  /*  depth is components */
  i = l12->size[0] * l12->size[1] * l12->size[2];
  l12->size[0] = startPoints->size[1];
  l12->size[1] = samplePoints->size[1];
  l12->size[2] = 3;
  emxEnsureCapacity_real_T(sp, l12, i, &j_emlrtRTEI);
  loop_ub = startPoints->size[1] * samplePoints->size[1] * 3;
  emxFree_real_T(&r);
  for (i = 0; i < loop_ub; i++) {
    l12->data[i] = 0.0;
  }

  emxInit_real_T(sp, &b_l, 1, &k_emlrtRTEI, true);
  loop_ub = l->size[1];
  i = b_l->size[0];
  b_l->size[0] = l->size[1];
  emxEnsureCapacity_real_T(sp, b_l, i, &k_emlrtRTEI);
  for (i = 0; i < loop_ub; i++) {
    b_l->data[i] = l->data[3 * i];
  }

  emxInit_real_T(sp, &r1, 2, &fb_emlrtRTEI, true);
  b_startPoints[0] = 1.0;
  b_startPoints[1] = samplePoints->size[1];
  st.site = &b_emlrtRSI;
  repmat(&st, b_l, b_startPoints, r1);
  c_startPoints[0] = startPoints->size[1];
  c_startPoints[1] = samplePoints->size[1];
  emlrtSubAssignSizeCheckR2012b(&c_startPoints[0], 2, &r1->size[0], 2,
    &n_emlrtECI, sp);
  loop_ub = r1->size[1];
  for (i = 0; i < loop_ub; i++) {
    b_loop_ub = r1->size[0];
    for (trueCount = 0; trueCount < b_loop_ub; trueCount++) {
      l12->data[trueCount + l12->size[0] * i] = r1->data[trueCount + r1->size[0]
        * i];
    }
  }

  loop_ub = l->size[1];
  i = b_l->size[0];
  b_l->size[0] = l->size[1];
  emxEnsureCapacity_real_T(sp, b_l, i, &l_emlrtRTEI);
  for (i = 0; i < loop_ub; i++) {
    b_l->data[i] = l->data[3 * i + 1];
  }

  b_startPoints[0] = 1.0;
  b_startPoints[1] = samplePoints->size[1];
  st.site = &c_emlrtRSI;
  repmat(&st, b_l, b_startPoints, r1);
  c_startPoints[0] = l12->size[0];
  c_startPoints[1] = l12->size[1];
  emlrtSubAssignSizeCheckR2012b(&c_startPoints[0], 2, &r1->size[0], 2,
    &o_emlrtECI, sp);
  loop_ub = r1->size[1];
  for (i = 0; i < loop_ub; i++) {
    b_loop_ub = r1->size[0];
    for (trueCount = 0; trueCount < b_loop_ub; trueCount++) {
      l12->data[(trueCount + l12->size[0] * i) + l12->size[0] * l12->size[1]] =
        r1->data[trueCount + r1->size[0] * i];
    }
  }

  loop_ub = l->size[1];
  i = b_l->size[0];
  b_l->size[0] = l->size[1];
  emxEnsureCapacity_real_T(sp, b_l, i, &m_emlrtRTEI);
  for (i = 0; i < loop_ub; i++) {
    b_l->data[i] = l->data[3 * i + 2];
  }

  emxFree_real_T(&l);
  b_startPoints[0] = 1.0;
  b_startPoints[1] = samplePoints->size[1];
  st.site = &d_emlrtRSI;
  repmat(&st, b_l, b_startPoints, r1);
  c_startPoints[0] = l12->size[0];
  c_startPoints[1] = l12->size[1];
  emlrtSubAssignSizeCheckR2012b(&c_startPoints[0], 2, &r1->size[0], 2,
    &p_emlrtECI, sp);
  loop_ub = r1->size[1];
  for (i = 0; i < loop_ub; i++) {
    b_loop_ub = r1->size[0];
    for (trueCount = 0; trueCount < b_loop_ub; trueCount++) {
      l12->data[(trueCount + l12->size[0] * i) + l12->size[0] * l12->size[1] * 2]
        = r1->data[trueCount + r1->size[0] * i];
    }
  }

  i = b_l->size[0];
  b_l->size[0] = lmag->size[1];
  emxEnsureCapacity_real_T(sp, b_l, i, &n_emlrtRTEI);
  loop_ub = lmag->size[1];
  for (i = 0; i < loop_ub; i++) {
    b_l->data[i] = lmag->data[i];
  }

  emxInit_real_T(sp, &l12mag, 2, &xb_emlrtRTEI, true);
  emxInit_real_T(sp, &b_r1, 3, &o_emlrtRTEI, true);
  b_startPoints[0] = 1.0;
  b_startPoints[1] = samplePoints->size[1];
  st.site = &e_emlrtRSI;
  repmat(&st, b_l, b_startPoints, l12mag);
  i = b_r1->size[0] * b_r1->size[1] * b_r1->size[2];
  b_r1->size[0] = startPoints->size[1];
  b_r1->size[1] = samplePoints->size[1];
  b_r1->size[2] = 3;
  emxEnsureCapacity_real_T(sp, b_r1, i, &o_emlrtRTEI);
  loop_ub = startPoints->size[1] * samplePoints->size[1] * 3;
  for (i = 0; i < loop_ub; i++) {
    b_r1->data[i] = 0.0;
  }

  loop_ub = samplePoints->size[1];
  i = lmag->size[0] * lmag->size[1];
  lmag->size[0] = 1;
  lmag->size[1] = samplePoints->size[1];
  emxEnsureCapacity_real_T(sp, lmag, i, &p_emlrtRTEI);
  for (i = 0; i < loop_ub; i++) {
    lmag->data[i] = samplePoints->data[3 * i];
  }

  b_startPoints[0] = startPoints->size[1];
  b_startPoints[1] = 1.0;
  st.site = &f_emlrtRSI;
  b_repmat(&st, lmag, b_startPoints, r1);
  loop_ub = startPoints->size[1];
  i = b_l->size[0];
  b_l->size[0] = startPoints->size[1];
  emxEnsureCapacity_real_T(sp, b_l, i, &q_emlrtRTEI);
  for (i = 0; i < loop_ub; i++) {
    b_l->data[i] = startPoints->data[3 * i];
  }

  emxInit_real_T(sp, &h, 2, &dc_emlrtRTEI, true);
  b_startPoints[0] = 1.0;
  b_startPoints[1] = samplePoints->size[1];
  st.site = &f_emlrtRSI;
  repmat(&st, b_l, b_startPoints, h);
  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])r1->size, *(int32_T (*)[2])h->size,
    &b_emlrtECI, sp);
  c_startPoints[0] = startPoints->size[1];
  c_startPoints[1] = samplePoints->size[1];
  emlrtSubAssignSizeCheckR2012b(&c_startPoints[0], 2, &r1->size[0], 2,
    &e_emlrtECI, sp);
  loop_ub = r1->size[1];
  for (i = 0; i < loop_ub; i++) {
    b_loop_ub = r1->size[0];
    for (trueCount = 0; trueCount < b_loop_ub; trueCount++) {
      b_r1->data[trueCount + b_r1->size[0] * i] = r1->data[trueCount + r1->size
        [0] * i] - h->data[trueCount + h->size[0] * i];
    }
  }

  loop_ub = samplePoints->size[1];
  i = lmag->size[0] * lmag->size[1];
  lmag->size[0] = 1;
  lmag->size[1] = samplePoints->size[1];
  emxEnsureCapacity_real_T(sp, lmag, i, &r_emlrtRTEI);
  for (i = 0; i < loop_ub; i++) {
    lmag->data[i] = samplePoints->data[3 * i + 1];
  }

  b_startPoints[0] = startPoints->size[1];
  b_startPoints[1] = 1.0;
  st.site = &g_emlrtRSI;
  b_repmat(&st, lmag, b_startPoints, r1);
  loop_ub = startPoints->size[1];
  i = b_l->size[0];
  b_l->size[0] = startPoints->size[1];
  emxEnsureCapacity_real_T(sp, b_l, i, &s_emlrtRTEI);
  for (i = 0; i < loop_ub; i++) {
    b_l->data[i] = startPoints->data[3 * i + 1];
  }

  b_startPoints[0] = 1.0;
  b_startPoints[1] = samplePoints->size[1];
  st.site = &g_emlrtRSI;
  repmat(&st, b_l, b_startPoints, h);
  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])r1->size, *(int32_T (*)[2])h->size,
    &c_emlrtECI, sp);
  c_startPoints[0] = b_r1->size[0];
  c_startPoints[1] = b_r1->size[1];
  emlrtSubAssignSizeCheckR2012b(&c_startPoints[0], 2, &r1->size[0], 2,
    &f_emlrtECI, sp);
  loop_ub = r1->size[1];
  for (i = 0; i < loop_ub; i++) {
    b_loop_ub = r1->size[0];
    for (trueCount = 0; trueCount < b_loop_ub; trueCount++) {
      b_r1->data[(trueCount + b_r1->size[0] * i) + b_r1->size[0] * b_r1->size[1]]
        = r1->data[trueCount + r1->size[0] * i] - h->data[trueCount + h->size[0]
        * i];
    }
  }

  loop_ub = samplePoints->size[1];
  i = lmag->size[0] * lmag->size[1];
  lmag->size[0] = 1;
  lmag->size[1] = samplePoints->size[1];
  emxEnsureCapacity_real_T(sp, lmag, i, &t_emlrtRTEI);
  for (i = 0; i < loop_ub; i++) {
    lmag->data[i] = samplePoints->data[3 * i + 2];
  }

  b_startPoints[0] = startPoints->size[1];
  b_startPoints[1] = 1.0;
  st.site = &h_emlrtRSI;
  b_repmat(&st, lmag, b_startPoints, r1);
  loop_ub = startPoints->size[1];
  i = b_l->size[0];
  b_l->size[0] = startPoints->size[1];
  emxEnsureCapacity_real_T(sp, b_l, i, &u_emlrtRTEI);
  for (i = 0; i < loop_ub; i++) {
    b_l->data[i] = startPoints->data[3 * i + 2];
  }

  b_startPoints[0] = 1.0;
  b_startPoints[1] = samplePoints->size[1];
  st.site = &h_emlrtRSI;
  repmat(&st, b_l, b_startPoints, h);
  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])r1->size, *(int32_T (*)[2])h->size,
    &d_emlrtECI, sp);
  c_startPoints[0] = b_r1->size[0];
  c_startPoints[1] = b_r1->size[1];
  emlrtSubAssignSizeCheckR2012b(&c_startPoints[0], 2, &r1->size[0], 2,
    &g_emlrtECI, sp);
  loop_ub = r1->size[1];
  for (i = 0; i < loop_ub; i++) {
    b_loop_ub = r1->size[0];
    for (trueCount = 0; trueCount < b_loop_ub; trueCount++) {
      b_r1->data[(trueCount + b_r1->size[0] * i) + b_r1->size[0] * b_r1->size[1]
        * 2] = r1->data[trueCount + r1->size[0] * i] - h->data[trueCount +
        h->size[0] * i];
    }
  }

  emxInit_real_T(sp, &r1mag, 2, &yb_emlrtRTEI, true);
  emxInit_real_T(sp, &r2, 3, &v_emlrtRTEI, true);
  emxInit_real_T(sp, &b_r2, 3, &hc_emlrtRTEI, true);
  st.site = &i_emlrtRSI;
  b_power(&st, b_r1, b_r2);
  st.site = &i_emlrtRSI;
  b_sum(&st, b_r2, r1mag);
  st.site = &i_emlrtRSI;
  c_sqrt(&st, r1mag);
  i = r2->size[0] * r2->size[1] * r2->size[2];
  r2->size[0] = startPoints->size[1];
  r2->size[1] = samplePoints->size[1];
  r2->size[2] = 3;
  emxEnsureCapacity_real_T(sp, r2, i, &v_emlrtRTEI);
  loop_ub = startPoints->size[1] * samplePoints->size[1] * 3;
  for (i = 0; i < loop_ub; i++) {
    r2->data[i] = 0.0;
  }

  loop_ub = samplePoints->size[1];
  i = lmag->size[0] * lmag->size[1];
  lmag->size[0] = 1;
  lmag->size[1] = samplePoints->size[1];
  emxEnsureCapacity_real_T(sp, lmag, i, &w_emlrtRTEI);
  for (i = 0; i < loop_ub; i++) {
    lmag->data[i] = samplePoints->data[3 * i];
  }

  b_startPoints[0] = startPoints->size[1];
  b_startPoints[1] = 1.0;
  st.site = &j_emlrtRSI;
  b_repmat(&st, lmag, b_startPoints, r1);
  loop_ub = endPoints->size[1];
  i = b_l->size[0];
  b_l->size[0] = endPoints->size[1];
  emxEnsureCapacity_real_T(sp, b_l, i, &x_emlrtRTEI);
  for (i = 0; i < loop_ub; i++) {
    b_l->data[i] = endPoints->data[3 * i];
  }

  b_startPoints[0] = 1.0;
  b_startPoints[1] = samplePoints->size[1];
  st.site = &j_emlrtRSI;
  repmat(&st, b_l, b_startPoints, h);
  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])r1->size, *(int32_T (*)[2])h->size,
    &h_emlrtECI, sp);
  c_startPoints[0] = startPoints->size[1];
  c_startPoints[1] = samplePoints->size[1];
  emlrtSubAssignSizeCheckR2012b(&c_startPoints[0], 2, &r1->size[0], 2,
    &k_emlrtECI, sp);
  loop_ub = r1->size[1];
  for (i = 0; i < loop_ub; i++) {
    b_loop_ub = r1->size[0];
    for (trueCount = 0; trueCount < b_loop_ub; trueCount++) {
      r2->data[trueCount + r2->size[0] * i] = r1->data[trueCount + r1->size[0] *
        i] - h->data[trueCount + h->size[0] * i];
    }
  }

  loop_ub = samplePoints->size[1];
  i = lmag->size[0] * lmag->size[1];
  lmag->size[0] = 1;
  lmag->size[1] = samplePoints->size[1];
  emxEnsureCapacity_real_T(sp, lmag, i, &y_emlrtRTEI);
  for (i = 0; i < loop_ub; i++) {
    lmag->data[i] = samplePoints->data[3 * i + 1];
  }

  b_startPoints[0] = startPoints->size[1];
  b_startPoints[1] = 1.0;
  st.site = &k_emlrtRSI;
  b_repmat(&st, lmag, b_startPoints, r1);
  loop_ub = endPoints->size[1];
  i = b_l->size[0];
  b_l->size[0] = endPoints->size[1];
  emxEnsureCapacity_real_T(sp, b_l, i, &ab_emlrtRTEI);
  for (i = 0; i < loop_ub; i++) {
    b_l->data[i] = endPoints->data[3 * i + 1];
  }

  b_startPoints[0] = 1.0;
  b_startPoints[1] = samplePoints->size[1];
  st.site = &k_emlrtRSI;
  repmat(&st, b_l, b_startPoints, h);
  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])r1->size, *(int32_T (*)[2])h->size,
    &i_emlrtECI, sp);
  c_startPoints[0] = r2->size[0];
  c_startPoints[1] = r2->size[1];
  emlrtSubAssignSizeCheckR2012b(&c_startPoints[0], 2, &r1->size[0], 2,
    &l_emlrtECI, sp);
  loop_ub = r1->size[1];
  for (i = 0; i < loop_ub; i++) {
    b_loop_ub = r1->size[0];
    for (trueCount = 0; trueCount < b_loop_ub; trueCount++) {
      r2->data[(trueCount + r2->size[0] * i) + r2->size[0] * r2->size[1]] =
        r1->data[trueCount + r1->size[0] * i] - h->data[trueCount + h->size[0] *
        i];
    }
  }

  loop_ub = samplePoints->size[1];
  i = lmag->size[0] * lmag->size[1];
  lmag->size[0] = 1;
  lmag->size[1] = samplePoints->size[1];
  emxEnsureCapacity_real_T(sp, lmag, i, &bb_emlrtRTEI);
  for (i = 0; i < loop_ub; i++) {
    lmag->data[i] = samplePoints->data[3 * i + 2];
  }

  b_startPoints[0] = startPoints->size[1];
  b_startPoints[1] = 1.0;
  st.site = &l_emlrtRSI;
  b_repmat(&st, lmag, b_startPoints, r1);
  loop_ub = endPoints->size[1];
  i = b_l->size[0];
  b_l->size[0] = endPoints->size[1];
  emxEnsureCapacity_real_T(sp, b_l, i, &cb_emlrtRTEI);
  emxFree_real_T(&lmag);
  for (i = 0; i < loop_ub; i++) {
    b_l->data[i] = endPoints->data[3 * i + 2];
  }

  b_startPoints[0] = 1.0;
  b_startPoints[1] = samplePoints->size[1];
  st.site = &l_emlrtRSI;
  repmat(&st, b_l, b_startPoints, h);
  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])r1->size, *(int32_T (*)[2])h->size,
    &j_emlrtECI, sp);
  c_startPoints[0] = r2->size[0];
  c_startPoints[1] = r2->size[1];
  emlrtSubAssignSizeCheckR2012b(&c_startPoints[0], 2, &r1->size[0], 2,
    &m_emlrtECI, sp);
  loop_ub = r1->size[1];
  for (i = 0; i < loop_ub; i++) {
    b_loop_ub = r1->size[0];
    for (trueCount = 0; trueCount < b_loop_ub; trueCount++) {
      r2->data[(trueCount + r2->size[0] * i) + r2->size[0] * r2->size[1] * 2] =
        r1->data[trueCount + r1->size[0] * i] - h->data[trueCount + h->size[0] *
        i];
    }
  }

  emxInit_real_T(sp, &r2mag, 2, &ac_emlrtRTEI, true);
  emxInit_real_T(sp, &c1, 2, &bc_emlrtRTEI, true);
  emxInit_real_T(sp, &y, 2, &db_emlrtRTEI, true);
  st.site = &m_emlrtRSI;
  b_power(&st, r2, b_r2);
  st.site = &m_emlrtRSI;
  b_sum(&st, b_r2, r2mag);
  st.site = &m_emlrtRSI;
  c_sqrt(&st, r2mag);

  /*  c1 = dot(l12./repmat(l12mag,[1,1,3]),r1./repmat(r1mag,[1,1,3]),3); */
  /*  c2 = dot(l12./repmat(l12mag,[1,1,3]),r2./repmat(r2mag,[1,1,3]),3); */
  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])l12mag->size, *(int32_T (*)[2])
    r1mag->size, &q_emlrtECI, sp);
  st.site = &n_emlrtRSI;
  b_st.site = &n_emlrtRSI;
  dot(&b_st, l12, b_r1, c1);
  i = y->size[0] * y->size[1];
  y->size[0] = l12mag->size[0];
  y->size[1] = l12mag->size[1];
  emxEnsureCapacity_real_T(&st, y, i, &db_emlrtRTEI);
  loop_ub = l12mag->size[0] * l12mag->size[1];
  for (i = 0; i < loop_ub; i++) {
    y->data[i] = l12mag->data[i] * r1mag->data[i];
  }

  if ((c1->size[0] != y->size[0]) || (c1->size[1] != y->size[1])) {
    emlrtErrorWithMessageIdR2018a(&st, &emlrtRTEI, "MATLAB:dimagree",
      "MATLAB:dimagree", 0);
  }

  loop_ub = c1->size[0] * c1->size[1];
  for (i = 0; i < loop_ub; i++) {
    c1->data[i] /= y->data[i];
  }

  emxInit_real_T(&st, &c2, 2, &cc_emlrtRTEI, true);
  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])l12mag->size, *(int32_T (*)[2])
    r2mag->size, &r_emlrtECI, sp);
  st.site = &o_emlrtRSI;
  b_st.site = &o_emlrtRSI;
  dot(&b_st, l12, r2, c2);
  loop_ub = l12mag->size[0] * l12mag->size[1];
  for (i = 0; i < loop_ub; i++) {
    l12mag->data[i] *= r2mag->data[i];
  }

  if ((c2->size[0] != l12mag->size[0]) || (c2->size[1] != l12mag->size[1])) {
    emlrtErrorWithMessageIdR2018a(&st, &emlrtRTEI, "MATLAB:dimagree",
      "MATLAB:dimagree", 0);
  }

  loop_ub = c2->size[0] * c2->size[1];
  for (i = 0; i < loop_ub; i++) {
    c2->data[i] /= l12mag->data[i];
  }

  i = l12mag->size[0] * l12mag->size[1];
  l12mag->size[0] = c1->size[0];
  l12mag->size[1] = c1->size[1];
  emxEnsureCapacity_real_T(sp, l12mag, i, &eb_emlrtRTEI);
  loop_ub = c1->size[0] * c1->size[1];
  for (i = 0; i < loop_ub; i++) {
    l12mag->data[i] = c1->data[i] - 1.0;
  }

  emxInit_boolean_T(sp, &r3, 2, &fb_emlrtRTEI, true);
  st.site = &p_emlrtRSI;
  b_abs(&st, l12mag, r1);
  i = r3->size[0] * r3->size[1];
  r3->size[0] = r1->size[0];
  r3->size[1] = r1->size[1];
  emxEnsureCapacity_boolean_T(sp, r3, i, &fb_emlrtRTEI);
  loop_ub = r1->size[0] * r1->size[1];
  for (i = 0; i < loop_ub; i++) {
    r3->data[i] = (r1->data[i] < 0.0001);
  }

  b_loop_ub = r3->size[0] * r3->size[1] - 1;
  trueCount = 0;
  for (loop_ub = 0; loop_ub <= b_loop_ub; loop_ub++) {
    if (r3->data[loop_ub]) {
      trueCount++;
    }
  }

  emxInit_int32_T(sp, &r4, 1, &gb_emlrtRTEI, true);
  i = r4->size[0];
  r4->size[0] = trueCount;
  emxEnsureCapacity_int32_T(sp, r4, i, &gb_emlrtRTEI);
  trueCount = 0;
  for (loop_ub = 0; loop_ub <= b_loop_ub; loop_ub++) {
    if (r3->data[loop_ub]) {
      r4->data[trueCount] = loop_ub + 1;
      trueCount++;
    }
  }

  loop_ub = r4->size[0] - 1;
  trueCount = c1->size[0] * c1->size[1];
  for (i = 0; i <= loop_ub; i++) {
    if ((r4->data[i] < 1) || (r4->data[i] > trueCount)) {
      emlrtDynamicBoundsCheckR2012b(r4->data[i], 1, trueCount, &emlrtBCI, sp);
    }

    c1->data[r4->data[i] - 1] = 1.0;
  }

  emxFree_int32_T(&r4);
  i = l12mag->size[0] * l12mag->size[1];
  l12mag->size[0] = c1->size[0];
  l12mag->size[1] = c1->size[1];
  emxEnsureCapacity_real_T(sp, l12mag, i, &hb_emlrtRTEI);
  loop_ub = c1->size[0] * c1->size[1];
  for (i = 0; i < loop_ub; i++) {
    l12mag->data[i] = c1->data[i] + 1.0;
  }

  st.site = &q_emlrtRSI;
  b_abs(&st, l12mag, r1);
  i = r3->size[0] * r3->size[1];
  r3->size[0] = r1->size[0];
  r3->size[1] = r1->size[1];
  emxEnsureCapacity_boolean_T(sp, r3, i, &ib_emlrtRTEI);
  loop_ub = r1->size[0] * r1->size[1];
  for (i = 0; i < loop_ub; i++) {
    r3->data[i] = (r1->data[i] < 0.0001);
  }

  b_loop_ub = r3->size[0] * r3->size[1] - 1;
  trueCount = 0;
  for (loop_ub = 0; loop_ub <= b_loop_ub; loop_ub++) {
    if (r3->data[loop_ub]) {
      trueCount++;
    }
  }

  emxInit_int32_T(sp, &r5, 1, &gb_emlrtRTEI, true);
  i = r5->size[0];
  r5->size[0] = trueCount;
  emxEnsureCapacity_int32_T(sp, r5, i, &gb_emlrtRTEI);
  trueCount = 0;
  for (loop_ub = 0; loop_ub <= b_loop_ub; loop_ub++) {
    if (r3->data[loop_ub]) {
      r5->data[trueCount] = loop_ub + 1;
      trueCount++;
    }
  }

  loop_ub = r5->size[0] - 1;
  trueCount = c1->size[0] * c1->size[1];
  for (i = 0; i <= loop_ub; i++) {
    if ((r5->data[i] < 1) || (r5->data[i] > trueCount)) {
      emlrtDynamicBoundsCheckR2012b(r5->data[i], 1, trueCount, &b_emlrtBCI, sp);
    }

    c1->data[r5->data[i] - 1] = -1.0;
  }

  emxFree_int32_T(&r5);
  i = l12mag->size[0] * l12mag->size[1];
  l12mag->size[0] = c2->size[0];
  l12mag->size[1] = c2->size[1];
  emxEnsureCapacity_real_T(sp, l12mag, i, &jb_emlrtRTEI);
  loop_ub = c2->size[0] * c2->size[1];
  for (i = 0; i < loop_ub; i++) {
    l12mag->data[i] = c2->data[i] - 1.0;
  }

  st.site = &r_emlrtRSI;
  b_abs(&st, l12mag, r1);
  i = r3->size[0] * r3->size[1];
  r3->size[0] = r1->size[0];
  r3->size[1] = r1->size[1];
  emxEnsureCapacity_boolean_T(sp, r3, i, &kb_emlrtRTEI);
  loop_ub = r1->size[0] * r1->size[1];
  for (i = 0; i < loop_ub; i++) {
    r3->data[i] = (r1->data[i] < 0.0001);
  }

  b_loop_ub = r3->size[0] * r3->size[1] - 1;
  trueCount = 0;
  for (loop_ub = 0; loop_ub <= b_loop_ub; loop_ub++) {
    if (r3->data[loop_ub]) {
      trueCount++;
    }
  }

  emxInit_int32_T(sp, &r6, 1, &gb_emlrtRTEI, true);
  i = r6->size[0];
  r6->size[0] = trueCount;
  emxEnsureCapacity_int32_T(sp, r6, i, &gb_emlrtRTEI);
  trueCount = 0;
  for (loop_ub = 0; loop_ub <= b_loop_ub; loop_ub++) {
    if (r3->data[loop_ub]) {
      r6->data[trueCount] = loop_ub + 1;
      trueCount++;
    }
  }

  loop_ub = r6->size[0] - 1;
  trueCount = c2->size[0] * c2->size[1];
  for (i = 0; i <= loop_ub; i++) {
    if ((r6->data[i] < 1) || (r6->data[i] > trueCount)) {
      emlrtDynamicBoundsCheckR2012b(r6->data[i], 1, trueCount, &c_emlrtBCI, sp);
    }

    c2->data[r6->data[i] - 1] = 1.0;
  }

  emxFree_int32_T(&r6);
  i = l12mag->size[0] * l12mag->size[1];
  l12mag->size[0] = c2->size[0];
  l12mag->size[1] = c2->size[1];
  emxEnsureCapacity_real_T(sp, l12mag, i, &lb_emlrtRTEI);
  loop_ub = c2->size[0] * c2->size[1];
  for (i = 0; i < loop_ub; i++) {
    l12mag->data[i] = c2->data[i] + 1.0;
  }

  st.site = &s_emlrtRSI;
  b_abs(&st, l12mag, r1);
  i = r3->size[0] * r3->size[1];
  r3->size[0] = r1->size[0];
  r3->size[1] = r1->size[1];
  emxEnsureCapacity_boolean_T(sp, r3, i, &mb_emlrtRTEI);
  loop_ub = r1->size[0] * r1->size[1];
  for (i = 0; i < loop_ub; i++) {
    r3->data[i] = (r1->data[i] < 0.0001);
  }

  b_loop_ub = r3->size[0] * r3->size[1] - 1;
  trueCount = 0;
  for (loop_ub = 0; loop_ub <= b_loop_ub; loop_ub++) {
    if (r3->data[loop_ub]) {
      trueCount++;
    }
  }

  emxInit_int32_T(sp, &r7, 1, &gb_emlrtRTEI, true);
  i = r7->size[0];
  r7->size[0] = trueCount;
  emxEnsureCapacity_int32_T(sp, r7, i, &gb_emlrtRTEI);
  trueCount = 0;
  for (loop_ub = 0; loop_ub <= b_loop_ub; loop_ub++) {
    if (r3->data[loop_ub]) {
      r7->data[trueCount] = loop_ub + 1;
      trueCount++;
    }
  }

  loop_ub = r7->size[0] - 1;
  trueCount = c2->size[0] * c2->size[1];
  for (i = 0; i <= loop_ub; i++) {
    if ((r7->data[i] < 1) || (r7->data[i] > trueCount)) {
      emlrtDynamicBoundsCheckR2012b(r7->data[i], 1, trueCount, &d_emlrtBCI, sp);
    }

    c2->data[r7->data[i] - 1] = -1.0;
  }

  emxFree_int32_T(&r7);
  st.site = &t_emlrtRSI;
  c_power(&st, c1, r1);
  c_startPoints[0] = startPoints->size[1];
  c_startPoints[1] = samplePoints->size[1];
  emlrtSizeEqCheckNDR2012b(c_startPoints, *(int32_T (*)[2])r1->size, &s_emlrtECI,
    sp);
  st.site = &t_emlrtRSI;
  c_power(&st, r1mag, h);
  c_startPoints[0] = startPoints->size[1];
  c_startPoints[1] = samplePoints->size[1];
  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])h->size, c_startPoints, &t_emlrtECI,
    sp);
  loop_ub = h->size[0] * h->size[1];
  for (i = 0; i < loop_ub; i++) {
    h->data[i] *= 1.0 - r1->data[i];
  }

  st.site = &t_emlrtRSI;
  c_sqrt(&st, h);
  st.site = &u_emlrtRSI;
  cross(&st, l12, b_r1, r2);
  st.site = &v_emlrtRSI;
  b_power(&st, r2, b_r2);
  st.site = &v_emlrtRSI;
  b_sum(&st, b_r2, l12mag);
  st.site = &v_emlrtRSI;
  c_sqrt(&st, l12mag);

  /*  try */
  i = b_l->size[0];
  b_l->size[0] = rc->size[1];
  emxEnsureCapacity_real_T(sp, b_l, i, &nb_emlrtRTEI);
  loop_ub = rc->size[1];
  emxFree_real_T(&b_r1);
  for (i = 0; i < loop_ub; i++) {
    b_l->data[i] = rc->data[i];
  }

  b_startPoints[0] = 1.0;
  b_startPoints[1] = samplePoints->size[1];
  st.site = &w_emlrtRSI;
  repmat(&st, b_l, b_startPoints, r1);
  st.site = &w_emlrtRSI;
  c_power(&st, r1, y);
  st.site = &w_emlrtRSI;
  c_power(&st, h, r1);
  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])y->size, *(int32_T (*)[2])r1->size,
    &u_emlrtECI, sp);
  i = b_l->size[0];
  b_l->size[0] = Gamma->size[1];
  emxEnsureCapacity_real_T(sp, b_l, i, &ob_emlrtRTEI);
  loop_ub = Gamma->size[1];
  for (i = 0; i < loop_ub; i++) {
    b_l->data[i] = Gamma->data[i];
  }

  emxInit_real_T(sp, &AvMatrix, 2, &ec_emlrtRTEI, true);
  b_startPoints[0] = 1.0;
  b_startPoints[1] = samplePoints->size[1];
  st.site = &w_emlrtRSI;
  repmat(&st, b_l, b_startPoints, AvMatrix);
  loop_ub = AvMatrix->size[0] * AvMatrix->size[1];
  emxFree_real_T(&b_l);
  for (i = 0; i < loop_ub; i++) {
    AvMatrix->data[i] /= 12.566370614359172;
  }

  st.site = &w_emlrtRSI;
  loop_ub = y->size[0] * y->size[1];
  for (i = 0; i < loop_ub; i++) {
    y->data[i] += r1->data[i];
  }

  emxFree_real_T(&r1);
  if ((h->size[0] != y->size[0]) || (h->size[1] != y->size[1])) {
    emlrtErrorWithMessageIdR2018a(&st, &emlrtRTEI, "MATLAB:dimagree",
      "MATLAB:dimagree", 0);
  }

  loop_ub = h->size[0] * h->size[1];
  i = y->size[0] * y->size[1];
  y->size[0] = h->size[0];
  y->size[1] = h->size[1];
  emxEnsureCapacity_real_T(&st, y, i, &pb_emlrtRTEI);
  for (i = 0; i < loop_ub; i++) {
    y->data[i] = h->data[i] / y->data[i];
  }

  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])AvMatrix->size, *(int32_T (*)[2])
    y->size, &v_emlrtECI, sp);
  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])c1->size, *(int32_T (*)[2])c2->size,
    &w_emlrtECI, sp);
  loop_ub = AvMatrix->size[0] * AvMatrix->size[1];
  for (i = 0; i < loop_ub; i++) {
    AvMatrix->data[i] *= y->data[i];
  }

  emxFree_real_T(&y);
  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])AvMatrix->size, *(int32_T (*)[2])
    c1->size, &v_emlrtECI, sp);
  st.site = &w_emlrtRSI;
  loop_ub = AvMatrix->size[0] * AvMatrix->size[1];
  for (i = 0; i < loop_ub; i++) {
    AvMatrix->data[i] *= c1->data[i] - c2->data[i];
  }

  emxFree_real_T(&c2);
  emxFree_real_T(&c1);
  if ((AvMatrix->size[0] != l12mag->size[0]) || (AvMatrix->size[1] !=
       l12mag->size[1])) {
    emlrtErrorWithMessageIdR2018a(&st, &emlrtRTEI, "MATLAB:dimagree",
      "MATLAB:dimagree", 0);
  }

  loop_ub = AvMatrix->size[0] * AvMatrix->size[1];
  for (i = 0; i < loop_ub; i++) {
    AvMatrix->data[i] /= l12mag->data[i];
  }

  /*  catch */
  /*      keyboard */
  /*  end */
  /*  Sanitize for samplepoints close to filaments */
  i = r3->size[0] * r3->size[1];
  r3->size[0] = h->size[0];
  r3->size[1] = h->size[1];
  emxEnsureCapacity_boolean_T(sp, r3, i, &qb_emlrtRTEI);
  loop_ub = h->size[0] * h->size[1];
  for (i = 0; i < loop_ub; i++) {
    r3->data[i] = (h->data[i] == 0.0);
  }

  emxFree_real_T(&h);
  emxInit_boolean_T(sp, &r8, 2, &gb_emlrtRTEI, true);
  i = r8->size[0] * r8->size[1];
  r8->size[0] = r1mag->size[0];
  r8->size[1] = r1mag->size[1];
  emxEnsureCapacity_boolean_T(sp, r8, i, &rb_emlrtRTEI);
  loop_ub = r1mag->size[0] * r1mag->size[1];
  for (i = 0; i < loop_ub; i++) {
    r8->data[i] = (r1mag->data[i] == 0.0);
  }

  emxFree_real_T(&r1mag);
  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])r3->size, *(int32_T (*)[2])r8->size,
    &x_emlrtECI, sp);
  loop_ub = r3->size[0] * r3->size[1];
  for (i = 0; i < loop_ub; i++) {
    r3->data[i] = (r3->data[i] || r8->data[i]);
  }

  i = r8->size[0] * r8->size[1];
  r8->size[0] = r2mag->size[0];
  r8->size[1] = r2mag->size[1];
  emxEnsureCapacity_boolean_T(sp, r8, i, &sb_emlrtRTEI);
  loop_ub = r2mag->size[0] * r2mag->size[1];
  for (i = 0; i < loop_ub; i++) {
    r8->data[i] = (r2mag->data[i] == 0.0);
  }

  emxFree_real_T(&r2mag);
  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])r3->size, *(int32_T (*)[2])r8->size,
    &x_emlrtECI, sp);
  loop_ub = r3->size[0] * r3->size[1];
  for (i = 0; i < loop_ub; i++) {
    r3->data[i] = (r3->data[i] || r8->data[i]);
  }

  i = r8->size[0] * r8->size[1];
  r8->size[0] = l12mag->size[0];
  r8->size[1] = l12mag->size[1];
  emxEnsureCapacity_boolean_T(sp, r8, i, &tb_emlrtRTEI);
  loop_ub = l12mag->size[0] * l12mag->size[1];
  for (i = 0; i < loop_ub; i++) {
    r8->data[i] = (l12mag->data[i] == 0.0);
  }

  emxFree_real_T(&l12mag);
  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[2])r3->size, *(int32_T (*)[2])r8->size,
    &x_emlrtECI, sp);
  b_loop_ub = r3->size[0] * r3->size[1] - 1;
  trueCount = 0;
  for (loop_ub = 0; loop_ub <= b_loop_ub; loop_ub++) {
    if (r3->data[loop_ub] || r8->data[loop_ub]) {
      trueCount++;
    }
  }

  emxInit_int32_T(sp, &r9, 1, &qb_emlrtRTEI, true);
  i = r9->size[0];
  r9->size[0] = trueCount;
  emxEnsureCapacity_int32_T(sp, r9, i, &gb_emlrtRTEI);
  trueCount = 0;
  for (loop_ub = 0; loop_ub <= b_loop_ub; loop_ub++) {
    if (r3->data[loop_ub] || r8->data[loop_ub]) {
      r9->data[trueCount] = loop_ub + 1;
      trueCount++;
    }
  }

  emxFree_boolean_T(&r3);
  emxFree_boolean_T(&r8);
  loop_ub = r9->size[0] - 1;
  trueCount = AvMatrix->size[0] * AvMatrix->size[1];
  for (i = 0; i <= loop_ub; i++) {
    if ((r9->data[i] < 1) || (r9->data[i] > trueCount)) {
      emlrtDynamicBoundsCheckR2012b(r9->data[i], 1, trueCount, &e_emlrtBCI, sp);
    }

    AvMatrix->data[r9->data[i] - 1] = 0.0;
  }

  emxFree_int32_T(&r9);
  st.site = &x_emlrtRSI;
  c_repmat(&st, AvMatrix, b_r2);
  emlrtSizeEqCheckNDR2012b(*(int32_T (*)[3])r2->size, *(int32_T (*)[3])
    b_r2->size, &y_emlrtECI, sp);
  i = l12->size[0] * l12->size[1] * l12->size[2];
  l12->size[0] = r2->size[0];
  l12->size[1] = r2->size[1];
  l12->size[2] = 3;
  emxEnsureCapacity_real_T(sp, l12, i, &ub_emlrtRTEI);
  loop_ub = r2->size[0] * r2->size[1] * r2->size[2];
  emxFree_real_T(&AvMatrix);
  for (i = 0; i < loop_ub; i++) {
    l12->data[i] = r2->data[i] * b_r2->data[i];
  }

  emxFree_real_T(&b_r2);
  emxFree_real_T(&r2);
  emxInit_real_T(sp, &V_temp, 3, &fc_emlrtRTEI, true);
  st.site = &x_emlrtRSI;
  c_sum(&st, l12, V_temp);
  st.site = &y_emlrtRSI;
  b_st.site = &yb_emlrtRSI;
  loop_ub = V_temp->size[1];
  b_loop_ub = V_temp->size[1];
  trueCount = V_temp->size[1];
  i = V->size[0] * V->size[1];
  V->size[0] = 3;
  V->size[1] = V_temp->size[1];
  emxEnsureCapacity_real_T(&b_st, V, i, &vb_emlrtRTEI);
  emxFree_real_T(&l12);
  for (i = 0; i < loop_ub; i++) {
    V->data[3 * i] = V_temp->data[i];
  }

  for (i = 0; i < b_loop_ub; i++) {
    V->data[3 * i + 1] = V_temp->data[i + V_temp->size[1]];
  }

  for (i = 0; i < trueCount; i++) {
    V->data[3 * i + 2] = V_temp->data[i + V_temp->size[1] * 2];
  }

  emxFree_real_T(&V_temp);

  /*  if any(imag(V),'all') || any(isnan(V),'all') || any(isinf(V),'all')  */
  /*      keyboard */
  /*  end */
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (batchBiotSavart.c) */
