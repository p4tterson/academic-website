#!/bin/sh

# If a command fails then the deploy stops
set -e


## SAVE CHANGES TO WEBSITE REPO (academic-website)
# Remove public directory
rm -rf public

# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	  msg="$*"
fi
git commit -am "$msg"

# Push source and build repos.
printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"
git push origin master

## UPDATE ACTUAL WEBSITE (p4tterson.github.io) - might have to stop hugo server here
# Remove public directory
rm -rf public

# Build the project & add it to the github pages folder
hugo -d p4tterson.github.io

# Go To site folder
cd p4tterson.github.io

# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	  msg="$*"
fi
git commit -am "$msg"

# Push source and build repos.
git push origin master
