# TUI Tests for Neovim

This repo contains the tests for the associated project for [containerized vim](https://github.com/TravisDart/nvchad-neovim).

End-to-end testing for a TUI application is quite a bit different then testing a normal console application. Rather than using something like pexpect, these tests have been implemented using libtmux running in the pytest test runner.

The main purpose of the tests is to check that the LSP-powered autocomplete works in Python files, but it also checks that the Git credentials are configured properly and that the gh command is working.

# Run Tests:

```
# Switch to the "build_stages" dir of this repo
cd tui-tests/build_stages

# Build the neovim containers (one for each version of Python).
# The first argument is the path to the nv-chad-neovim repository.
bash 01_build_base.sh ../../nvchad-neovim

# Build the containers required for testing
bash 02_build_test.sh

# Run the tests against each of the neovim containers.
# (I use a GitHub token with no permissions, as we're only testing if logins are successful.)
export GH_TOKEN="****"
bash 03_test.sh

# Push the build neovim images to docker hub.
docker login
bash 04_deploy.sh
```

The nvchad-neovim image on Docker Hub supports both amd64 and arm64 (Apple Silicon). To created a multiarch build, run the above commands on both systems, then run this command once (on either system):

```
cd tui-tests/build_stages
bash 05_manifest.sh
```

Every time a new build is made, the manifest must be updated. (It won't update automatically.)



## Manual testing:

For debugging, the tests can equivalently be run manually:

Before manually testing, run these commands:

```
docker rmi travisdart/nvchad-neovim:latest
export GH_TOKEN="..."
```

Create an example workspace:
```
echo "numpy" > requirements.txt
echo "import numpy" > example.py
echo >> example.py
echo "numpy.linalg" >> example.py
```

Then, run the examples from [the readme](https://github.com/TravisDart/nvchad-neovim) for containerized vim.

For each example, first test that autocomplete is working.

Then for all examples except the basic example, make sure these commands work:
* `:!gh auth status`
* `:!git config --global user.email`
* `:!git config --global user.name`
