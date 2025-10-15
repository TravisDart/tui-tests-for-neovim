#!/bin/bash
source "$(dirname "$0")/00_env.sh"

# Get build context directory from first argument, default to current directory if not provided.
BUILD_CONTEXT="${1:-.}"

# Build local containers
for PYTHON_VERSION in "${PYTHON_VERSIONS[@]}"; do
  BUILD_IMAGE_NAME="${BUILD_IMAGE_PREFIX}${PYTHON_VERSION}"
  echo
  echo "Building $BUILD_IMAGE_NAME"
  docker build -t $BUILD_IMAGE_NAME --build-arg BASE_IMAGE="python:$PYTHON_VERSION-alpine" "$BUILD_CONTEXT"
done
