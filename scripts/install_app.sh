#! /usr/bin/env bash

# TODO
# - set up nvm
# - set up conda
# - set up brew

# note, apps that using virtual env are installed separately, we could either have default fallback or ignore it

# FIXME shellcheck, no ideal way to install on a restricted machine yet

# lsp for bash, see also shellcheck
npm i -g bash-language-server

# man for the impatient
npm i -g tldr

# handy websocket cli for testing
npm i -g wscat

# better git diff
npm i -g diff-so-fancy

# conda base environments creations
# TODO remove python2 maybe after 2020
conda create -n py3 python=3
conda create -n py2 python=2

#
# brew installs
#

# better alternative for curl
brew install httpie
# handy spark lines
brew install spark
# YGNI
brew install youtube-dl
# JSON for cli
brew install jq

# docker file linter
brew install hadolint

#
# linters
#
# could just refer to the ale doc for a comprehensive list
