/*
 * File: _coder_get_quat_from_K_mex.c
 *
 * MATLAB Coder version            : 4.1
 * C/C++ source code generated on  : 10-Jul-2021 11:13:20
 */

/* Include Files */
#include "_coder_get_quat_from_K_mex.h"

#include "_coder_get_quat_from_K_api.h"

/* Variable Definitions */
static const char *emlrtEntryPoints[3] = {"get_quat_from_K",
                                          "optimal_request",
                                          "optimal_request_init"};

/* Function Declarations */
static void c_optimal_request_init_mexFunct(int32_T nlhs,
                                            mxArray *plhs[1],
                                            int32_T nrhs,
                                            const mxArray *prhs[1]);
static void get_quat_from_K_mexFunction(int32_T nlhs,
                                        mxArray *plhs[1],
                                        int32_T nrhs,
                                        const mxArray *prhs[1]);
static void optimal_request_mexFunction(int32_T nlhs,
                                        mxArray *plhs[1],
                                        int32_T nrhs,
                                        const mxArray *prhs[1]);

/* Function Definitions */

/*
 * Arguments    : int32_T nlhs
 *                mxArray *plhs[1]
 *                int32_T nrhs
 *                const mxArray *prhs[1]
 * Return Type  : void
 */
static void c_optimal_request_init_mexFunct(int32_T nlhs,
                                            mxArray *plhs[1],
                                            int32_T nrhs,
                                            const mxArray *prhs[1])
{
    const mxArray *outputs[1];
    emlrtStack st = {
        NULL, /* site */
        NULL, /* tls */
        NULL  /* prev */
    };

    st.tls = emlrtRootTLSGlobal;

    /* Check for proper number of arguments. */
    if (nrhs != 1) {
        emlrtErrMsgIdAndTxt(&st,
                            "EMLRT:runTime:WrongNumberOfInputs",
                            5,
                            12,
                            1,
                            4,
                            20,
                            "optimal_request_init");
    }

    if (nlhs > 1) {
        emlrtErrMsgIdAndTxt(&st,
                            "EMLRT:runTime:TooManyOutputArguments",
                            3,
                            4,
                            20,
                            "optimal_request_init");
    }

    /* Call the function. */
    optimal_request_init_api(prhs, nlhs, outputs);

    /* Copy over outputs to the caller. */
    emlrtReturnArrays(1, plhs, outputs);
}

/*
 * Arguments    : int32_T nlhs
 *                mxArray *plhs[1]
 *                int32_T nrhs
 *                const mxArray *prhs[1]
 * Return Type  : void
 */
static void get_quat_from_K_mexFunction(int32_T nlhs,
                                        mxArray *plhs[1],
                                        int32_T nrhs,
                                        const mxArray *prhs[1])
{
    const mxArray *outputs[1];
    emlrtStack st = {
        NULL, /* site */
        NULL, /* tls */
        NULL  /* prev */
    };

    st.tls = emlrtRootTLSGlobal;

    /* Check for proper number of arguments. */
    if (nrhs != 1) {
        emlrtErrMsgIdAndTxt(&st,
                            "EMLRT:runTime:WrongNumberOfInputs",
                            5,
                            12,
                            1,
                            4,
                            15,
                            "get_quat_from_K");
    }

    if (nlhs > 1) {
        emlrtErrMsgIdAndTxt(&st,
                            "EMLRT:runTime:TooManyOutputArguments",
                            3,
                            4,
                            15,
                            "get_quat_from_K");
    }

    /* Call the function. */
    get_quat_from_K_api(prhs, nlhs, outputs);

    /* Copy over outputs to the caller. */
    emlrtReturnArrays(1, plhs, outputs);
}

/*
 * Arguments    : int32_T nlhs
 *                mxArray *plhs[1]
 *                int32_T nrhs
 *                const mxArray *prhs[1]
 * Return Type  : void
 */
static void optimal_request_mexFunction(int32_T nlhs,
                                        mxArray *plhs[1],
                                        int32_T nrhs,
                                        const mxArray *prhs[1])
{
    const mxArray *outputs[1];
    emlrtStack st = {
        NULL, /* site */
        NULL, /* tls */
        NULL  /* prev */
    };

    st.tls = emlrtRootTLSGlobal;

    /* Check for proper number of arguments. */
    if (nrhs != 1) {
        emlrtErrMsgIdAndTxt(&st,
                            "EMLRT:runTime:WrongNumberOfInputs",
                            5,
                            12,
                            1,
                            4,
                            15,
                            "optimal_request");
    }

    if (nlhs > 1) {
        emlrtErrMsgIdAndTxt(&st,
                            "EMLRT:runTime:TooManyOutputArguments",
                            3,
                            4,
                            15,
                            "optimal_request");
    }

    /* Call the function. */
    optimal_request_api(prhs, nlhs, outputs);

    /* Copy over outputs to the caller. */
    emlrtReturnArrays(1, plhs, outputs);
}

/*
 * Arguments    : int32_T nlhs
 *                mxArray * const plhs[]
 *                int32_T nrhs
 *                const mxArray * const prhs[]
 * Return Type  : void
 */
void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray *prhs[])
{
    emlrtStack st = {
        NULL, /* site */
        NULL, /* tls */
        NULL  /* prev */
    };

    mexAtExit(get_quat_from_K_atexit);

    /* Module initialization. */
    get_quat_from_K_initialize();
    st.tls = emlrtRootTLSGlobal;

    /* Dispatch the entry-point. */
    switch (emlrtGetEntryPointIndexR2016a(&st, nrhs, prhs, emlrtEntryPoints, 3)) {
        case 0:
            get_quat_from_K_mexFunction(nlhs,
                                        plhs,
                                        nrhs - 1,
                                        *(const mxArray *(*)[1]) & prhs[1]);
            break;

        case 1:
            optimal_request_mexFunction(nlhs,
                                        plhs,
                                        nrhs - 1,
                                        *(const mxArray *(*)[1]) & prhs[1]);
            break;

        case 2:
            c_optimal_request_init_mexFunct(nlhs,
                                            plhs,
                                            nrhs - 1,
                                            *(const mxArray *(*)[1]) & prhs[1]);
            break;
    }

    /* Module termination. */
    get_quat_from_K_terminate();
}

/*
 * Arguments    : void
 * Return Type  : emlrtCTX
 */
emlrtCTX mexFunctionCreateRootTLS(void)
{
    emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
    return emlrtRootTLSGlobal;
}

/*
 * File trailer for _coder_get_quat_from_K_mex.c
 *
 * [EOF]
 */
