#!/bin/bash

# load constants
. ./scripts/constants.env

echo "Clang-format code formatting."
docker exec -i $IMAGE_NAME bash -c "clang-format-11 -i --verbose --style=file src/*.c"
(($? != 0)) && { printf '%s\n' "Command exited with non-zero"; exit 1; }

docker exec -i $IMAGE_NAME bash -c "clang-format-11 -i --verbose --style=file src/*.h"
(($? != 0)) && { printf '%s\n' "Command exited with non-zero"; exit 1; }

docker exec -i $IMAGE_NAME bash -c "clang-format-11 -i --verbose --style=file test/*.c"
(($? != 0)) && { printf '%s\n' "Command exited with non-zero"; exit 1; }

docker exec -i $IMAGE_NAME bash -c "clang-format-11 -i --verbose --style=file test/*.h"
(($? != 0)) && { printf '%s\n' "Command exited with non-zero"; exit 1; }

echo "Done Clang-format code formatting."

exit 0
