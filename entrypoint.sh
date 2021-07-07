#!/usr/bin/env sh

set -e # Abort script at first error

args="--regex --entropy=False --max_depth=50" # Default trufflehog options

if [ -n "${INPUT_SCANARGUMENTS}" ]; then
  args="${INPUT_SCANARGUMENTS}" # Overwrite if new options string is provided
fi

# Use current branch if not provided
if [ "$(echo "$args")" != *"branch"* ]; then
  branch=${GITHUB_REF%:*}
  branch=${branch##*/}
  args="${args} --branch=${branch}"
fi

# Use repository - using 'GITHUB_WORKSPACE' does not allow certain options (e.g., max_depth, since_commit)
if [ -n "${INPUT_GITHUBTOKEN}" ]; then
  githubRepo="https://$INPUT_GITHUBTOKEN@github.com/$GITHUB_REPOSITORY" # Overwrite for private repository if token provided
else
  githubRepo="https://github.com/$GITHUB_REPOSITORY" # Default target repository
fi

query="$args $githubRepo" # Build args query with repository url
echo "$query"
echo "$GITHUB_SHA"
echo "$BEFORE_SHA"
echo "${BEFORE_SHA}"
git rev-parse HEAD
trufflehog $query
