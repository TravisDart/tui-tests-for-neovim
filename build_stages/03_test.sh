#!/bin/bash
source "$(dirname "$0")/00_env.sh"

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= Run the tests -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
ALL_TESTS_PASS=true
for PYTHON_VERSION_TO_TEST in "${PYTHON_VERSIONS[@]}"; do
  echo
  echo "Testing Python $PYTHON_VERSION_TO_TEST image"

  docker run -it --rm --env CONTAINER_GH_TOKEN=$CONTAINER_GH_TOKEN  \
    -v /var/run/docker.sock:/var/run/docker.sock -v ../tests:/tests $PYTEST_CONTAINER_NAME \
    pytest \
    --local-container-name "${LOCAL_IMAGE_NAME}:python${PYTHON_VERSION_TO_TEST}" \
    --advanced-example-container-name "${ADVANCED_TEST_CONTAINER_PREFIX}:python${PYTHON_VERSION_TO_TEST}" \
    --git-author-email $GIT_AUTHOR_EMAIL \
    --git-author-name $GIT_AUTHOR_NAME \
    --github-token $GH_TOKEN \
    --workspace-volume-name $WORKSPACE_VOLUME_NAME

  if [ $? -ne 0 ]; then
    ALL_TESTS_PASS=false
  fi
done

if [[ "$ALL_TESTS_PASS" == "true" ]]; then
  echo "All tests pass."
else
  echo "Some tests failed."
  exit 1
fi
