[![CI](https://github.com/IvanVnucec/Optimal-REQUEST/actions/workflows/main.yml/badge.svg)](https://github.com/IvanVnucec/Optimal-REQUEST/actions/workflows/main.yml)
[![docs](https://img.shields.io/docsrs/regex?color=blue)](https://ivanvnucec.github.io/Optimal-REQUEST/)
[![Test Matlab](https://github.com/IvanVnucec/Optimal-REQUEST/actions/workflows/test_matlab.yml/badge.svg)](https://github.com/IvanVnucec/Optimal-REQUEST/actions/workflows/test_matlab.yml)

## About The Project
* Least-squares estimation of the attitude quaternion using vector measurements,  
* Recursive,  
* Suitable for Embedded systems,  
* Unit tested.  

## Built With
Project is built using [Meson](https://mesonbuild.com/) build system.

## Getting Started
1. Install dependancies `sudo ./scripts/install_deps.sh`
2. Build project `make build`
3. Run example `make run`

## Installation
TODO

## Usage
TODO

## Testing
TODO

## Matlab
The Optimal-REQUEST algorithm was firstly implemented in MATLAB. The implementation is located in the `matlab` directory.  
Below are descriptions of every file in the `matlab` directory:

- `qib2Rib.m`
Function used to convert the quaternion into a Rotational matrix.

- `qib2Euler.m`
Function used to convert the quaternion into Euler angles.

- `optimal_request_init.m`
Function that with first measurements r0 and b0 sets the initial K, P and mk values used in the first iteration of the Optimal-REQUEST algorithm. 

- `optimal_request.m`
Function used to calculate one step of Optimal-REQUEST algorithm.

- `main.m`
Script for testing the Optimal-REQUEST algorithm. It generates artificial measurements, runs Optimal-REQUEST algorithm and plots the differences between true and estimated angles.

- `get_quat_from_K.m`
Function returns the eigenvector of the matrix 'K' with the largest eigenvalue. The returned vector is quaternion rotation.

- `generate_measurements.m`
Generate artificial measurements for Optimal-REQUEST algorithm testing. The scripts generates accelerometer, magnetometer and gyroscope true measurement vectors by rotating known reference vectors around some user-defined vector with user-defined angular velocity. In the end, we are adding gaussian noise to those vectors.

- `calculate_R.m`
Function computes the R matrix used in Optimal-REQUEST algorithm.

- `calculate_Q.m`
Function computes the Q matrix used in Optimal-REQUEST algorithm.

- `calculate_dK.m`
Function computes the incremental dK matrix used in Optimal-REQUEST algorithm.

- `angle_diff.m`
Function computes difference between the angles. The result is in the interval [-pi pi).


## Acknowledges
```
Optimal-REQUEST Algorithm for Attitude Determination  
D. Choukroun, I. Y. Bar-Itzhack and Y. Oshman  
Published Online:23 May 2012  
https://doi.org/10.2514/1.10337  
```

## License
[MIT](LICENSE.md)
