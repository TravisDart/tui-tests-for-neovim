#!/bin/bash
source "$(dirname "$0")/00_env.sh"

# Detect architecture and map to Docker arch
ARCH="$(uname -m)"
if [[ "$ARCH" == "x86_64" ]]; then
  ARCH="amd64"
elif [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
  ARCH="arm64"
else
  echo "Unsupported architecture: $ARCH"
  exit 1
fi

# Tag and push the images
for PYTHON_VERSION in "${PYTHON_VERSIONS[@]}"; do
  LOCAL_IMAGE_VERSION="${LOCAL_IMAGE_NAME}:python${PYTHON_VERSION}"
  REMOTE_IMAGE_VERSION="${PUBLISHED_IMAGE_NAME}:python${PYTHON_VERSION}-${ARCH}"
  echo "Tagging and pushing $LOCAL_IMAGE_VERSION to $REMOTE_IMAGE_VERSION"
  docker tag $LOCAL_IMAGE_VERSION $REMOTE_IMAGE_VERSION
  docker push $REMOTE_IMAGE_VERSION

  if [[ "$PYTHON_VERSION" == "$LATEST_PYTHON_VERSION" ]]; then
    LATEST_MANIFEST_TAG="${PUBLISHED_IMAGE_NAME}:latest"
    LATEST_REMOTE_IMAGE_VERSION="${PUBLISHED_IMAGE_NAME}:latest-${ARCH}"
    echo "Tagging and pushing Python $LATEST_PYTHON_VERSION as latest version."
    docker tag $LOCAL_IMAGE_VERSION $LATEST_REMOTE_IMAGE_VERSION
    docker push $LATEST_REMOTE_IMAGE_VERSION
  fi

done

echo "All images pushed."
