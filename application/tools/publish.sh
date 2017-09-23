#!/bin/bash

if [[ $1 =~ ^[0-9]+.[0-9]+.[0-9]+$ ]]; then
    echo "  Version $1 is approved"
else
    echo "  Version $1 is NOT semver, abort"
    exit
fi

GIT_REPO="https://github.com/adamwestman/DPM"
VERSION_URL="$GIT_REPO/archive/$1.zip"

echo "Publishing artifact from $VERSION_URL"

brew create $VERSION_URL

echo "Finish your brew forumla edits, continue by [ENTER]"
read

brew install --verbose --debug dpm

brew test DPM

if [ -z "$2" ]; then
    echo "Global publish requires github account name, aborting"
    exit
else
    echo "public release to brew"
fi

brew update # required in more ways than you think (initializes the brew git repository if you don't already have it)
cd $(brew --repo homebrew/core)
# Create a new git branch for your formula so your pull request is easy to
# modify if any changes come up during review.
BRANCH_NAME="dpm_version_$1"
git checkout -b $BRANCH_NAME
git add Formula/dpm.rb
git commit

echo "Publishing from github account $2"
git push https://github.com/$2/homebrew-core/ $BRANCH_NAME
