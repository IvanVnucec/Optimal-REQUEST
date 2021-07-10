#include "minunit.h"

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
