/*
 * File: _coder_get_quat_from_K_api.c
 *
 * MATLAB Coder version            : 4.1
 * C/C++ source code generated on  : 10-Jul-2021 11:13:20
 */

/* Include Files */
#include "_coder_get_quat_from_K_api.h"

#include "_coder_get_quat_from_K_mex.h"
#include "tmwtypes.h"

/* Variable Definitions */
emlrtCTX emlrtRootTLSGlobal     = NULL;
emlrtContext emlrtContextGlobal = {
    true,                                                 /* bFirstTime */
    false,                                                /* bInitialized */
    131467U,                                              /* fVersionInfo */
    NULL,                                                 /* fErrorFunction */
    "get_quat_from_K",                                    /* fFunctionName */
    NULL,                                                 /* fRTCallStack */
    false,                                                /* bDebugMode */
    {2045744189U, 2170104910U, 2743257031U, 4284093946U}, /* fSigWrd */
    NULL                                                  /* fSigMem */
};

/* Function Declarations */
static void b_emlrt_marshallIn(const emlrtStack *sp,
                               const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y[16]);
static const mxArray *b_emlrt_marshallOut(const struct0_T *u);
static void c_emlrt_marshallIn(const emlrtStack *sp,
                               const mxArray *s,
                               const char_T *identifier,
                               struct0_T *y);
static const mxArray *c_emlrt_marshallOut(const real32_T u[6]);
static void d_emlrt_marshallIn(const emlrtStack *sp,
                               const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               struct0_T *y);
static const mxArray *d_emlrt_marshallOut(const real32_T u[16]);
static void e_emlrt_marshallIn(const emlrtStack *sp,
                               const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y[3]);
static void emlrt_marshallIn(const emlrtStack *sp,
                             const mxArray *K,
                             const char_T *identifier,
                             real32_T y[16]);
static const mxArray *emlrt_marshallOut(const real32_T u[4]);
static void f_emlrt_marshallIn(const emlrtStack *sp,
                               const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y[6]);
static real32_T g_emlrt_marshallIn(const emlrtStack *sp,
                                   const mxArray *u,
                                   const emlrtMsgIdentifier *parentId);
static void h_emlrt_marshallIn(const emlrtStack *sp,
                               const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T ret[16]);
static void i_emlrt_marshallIn(const emlrtStack *sp,
                               const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T ret[3]);
static void j_emlrt_marshallIn(const emlrtStack *sp,
                               const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T ret[6]);
static real32_T k_emlrt_marshallIn(const emlrtStack *sp,
                                   const mxArray *src,
                                   const emlrtMsgIdentifier *msgId);

/* Function Definitions */

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                real32_T y[16]
 * Return Type  : void
 */
static void b_emlrt_marshallIn(const emlrtStack *sp,
                               const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y[16])
{
    h_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
    emlrtDestroyArray(&u);
}

/*
 * Arguments    : const struct0_T *u
 * Return Type  : const mxArray *
 */
