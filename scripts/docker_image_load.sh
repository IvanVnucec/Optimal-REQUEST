#!/bin/bash

# load constants
. ./scripts/constants.env

echo "Loading Docker container."
docker load --input ./"$IMAGE_SAVE_DIR"/"$IMAGE_NAME".tar
(($? != 0)) && { printf '%s\n' "Command exited with non-zero"; exit 1; }

echo "Done Loading Docker container."

exit 0
