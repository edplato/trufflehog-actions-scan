#!/usr/bin/env sh
set -e # Abort script at first error

args="--regex --entropy=False --max_depth=50" # Default trufflehog options

if [ -n "$1" ]; then
  args="$@" # Overwrite if new options string is provided
fi

if [ -n "${INPUT_GITHUBTOKEN}" ]; then
  githubRepo="https://$INPUT_GITHUBTOKEN@github.com/$GITHUB_REPOSITORY"
else
  githubRepo="https://github.com/$GITHUB_REPOSITORY"
fi

echo "${INPUT_GITHUBTOKEN}"
echo "${INPUT_SCANARGUMENTS}"
echo "$githubRepo"
echo "$args"

trufflehog $args $githubRepo