# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= env setup -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# These variables are used both in the build stage and in tests.

# Run this from the project root directory.
cd "$(dirname "$0")"

# GH_TOKEN="..." Set this in your environment before running tests.
GIT_AUTHOR_EMAIL="28a63484-6564-4a05-8830-b1526fdee4e0@example.com"
GIT_AUTHOR_NAME="c79a0846-b2f3-4d6b-83c2-35314d24f8d4"

# All currently-supported Python versions. (Latest version must be last.)
# See: https://devguide.python.org/versions/#supported-versions
PYTHON_VERSIONS=(3.9 3.10 3.11 3.12 3.13 3.14)
LATEST_PYTHON_VERSION=${PYTHON_VERSIONS[@]: -1}

# If we run locally, we use a prefix to namespace our containers,
# as the test container uses the host's Docker daemon.
LOCAL_IMAGE_NAME="neovim-6d4289a3-8b25-44fa-a0dc-7a6612fecfdf-nvchad-neovim"
PUBLISHED_IMAGE_NAME="travisdart/nvchad-neovim"
if [[ "$@" == "--published" ]]; then
  IMAGE_PREFIX=$PUBLISHED_PREFIX"nvchad-neovim"
  echo "Using published containers."
else
  IMAGE_PREFIX=$LOCAL_PREFIX"nvchad-neovim"
  echo "Using local containers."
fi

PYTEST_CONTAINER_NAME="${LOCAL_PREFIX}pytest"
WORKSPACE_VOLUME_NAME="${LOCAL_PREFIX}workspace"
ADVANCED_TEST_CONTAINER_PREFIX="${LOCAL_PREFIX}advanced-test-container"
