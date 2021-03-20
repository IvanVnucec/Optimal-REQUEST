#!/bin/bash

# load constants
. ./scripts/constants.env

echo "Clang-format code formatting check."
docker exec -i $IMAGE_NAME bash -c "mv ./scripts/run-clang-format.py ./"
(($? != 0)) && { printf '%s\n' "Command exited with non-zero"; exit 1; }

docker exec -i $IMAGE_NAME bash -c "python3.8 run-clang-format.py -r src test"
retval=$?

docker exec -i $IMAGE_NAME bash -c "mv ./run-clang-format.py ./scripts"
(($? != 0)) && { printf '%s\n' "Command exited with non-zero"; exit 1; }

echo "Done Clang-format code formatting check."

exit $retval
