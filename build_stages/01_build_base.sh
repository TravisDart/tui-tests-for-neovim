#!/bin/bash
source "$(dirname "$0")/00_env.sh"

# The build context is the path to the containerized-neovim repo.
BUILD_CONTEXT="${1:-.}"

# Build local containers
for PYTHON_VERSION in "${PYTHON_VERSIONS[@]}"; do
  BUILD_IMAGE_NAME="${IMAGE_PREFIX}:python${PYTHON_VERSION}"
  echo
  echo "Building $BUILD_IMAGE_NAME"
  docker build --build-arg BASE_IMAGE="python:$PYTHON_VERSION-alpine" \
               -t $BUILD_IMAGE_NAME "$BUILD_CONTEXT"
done
