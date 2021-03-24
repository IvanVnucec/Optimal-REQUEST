/**
 * @file test_request.c
 * @author Ivan Vnucec
 * @brief XYZ function test file
 * @date 2021-03-20
 * 
 * @copyright WTFPL – Do What the Fuck You Want to Public License. See LICENSE.md file for more information.
 * 
 */

#include "minunit.h"
#include "request.h"
#include "matrix_math.h"

void test_setup(void) {
}

void test_teardown(void) {
}

MU_TEST(test_test) {

    mu_check(1 == 1);
}

MU_TEST_SUITE(test_suite) {
    MU_RUN_TEST(test_test);
}

int main(int argc, char *argv[]) {

	(void)argc;
	(void)argv;
	
	MU_RUN_SUITE(test_suite);
	MU_REPORT();
    
	return MU_EXIT_CODE;
}