static const mxArray *b_emlrt_marshallOut(const struct0_T *u)
{
    const mxArray *y;
    static const char *sv0[10] =
        {"w", "r", "b", "Mu_noise_var", "Eta_noise_var", "dT", "K", "P", "mk", "Rho"};

    const mxArray *b_y;
    const mxArray *m1;
    static const int32_T iv1[1] = {3};

    real32_T *pData;
    y = NULL;
    emlrtAssign(&y, emlrtCreateStructMatrix(1, 1, 10, sv0));
    b_y      = NULL;
    m1       = emlrtCreateNumericArray(1, iv1, mxSINGLE_CLASS, mxREAL);
    pData    = (real32_T *)emlrtMxGetData(m1);
    pData[0] = u->w[0];
    pData[1] = u->w[1];
    pData[2] = u->w[2];
    emlrtAssign(&b_y, m1);
    emlrtSetFieldR2017b(y, 0, "w", b_y, 0);
    emlrtSetFieldR2017b(y, 0, "r", c_emlrt_marshallOut(u->r), 1);
    emlrtSetFieldR2017b(y, 0, "b", c_emlrt_marshallOut(u->b), 2);
    b_y = NULL;
    m1  = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
    *(real32_T *)emlrtMxGetData(m1) = u->Mu_noise_var;
    emlrtAssign(&b_y, m1);
    emlrtSetFieldR2017b(y, 0, "Mu_noise_var", b_y, 3);
    b_y = NULL;
    m1  = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
    *(real32_T *)emlrtMxGetData(m1) = u->Eta_noise_var;
    emlrtAssign(&b_y, m1);
    emlrtSetFieldR2017b(y, 0, "Eta_noise_var", b_y, 4);
    b_y = NULL;
    m1  = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
    *(real32_T *)emlrtMxGetData(m1) = u->dT;
    emlrtAssign(&b_y, m1);
    emlrtSetFieldR2017b(y, 0, "dT", b_y, 5);
    emlrtSetFieldR2017b(y, 0, "K", d_emlrt_marshallOut(u->K), 6);
    emlrtSetFieldR2017b(y, 0, "P", d_emlrt_marshallOut(u->P), 7);
    b_y = NULL;
    m1  = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
    *(real32_T *)emlrtMxGetData(m1) = u->mk;
    emlrtAssign(&b_y, m1);
    emlrtSetFieldR2017b(y, 0, "mk", b_y, 8);
    b_y = NULL;
    m1  = emlrtCreateNumericMatrix(1, 1, mxSINGLE_CLASS, mxREAL);
    *(real32_T *)emlrtMxGetData(m1) = u->Rho;
    emlrtAssign(&b_y, m1);
    emlrtSetFieldR2017b(y, 0, "Rho", b_y, 9);
    return y;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *s
 *                const char_T *identifier
 *                struct0_T *y
 * Return Type  : void
 */
static void c_emlrt_marshallIn(const emlrtStack *sp,
                               const mxArray *s,
                               const char_T *identifier,
                               struct0_T *y)
{
    emlrtMsgIdentifier thisId;
    thisId.fIdentifier   = (const char *)identifier;
    thisId.fParent       = NULL;
    thisId.bParentIsCell = false;
    d_emlrt_marshallIn(sp, emlrtAlias(s), &thisId, y);
    emlrtDestroyArray(&s);
}

/*
 * Arguments    : const real32_T u[6]
 * Return Type  : const mxArray *
 */
static const mxArray *c_emlrt_marshallOut(const real32_T u[6])
{
    const mxArray *y;
    const mxArray *m2;
    static const int32_T iv2[2] = {3, 2};

    real32_T *pData;
    int32_T i0;
    int32_T i;
    y     = NULL;
    m2    = emlrtCreateNumericArray(2, iv2, mxSINGLE_CLASS, mxREAL);
    pData = (real32_T *)emlrtMxGetData(m2);
    i0    = 0;
    for (i = 0; i < 2; i++) {
        pData[i0] = u[3 * i];
        i0++;
        pData[i0] = u[1 + 3 * i];
        i0++;
        pData[i0] = u[2 + 3 * i];
        i0++;
    }

    emlrtAssign(&y, m2);
    return y;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                struct0_T *y
 * Return Type  : void
 */
static void d_emlrt_marshallIn(const emlrtStack *sp,
                               const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               struct0_T *y)
{
    emlrtMsgIdentifier thisId;
    static const char *fieldNames[10] =
        {"w", "r", "b", "Mu_noise_var", "Eta_noise_var", "dT", "K", "P", "mk", "Rho"};

    static const int32_T dims = 0;
    thisId.fParent            = parentId;
    thisId.bParentIsCell      = false;
    emlrtCheckStructR2012b(sp, parentId, u, 10, fieldNames, 0U, &dims);
    thisId.fIdentifier = "w";
    e_emlrt_marshallIn(sp,
                       emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 0, "w")),
                       &thisId,
                       y->w);
    thisId.fIdentifier = "r";
    f_emlrt_marshallIn(sp,
                       emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 1, "r")),
                       &thisId,
                       y->r);
    thisId.fIdentifier = "b";
    f_emlrt_marshallIn(sp,
                       emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 2, "b")),
                       &thisId,
                       y->b);
    thisId.fIdentifier = "Mu_noise_var";
    y->Mu_noise_var =
        g_emlrt_marshallIn(sp,
                           emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 3, "Mu_noise_var")),
                           &thisId);
    thisId.fIdentifier = "Eta_noise_var";
    y->Eta_noise_var =
        g_emlrt_marshallIn(sp,
                           emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 4, "Eta_noise_var")),
                           &thisId);
    thisId.fIdentifier = "dT";
    y->dT              = g_emlrt_marshallIn(sp,
                               emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 5, "dT")),
                               &thisId);
    thisId.fIdentifier = "K";
    b_emlrt_marshallIn(sp,
                       emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 6, "K")),
                       &thisId,
                       y->K);
    thisId.fIdentifier = "P";
    b_emlrt_marshallIn(sp,
                       emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 7, "P")),
                       &thisId,
                       y->P);
    thisId.fIdentifier = "mk";
    y->mk              = g_emlrt_marshallIn(sp,
                               emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 8, "mk")),
                               &thisId);
    thisId.fIdentifier = "Rho";
    y->Rho             = g_emlrt_marshallIn(sp,
                                emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 9, "Rho")),
                                &thisId);
    emlrtDestroyArray(&u);
}

