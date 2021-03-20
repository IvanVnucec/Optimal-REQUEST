#!/bin/bash

# load constants
. ./scripts/constants.env

echo "Stop Docker container."
docker container stop $IMAGE_NAME
(($? != 0)) && { printf '%s\n' "Command exited with non-zero"; exit 1; }

echo "Done Stop Docker container."

exit 0
