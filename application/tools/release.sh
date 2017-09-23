#!/bin/bash

if [ -n "$1" ]; then
    echo "Release from $(pwd) to github account $1"
else
    echo "Release from $(pwd) to local"
fi

echo "### Build ###"
./build.sh

echo
echo "### Copy Artifacts ###"
cp build/dpm.o ../bin/

echo
echo
echo "### Push to Git ###"

echo "  Modifications:"
git status

echo
LAST_VERSION="$(git describe --abbrev=0 --tags)"
echo "  Last release is $LAST_VERSION"
echo "  Type the version number that you want to release (semver), followed by [ENTER]:"
read NEXT_VERSION
if [[ $NEXT_VERSION =~ ^[0-9]+.[0-9]+.[0-9]+$ ]]; then
    echo "  Version $NEXT_VERSION is approved"
else
    echo "  Version $NEXT_VERSION is NOT semver, abort"
    exit
fi

git add --all
git commit -m "Release $NEXT_VERSION"

if [ -n "$1" ]; then
    echo "tag and push"
    git tag $NEXT_VERSION
    git push origin $NEXT_VERSION
fi

./tools/publish.sh $NEXT_VERSION $1
