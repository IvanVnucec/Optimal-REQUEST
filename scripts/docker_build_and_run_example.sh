#!/bin/bash

# load constants
. ./scripts/constants.env

echo "Build and run example."

./scripts/docker_image_build.sh
./scripts/docker_container_run.sh
./scripts/docker_project_build.sh

echo "Running example:"

docker exec -i $IMAGE_NAME bash -c "./builddir/src/example_exe"
(($? != 0)) && { printf '%s\n' "Command exited with non-zero"; exit 1; }

echo "Done running example."

./scripts/docker_container_stop.sh

echo "Done build and run example."
