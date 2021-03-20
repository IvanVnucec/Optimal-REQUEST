#!/bin/bash

# load constants
. ./scripts/constants.env

echo "Run Docker container."
docker run --name $IMAGE_NAME --rm -d -v "/$(pwd):$HOST_WORKDIR" -i -t $IMAGE_NAME
(($? != 0)) && { printf '%s\n' "Command exited with non-zero"; exit 1; }

echo "Done Run Docker container."

exit 0
