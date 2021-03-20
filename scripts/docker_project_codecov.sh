#!/bin/bash

# load constants
. ./scripts/constants.env

echo "Generating Code coverage report."
docker exec -i $IMAGE_NAME bash -c "ninja coverage -v -C builddir"
(($? != 0)) && { printf '%s\n' "Command exited with non-zero"; exit 1; }

echo "Done Generating Code coverage report."

exit 0
