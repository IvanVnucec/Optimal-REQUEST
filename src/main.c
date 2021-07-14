#include "main.h"

#include "get_quat_from_K.h"
#include "get_quat_from_K_initialize.h"
#include "get_quat_from_K_terminate.h"
#include "optimal_request.h"
#include "optimal_request_init.h"

#include <stdio.h>

#define MEAS_DATA_LEN 10

// clang-format off

// m/s^2
float ref_acc[MEAS_DATA_LEN][3] = {
    {-0.0518488f, -0.0495620f, -0.9974243f},
    {-0.0518488f, -0.0495620f, -0.9974243f},
    {-0.0518488f, -0.0495620f, -0.9974243f},
    {-0.0518488f, -0.0495620f, -0.9974243f},
    {-0.0518488f, -0.0495620f, -0.9974243f},
    {-0.0518488f, -0.0495620f, -0.9974243f},
    {-0.0518488f, -0.0495620f, -0.9974243f},
    {-0.0518488f, -0.0495620f, -0.9974243f},
    {-0.0518488f, -0.0495620f, -0.9974243f},
    {-0.0518488f, -0.0495620f, -0.9974243f}
};

// uT
float ref_mag[MEAS_DATA_LEN][3] = {
    {0.8514420f, 0.5186020f, 0.0780922f},
    {0.8514420f, 0.5186020f, 0.0780922f},
    {0.8514420f, 0.5186020f, 0.0780922f},
    {0.8514420f, 0.5186020f, 0.0780922f},
    {0.8514420f, 0.5186020f, 0.0780922f},
    {0.8514420f, 0.5186020f, 0.0780922f},
    {0.8514420f, 0.5186020f, 0.0780922f},
    {0.8514420f, 0.5186020f, 0.0780922f},
    {0.8514420f, 0.5186020f, 0.0780922f},
    {0.8514420f, 0.5186020f, 0.0780922f}
};

// m/s^2
float bdy_acc[MEAS_DATA_LEN][3] = {
    {-0.0499382f, -0.0499465f, -0.9975026f},
    {0.0701378f, 0.0133364f, -0.9974482f},
    {-0.0649361f, 0.0263973f, -0.9975402f},
    {0.0408270f, -0.0591221f, -0.9974155f},
    {-0.0000943f, 0.0739300f, -0.9972634f},
    {-0.0360212f, -0.0617453f, -0.9974417f},
    {0.0632904f, 0.0319716f, -0.9974829f},
    {-0.0697152f, 0.0078434f, -0.9975361f},
    {0.0553128f, -0.0455329f, -0.9974303f},
    {-0.0213633f, 0.0689299f, -0.9973927f},
};

// uT
float bdy_mag[MEAS_DATA_LEN][3] = {
    {0.8586434f, 0.5011600f, 0.1075650f},
    {-0.9945581f, 0.0674259f, 0.0794227f},
    {0.8250760f, -0.5603430f, 0.0725626f},
    {-0.4015002f, 0.9142123f, 0.0548959f},
    {-0.2057217f, -0.9744645f, 0.0899864f},
    {0.6722905f, 0.7350830f, 0.0876269f},
    {-0.9676241f, -0.2360950f, 0.0892341f},
    {0.9378584f, -0.3283825f, 0.1121896f},
    {-0.5882629f, 0.8040481f, 0.0863333f},
    {0.0727781f, -0.9955956f, 0.0590990f}
};

// rad/s
float bdy_gyr[MEAS_DATA_LEN][3] = {
    {0.0001055f, -0.0002394f, 0.9989619f},
    {-0.0004950f, -0.0008095f, 0.9997655f},
    {0.0012313f, -0.0003464f, 0.9997750f},
    {-0.0006960f, -0.0000978f, 0.9995347f},
    {0.0008544f, 0.0000944f, 0.9987742f},
    {0.0002633f, 0.0012149f, 1.0002811f},
    {0.0000908f, -0.0011827f, 1.0000168f},
    {0.0002767f, -0.0002244f, 1.0004414f},
    {0.0001294f, 0.0004387f, 0.9997478f},
    {0.0001225f, 0.0002816f, 0.9999148f},
};
// clang-format on

void or_fill_r(float r[6], float vec1[3], float vec2[3])
{
    r[0] = vec1[0];
    r[1] = vec1[1];
    r[2] = vec1[2];
    r[3] = vec2[0];
    r[4] = vec2[1];
    r[5] = vec2[2];
}

void or_fill_b(float b[6], float vec1[3], float vec2[3])
{
    b[0] = vec1[0];
    b[1] = vec1[1];
    b[2] = vec1[2];
    b[3] = vec2[0];
    b[4] = vec2[1];
    b[5] = vec2[2];
}

void or_fill_w(float w[3], float vec_w[3])
{
    w[0] = vec_w[0];
    w[1] = vec_w[1];
    w[2] = vec_w[2];
}

int main(void)
{
    struct0_T or_handle;
    float q_est[4];

    // these values are not changing
    or_handle.Mu_noise_var  = 0.0008117f;
    or_handle.Eta_noise_var = 0.0000010f;
    or_handle.dT            = 10.0f;

    // for k = 0
    // first measurements
    or_fill_r(or_handle.r, ref_acc[0], ref_mag[0]);
    or_fill_b(or_handle.b, bdy_acc[0], bdy_mag[0]);
    or_fill_w(or_handle.w, bdy_gyr[0]);

    // init optimal_req on 1st meas
    optimal_request_init(&or_handle);

    get_quat_from_K(or_handle.K, q_est);

    // for all other measurements
    for (int i = 1; i < MEAS_DATA_LEN; i++) {
        // fill r and b vectors with measurements
        or_fill_r(or_handle.r, ref_acc[i], ref_mag[i]);
        or_fill_b(or_handle.b, bdy_acc[i], bdy_mag[i]);
        or_fill_w(or_handle.w, bdy_gyr[i]);

        // call optimal req on meas
        optimal_request(&or_handle);

        // get q from K
        get_quat_from_K(or_handle.K, q_est);

        printf("q_estimate[%d] = %5f %10f %10f %10f \n",
               i,
               q_est[0],
               q_est[1],
               q_est[2],
               q_est[3]);
    }

    return 0;
}
