#!/bin/bash

# load constants
. ./scripts/constants.env

echo "Saving Docker containter."
mkdir -p "$IMAGE_SAVE_DIR"
docker save --output ./"$IMAGE_SAVE_DIR"/"$IMAGE_NAME".tar "$IMAGE_NAME"
(($? != 0)) && { printf '%s\n' "Command exited with non-zero"; exit 1; }

echo "Done Saving Docker container."

exit 0
