#!/usr/bin/env bash

### bootstrap
version="3.8.6"
# pyenv install --list  # check python versions
# pyenv install 3.8.6  # install 3.8
# pyenv global 3.8.6  # make it global
# python3 --version  # verify

brew install --formulae "pyenv"
pyenv install "$version"
pyenv global "$version"
unset version
###
exit 0
