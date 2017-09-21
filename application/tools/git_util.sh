#!/bin/bash

# Get number of files added to the index (but uncommitted)
expr $(git status --porcelain 2>/dev/null| grep "^M" | wc -l)

# Get number of files that are uncommitted and not added
expr $(git status --porcelain 2>/dev/null| grep "^ M" | wc -l)

# Get number of total uncommited files
expr $(git status --porcelain 2>/dev/null| egrep "^(M| M)" | wc -l)