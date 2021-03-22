#include <stddef.h>
#include <stdio.h>

#include "matrix_math.h"
#include "request.h"

/**
 * @brief Print "Hello world!" string.
 * 
 * @return int 0
 */
int main(void)
{
    printf(HELLO_WORLD_STRING);

    MTX_Matrix_S a = {
        .rows = 3,
        .cols = 2,
        .data = NULL
    };

    return 0;
}
