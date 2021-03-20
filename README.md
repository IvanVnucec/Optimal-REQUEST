[![CI](https://github.com/IvanVnucec/Optimal-REQUEST/actions/workflows/main.yml/badge.svg)](https://github.com/IvanVnucec/Optimal-REQUEST/actions/workflows/main.yml)
[![codecov](https://codecov.io/gh/IvanVnucec/Optimal-REQUEST/branch/master/graph/badge.svg?token=DIJ1KJMVTM)](https://codecov.io/gh/IvanVnucec/Optimal-REQUEST)
[![docs](https://img.shields.io/docsrs/regex?color=blue)](https://ivanvnucec.github.io/Optimal-REQUEST/)

## About The Project
* Least-squares estimation of the attitude quaternion using vector measurements,  
* Recursive,  
* Suitable for Embedded systems,  
* Unit tested.  

## Built With
Project is built using [Meson](https://mesonbuild.com/) build system.

## Getting Started
0. Clone repository and position yourself in the project root directory,
1. Build Docker image `./scripts/docker_image_build.sh`,
2. Run Docker container `./scripts/docker_container_run.sh`,
3. (Optional) Run Clang format `./scripts/docker_project_clang_format.sh`,
4. (Optional) Run CppCheck `./scripts/docker_project_cppcheck.sh`,
5. Build project `./scripts/docker_project_build.sh`.
6. Run Unit tests by running `./scripts/docker_project_test.sh`,
7. (Optional) Debug Unit tests with VS Code by going into `Run` tab and pressing green start button `(gdb) Docker`. To change a file to debug, modify `launch.json` file `"program"` key value,
8. (Optional) Generate Doxygen documentation by running `./scripts/docker_project_doxygen.sh`. Doxygen documentation is generated in `docs/Doxygen` folder,
9. Stop running container `./scripts/docker_container_stop.sh`. Container will remove itself automatically,
10. To build and test user could just call `./scripts/docker_build_and_run_tests.sh`.
 
## Prerequisites
* [Docker](https://www.docker.com/)

## Installation
TODO

## Usage
TODO

## License
[WTFPL – Do What the Fuck You Want to Public License](LICENSE.md)
