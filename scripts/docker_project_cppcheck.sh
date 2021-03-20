#!/bin/bash

# load constants
. ./scripts/constants.env

echo "Run Cppcheck and print results to stdout."
docker exec -i $IMAGE_NAME bash -c "cppcheck --quiet --enable=all --project=./builddir/compile_commands.json 2>&1"
(($? != 0)) && { printf '%s\n' "Command exited with non-zero"; exit 1; }

echo "Done Run Cppcheck and print results to stdout."

exit 0
