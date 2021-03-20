#!/bin/bash

# load constants
. ./scripts/constants.env

echo "Building Docker image."
docker build -t="$IMAGE_NAME" .
exit $?
