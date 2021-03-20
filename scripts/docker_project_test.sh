#!/bin/bash

# load constants
. ./scripts/constants.env

echo "Run project tests."
docker exec -i $IMAGE_NAME bash -c "meson test -C builddir"
(($? != 0)) && { printf '%s\n' "Command exited with non-zero"; exit 1; }

echo "Done Run project tests."

exit 0
