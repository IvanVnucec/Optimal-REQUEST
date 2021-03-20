#!/bin/bash

# load constants
. ./scripts/constants.env

echo "Compile project."
docker exec -i $IMAGE_NAME bash -c "CC=gcc meson builddir -Db_coverage=true"
(($? != 0)) && { printf '%s\n' "Command exited with non-zero"; exit 1; }

docker exec -i $IMAGE_NAME bash -c "meson compile -C builddir"
(($? != 0)) && { printf '%s\n' "Command exited with non-zero"; exit 1; }

echo "Done Compile project."
exit 0
