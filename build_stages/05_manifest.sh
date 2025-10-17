#!/bin/bash
source "$(dirname "$0")/00_env.sh"

for PYTHON_VERSION in "${PYTHON_VERSIONS[@]}"; do
  MANIFEST_TAG="${PUBLISHED_IMAGE_NAME}:python${PYTHON_VERSION}"
  echo "Creating and pushing manifest for $MANIFEST_TAG"
  docker manifest create $MANIFEST_TAG \
      --amend $MANIFEST_TAG-amd64 \
      --amend $MANIFEST_TAG-arm64
  docker manifest push --purge $MANIFEST_TAG

  if [[ "$PYTHON_VERSION" == "$LATEST_PYTHON_VERSION" ]]; then
    LATEST_MANIFEST_TAG="${PUBLISHED_IMAGE_NAME}:latest"
    echo "Creating and pushing manifest for $LATEST_MANIFEST_TAG"
    docker manifest create $LATEST_MANIFEST_TAG \
        --amend $LATEST_MANIFEST_TAG-amd64 \
        --amend $LATEST_MANIFEST_TAG-arm64
    docker manifest push --purge $LATEST_MANIFEST_TAG
  fi
done

echo "All manifests pushed."