/*
 * Arguments    : const real32_T u[16]
 * Return Type  : const mxArray *
 */
static const mxArray *d_emlrt_marshallOut(const real32_T u[16])
{
    const mxArray *y;
    const mxArray *m3;
    static const int32_T iv3[2] = {4, 4};

    real32_T *pData;
    int32_T i1;
    int32_T i;
    int32_T i2;
    y     = NULL;
    m3    = emlrtCreateNumericArray(2, iv3, mxSINGLE_CLASS, mxREAL);
    pData = (real32_T *)emlrtMxGetData(m3);
    i1    = 0;
    for (i = 0; i < 4; i++) {
        i2        = i << 2;
        pData[i1] = u[i2];
        i1++;
        pData[i1] = u[1 + i2];
        i1++;
        pData[i1] = u[2 + i2];
        i1++;
        pData[i1] = u[3 + i2];
        i1++;
    }

    emlrtAssign(&y, m3);
    return y;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                real32_T y[3]
 * Return Type  : void
 */
static void e_emlrt_marshallIn(const emlrtStack *sp,
                               const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y[3])
{
    i_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
    emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *K
 *                const char_T *identifier
 *                real32_T y[16]
 * Return Type  : void
 */
static void emlrt_marshallIn(const emlrtStack *sp,
                             const mxArray *K,
                             const char_T *identifier,
                             real32_T y[16])
{
    emlrtMsgIdentifier thisId;
    thisId.fIdentifier   = (const char *)identifier;
    thisId.fParent       = NULL;
    thisId.bParentIsCell = false;
    b_emlrt_marshallIn(sp, emlrtAlias(K), &thisId, y);
    emlrtDestroyArray(&K);
}

/*
 * Arguments    : const real32_T u[4]
 * Return Type  : const mxArray *
 */
static const mxArray *emlrt_marshallOut(const real32_T u[4])
{
    const mxArray *y;
    const mxArray *m0;
    static const int32_T iv0[1] = {4};

    real32_T *pData;
    y        = NULL;
    m0       = emlrtCreateNumericArray(1, iv0, mxSINGLE_CLASS, mxREAL);
    pData    = (real32_T *)emlrtMxGetData(m0);
    pData[0] = u[0];
    pData[1] = u[1];
    pData[2] = u[2];
    pData[3] = u[3];
    emlrtAssign(&y, m0);
    return y;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                real32_T y[6]
 * Return Type  : void
 */
static void f_emlrt_marshallIn(const emlrtStack *sp,
                               const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y[6])
{
    j_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
    emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 * Return Type  : real32_T
 */
static real32_T g_emlrt_marshallIn(const emlrtStack *sp,
                                   const mxArray *u,
                                   const emlrtMsgIdentifier *parentId)
{
    real32_T y;
    y = k_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
    emlrtDestroyArray(&u);
    return y;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                real32_T ret[16]
 * Return Type  : void
 */
static void h_emlrt_marshallIn(const emlrtStack *sp,
                               const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T ret[16])
{
    static const int32_T dims[2] = {4, 4};

    emlrtCheckBuiltInR2012b(sp, msgId, src, "single|double", false, 2U, dims);
    emlrtImportArrayR2015b(sp, src, ret, 4, false);
    emlrtDestroyArray(&src);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                real32_T ret[3]
 * Return Type  : void
 */
static void i_emlrt_marshallIn(const emlrtStack *sp,
                               const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T ret[3])
{
    static const int32_T dims[1] = {3};

    emlrtCheckBuiltInR2012b(sp, msgId, src, "single|double", false, 1U, dims);
    emlrtImportArrayR2015b(sp, src, ret, 4, false);
    emlrtDestroyArray(&src);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                real32_T ret[6]
 * Return Type  : void
 */
static void j_emlrt_marshallIn(const emlrtStack *sp,
                               const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T ret[6])
{
    static const int32_T dims[2] = {3, 2};

    emlrtCheckBuiltInR2012b(sp, msgId, src, "single|double", false, 2U, dims);
    emlrtImportArrayR2015b(sp, src, ret, 4, false);
    emlrtDestroyArray(&src);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 * Return Type  : real32_T
 */
static real32_T k_emlrt_marshallIn(const emlrtStack *sp,
                                   const mxArray *src,
                                   const emlrtMsgIdentifier *msgId)
{
    real32_T ret;
    static const int32_T dims = 0;
    emlrtCheckBuiltInR2012b(sp, msgId, src, "single|double", false, 0U, &dims);
    emlrtImportArrayR2015b(sp, src, &ret, 4, false);
    emlrtDestroyArray(&src);
    return ret;
}

/*
 * Arguments    : const mxArray * const prhs[1]
 *                int32_T nlhs
 *                const mxArray *plhs[1]
 * Return Type  : void
 */
void get_quat_from_K_api(const mxArray *const prhs[1],
                         int32_T nlhs,
                         const mxArray *plhs[1])
{
    real32_T K[16];
    real32_T q[4];
    emlrtStack st = {
        NULL, /* site */
        NULL, /* tls */
        NULL  /* prev */
    };

    (void)nlhs;
    st.tls = emlrtRootTLSGlobal;

    /* Marshall function inputs */
    emlrt_marshallIn(&st, emlrtAliasP(prhs[0]), "K", K);

    /* Invoke the target function */
    get_quat_from_K(K, q);

    /* Marshall function outputs */
    plhs[0] = emlrt_marshallOut(q);
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void get_quat_from_K_atexit(void)
{
    emlrtStack st = {
        NULL, /* site */
        NULL, /* tls */
        NULL  /* prev */
    };

    mexFunctionCreateRootTLS();
    st.tls = emlrtRootTLSGlobal;
    emlrtEnterRtStackR2012b(&st);
    emlrtLeaveRtStackR2012b(&st);
    emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
    get_quat_from_K_xil_terminate();
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void get_quat_from_K_initialize(void)
{
    emlrtStack st = {
        NULL, /* site */
        NULL, /* tls */
        NULL  /* prev */
    };

    mexFunctionCreateRootTLS();
    st.tls = emlrtRootTLSGlobal;
    emlrtClearAllocCountR2012b(&st, false, 0U, 0);
    emlrtEnterRtStackR2012b(&st);
    emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void get_quat_from_K_terminate(void)
{
    emlrtStack st = {
        NULL, /* site */
        NULL, /* tls */
        NULL  /* prev */
    };

    st.tls = emlrtRootTLSGlobal;
    emlrtLeaveRtStackR2012b(&st);
    emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/*
 * Arguments    : const mxArray * const prhs[1]
 *                int32_T nlhs
 *                const mxArray *plhs[1]
 * Return Type  : void
 */
void optimal_request_api(const mxArray *const prhs[1],
                         int32_T nlhs,
                         const mxArray *plhs[1])
{
    struct0_T s;
    emlrtStack st = {
        NULL, /* site */
        NULL, /* tls */
        NULL  /* prev */
    };

    (void)nlhs;
    st.tls = emlrtRootTLSGlobal;

    /* Marshall function inputs */
    c_emlrt_marshallIn(&st, emlrtAliasP(prhs[0]), "s", &s);

    /* Invoke the target function */
    optimal_request(&s);

    /* Marshall function outputs */
    plhs[0] = b_emlrt_marshallOut(&s);
}

/*
 * Arguments    : const mxArray * const prhs[1]
 *                int32_T nlhs
 *                const mxArray *plhs[1]
 * Return Type  : void
 */
void optimal_request_init_api(const mxArray *const prhs[1],
                              int32_T nlhs,
                              const mxArray *plhs[1])
{
    struct0_T s;
    emlrtStack st = {
        NULL, /* site */
        NULL, /* tls */
        NULL  /* prev */
    };

    (void)nlhs;
    st.tls = emlrtRootTLSGlobal;

    /* Marshall function inputs */
    c_emlrt_marshallIn(&st, emlrtAliasP(prhs[0]), "s", &s);

    /* Invoke the target function */
    optimal_request_init(&s);

    /* Marshall function outputs */
    plhs[0] = b_emlrt_marshallOut(&s);
}

/*
 * File trailer for _coder_get_quat_from_K_api.c
 *
 * [EOF]
 */
