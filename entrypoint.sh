#!/bin/bash

repo="."
args="--regex --entropy=False --max_depth=50 --repo_path=${repo} --exclude_paths .truffleignore"

if [ -n "${INPUT_SCANARGUMENTS}" ]; then
  args="${INPUT_SCANARGUMENTS}" # Overwrite if new options string is provided
fi

if [ -n "${INPUT_BRANCH}" ]; then
  args="${args} --branch ${INPUT_BRANCH}"
fi

cp /regexes.json .

# By default the 'WORKDIR' of our Docker image is set to the 'GITHUB_WORKSPACE'
# which is mounted into our image. This means, as long as a checkout action was
# done before our action runs, we'll have access to the repository.
query="$args $repo" # Build args query with repository url
/usr/local/bin/trufflehog ${query}
