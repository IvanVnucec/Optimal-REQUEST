#include "minunit.h"

#include "get_quat_from_K.h"
#include "get_quat_from_K_initialize.h"
#include "get_quat_from_K_terminate.h"
#include "optimal_request.h"
#include "optimal_request_init.h"

void test_setup(void) {
	get_quat_from_K_initialize();
}

void test_teardown(void) {
	get_quat_from_K_terminate();
}

/* Function Declarations */
static void argInit_3x1_real32_T(float result[3]);
static void argInit_3x2_real32_T(float result[6]);
static void argInit_4x4_real32_T(float result[16]);
static float argInit_real32_T(void);
static void argInit_struct0_T(struct0_T *result);
static void main_get_quat_from_K(void);
static void main_optimal_request(void);
static void main_optimal_request_init(void);

/* Function Definitions */

/*
 * Arguments    : float result[3]
 * Return Type  : void
 */
static void argInit_3x1_real32_T(float result[3])
{
    float result_tmp;

    /* Loop over the array to initialize each element. */
    /* Set the value of the array element.
     Change this value to the value that the application requires. */
    result_tmp = argInit_real32_T();
    result[0]  = result_tmp;

    /* Set the value of the array element.
     Change this value to the value that the application requires. */
    result[1] = result_tmp;

    /* Set the value of the array element.
     Change this value to the value that the application requires. */
    result[2] = argInit_real32_T();
}

/*
 * Arguments    : float result[6]
 * Return Type  : void
 */
static void argInit_3x2_real32_T(float result[6])
{
    int idx0;
    float result_tmp;

    /* Loop over the array to initialize each element. */
    for (idx0 = 0; idx0 < 3; idx0++) {
        /* Set the value of the array element.
       Change this value to the value that the application requires. */
        result_tmp   = argInit_real32_T();
        result[idx0] = result_tmp;

        /* Set the value of the array element.
       Change this value to the value that the application requires. */
        result[idx0 + 3] = result_tmp;
    }
}

/*
 * Arguments    : float result[16]
 * Return Type  : void
 */
static void argInit_4x4_real32_T(float result[16])
{
    int idx0;
    float result_tmp;

    /* Loop over the array to initialize each element. */
    for (idx0 = 0; idx0 < 4; idx0++) {
        /* Set the value of the array element.
       Change this value to the value that the application requires. */
        result_tmp   = argInit_real32_T();
        result[idx0] = result_tmp;

        /* Set the value of the array element.
       Change this value to the value that the application requires. */
        result[idx0 + 4] = result_tmp;

        /* Set the value of the array element.
       Change this value to the value that the application requires. */
        result[idx0 + 8] = argInit_real32_T();

        /* Set the value of the array element.
       Change this value to the value that the application requires. */
        result[idx0 + 12] = argInit_real32_T();
    }
}

/*
 * Arguments    : void
 * Return Type  : float
 */
static float argInit_real32_T(void)
{
    return 0.0F;
}

/*
 * Arguments    : struct0_T *result
 * Return Type  : void
 */
static void argInit_struct0_T(struct0_T *result)
{
    float result_tmp[6];
    int i2;
    float b_result_tmp;
    float c_result_tmp[16];

    /* Set the value of each structure field.
     Change this value to the value that the application requires. */
    argInit_3x1_real32_T(result->w);
    argInit_3x2_real32_T(result_tmp);
    for (i2 = 0; i2 < 6; i2++) {
        result->r[i2] = result_tmp[i2];
        result->b[i2] = result_tmp[i2];
    }

    b_result_tmp          = argInit_real32_T();
    result->Mu_noise_var  = b_result_tmp;
    result->Eta_noise_var = b_result_tmp;
    result->dT            = argInit_real32_T();
    argInit_4x4_real32_T(c_result_tmp);
    memcpy(&result->K[0], &c_result_tmp[0], sizeof(float) << 4);
    memcpy(&result->P[0], &c_result_tmp[0], sizeof(float) << 4);
    result->mk  = argInit_real32_T();
    result->Rho = argInit_real32_T();
}

/*
 * Arguments    : void
 * Return Type  : void
 */
static void main_get_quat_from_K(void)
{
    float fv0[16];
    float q[4];

    /* Initialize function 'get_quat_from_K' input arguments. */
    /* Initialize function input argument 'K'. */
    /* Call the entry-point 'get_quat_from_K'. */
    argInit_4x4_real32_T(fv0);
    get_quat_from_K(fv0, q);
}

/*
 * Arguments    : void
 * Return Type  : void
 */
static void main_optimal_request(void)
{
    struct0_T s;

    /* Initialize function 'optimal_request' input arguments. */
    /* Initialize function input argument 's'. */
    /* Call the entry-point 'optimal_request'. */
    argInit_struct0_T(&s);
    optimal_request(&s);
}

/*
 * Arguments    : void
 * Return Type  : void
 */
static void main_optimal_request_init(void)
{
    struct0_T s;

    /* Initialize function 'optimal_request_init' input arguments. */
    /* Initialize function input argument 's'. */
    /* Call the entry-point 'optimal_request_init'. */
    argInit_struct0_T(&s);
    optimal_request_init(&s);
}

MU_TEST(test_call_OR_functions) {
	main_get_quat_from_K();
    main_optimal_request();
    main_optimal_request_init();

    mu_check(1 == 1);
}

MU_TEST_SUITE(test_suite) {
    MU_RUN_TEST(test_call_OR_functions);
}

int main(int argc, char *argv[]) {

	(void)argc;
	(void)argv;
	
	MU_RUN_SUITE(test_suite);
	MU_REPORT();
    
	return MU_EXIT_CODE;
}
