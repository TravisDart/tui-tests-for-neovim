# TUI Tests for Neovim

This repo contains the tests for the associated project for [containerized vim](https://github.com/TravisDart/nvchad-neovim).

End-to-end testing for a TUI application is quite a bit different then testing a normal console application. Rather than using pexpect or something, these tests have been implemented using libtmux running in the pytest test runner.

# Run Tests:

Running the tests against the 

```
docker compose run test
```



## Manual testing:

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

Then, (for all except the basic example) make sure these commands work:
* `:!gh auth status`
* `:!git config --global user.email`
* `:!git config --global user.name`
