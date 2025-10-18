#!/bin/bash
source "$(dirname "$0")/00_env.sh"

echo "Cleaning up..."

docker stop $(docker ps | grep $LOCAL_IMAGE_NAME | awk '{print $1}')

for PYTHON_VERSION in "${PYTHON_VERSIONS[@]}"; do
  echo "Removing $LOCAL_IMAGE_NAME:python$PYTHON_VERSION"
  docker image rm "$LOCAL_IMAGE_NAME:python$PYTHON_VERSION"
  echo "Removing $PUBLISHED_IMAGE_PREFIX:python$PYTHON_VERSION"
  docker image rm "$PUBLISHED_IMAGE_PREFIX:python$PYTHON_VERSION"
  echo "Removing $LOCAL_IMAGE_NAME:python$PYTHON_VERSION"
  docker image rm "$ADVANCED_TEST_CONTAINER_PREFIX:python$PYTHON_VERSION"
done
echo "Removing $LOCAL_IMAGE_NAME:latest"
docker image rm "$LOCAL_IMAGE_NAME:latest"
echo "Removing $PUBLISHED_IMAGE_PREFIX:latest"
docker image rm "$PUBLISHED_IMAGE_PREFIX:latest"
echo "Removing $PYTEST_CONTAINER_NAME"
docker image rm "$PYTEST_CONTAINER_NAME"

echo "Removing $WORKSPACE_VOLUME_NAME"
docker volume rm $WORKSPACE_VOLUME_NAME