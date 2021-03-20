#!/bin/bash

# load constants
. ./scripts/constants.env

echo "Build and run project."
./scripts/docker_image_build.sh
./scripts/docker_container_run.sh
./scripts/docker_project_build.sh
./scripts/docker_project_test.sh
./scripts/docker_container_stop.sh

echo "Done build and run project."
