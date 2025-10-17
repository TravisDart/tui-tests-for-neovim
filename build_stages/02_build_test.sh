#!/bin/bash
source "$(dirname "$0")/00_env.sh"

# -=-=-=-=-=-=-=-=-=-=-=-=-= Build "advanced example" containers -=-=-=-=-=-=-=-=-=-=
for PYTHON_VERSION in "${PYTHON_VERSIONS[@]}"; do
  ADVANCED_TEST_CONTAINER_NAME="${ADVANCED_TEST_CONTAINER_PREFIX}:python${PYTHON_VERSION}"
  BASE_CONTAINER_NAME="${IMAGE_NAME}:python${PYTHON_VERSION}"
  echo
  echo "Building $ADVANCED_TEST_CONTAINER_NAME based on $BASE_CONTAINER_NAME"
  docker build --no-cache --progress=plain -t $ADVANCED_TEST_CONTAINER_NAME \
  --build-arg GIT_AUTHOR_EMAIL=$GIT_AUTHOR_EMAIL \
  --build-arg GIT_AUTHOR_NAME=$GIT_AUTHOR_NAME \
  --build-arg BASE_IMAGE=$BASE_CONTAINER_NAME \
  --file ../tests/advanced_example/advanced_example.Dockerfile \
  ../tests/advanced_example/
done

# -=-=-=-=-=-=-=-=-=-=-=-=-= Build the pytest container -=-=-=-=-=-=-=-=-=-=
docker build -t $PYTEST_CONTAINER_NAME -f ../pytest.Dockerfile ..

# -=-=-=-=-=-=-=-=-=-=-=-=-= Build the test volume -=-=-=-=-=-=-=-=-=-=-=-=
docker volume create $WORKSPACE_VOLUME_NAME

# Populate the test volume with data (our example workspace).
docker run -it --rm -v $WORKSPACE_VOLUME_NAME:/root/workspace \
-w /root/workspace python:$LATEST_PYTHON_VERSION-alpine sh -elic '
echo "numpy" > requirements.txt
echo "import numpy" > example.py
echo >> example.py
echo "numpy.linalg" >> example.py
'
