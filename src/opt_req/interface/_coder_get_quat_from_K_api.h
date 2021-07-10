/*
 * File: _coder_get_quat_from_K_api.h
 *
 * MATLAB Coder version            : 4.1
 * C/C++ source code generated on  : 10-Jul-2021 11:13:20
 */

#ifndef _CODER_GET_QUAT_FROM_K_API_H
    #define _CODER_GET_QUAT_FROM_K_API_H

    /* Include Files */
    #include "_coder_get_quat_from_K_api.h"
    #include "emlrt.h"
    #include "mex.h"
    #include "tmwtypes.h"

    #include <stddef.h>
    #include <stdlib.h>

    /* Type Definitions */
    #ifndef typedef_struct0_T
        #define typedef_struct0_T

typedef struct {
    real32_T w[3];
    real32_T r[6];
    real32_T b[6];
    real32_T Mu_noise_var;
    real32_T Eta_noise_var;
    real32_T dT;
    real32_T K[16];
    real32_T P[16];
    real32_T mk;
    real32_T Rho;
} struct0_T;

    #endif /*typedef_struct0_T*/

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
extern void get_quat_from_K(real32_T K[16], real32_T q[4]);
extern void get_quat_from_K_api(const mxArray *const prhs[1],
                                int32_T nlhs,
                                const mxArray *plhs[1]);
extern void get_quat_from_K_atexit(void);
extern void get_quat_from_K_initialize(void);
extern void get_quat_from_K_terminate(void);
extern void get_quat_from_K_xil_terminate(void);
extern void optimal_request(struct0_T *s);
extern void optimal_request_api(const mxArray *const prhs[1],
                                int32_T nlhs,
                                const mxArray *plhs[1]);
extern void optimal_request_init(struct0_T *s);
extern void optimal_request_init_api(const mxArray *const prhs[1],
                                     int32_T nlhs,
                                     const mxArray *plhs[1]);

#endif

/*
 * File trailer for _coder_get_quat_from_K_api.h
 *
 * [EOF]
 */
