#!/usr/bin/env sh

args="--regex --rules regexes.json --entropy=False"

if [ -n "${INPUT_BRANCH}" ]; then
  args="${args} --branch ${INPUT_BRANCH}"
fi

pwd
ls -la
echo "Running with ${args}\n"
trufflehog $args .
