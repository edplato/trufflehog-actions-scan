#!/usr/bin/env sh

args="--regex --rules regexes.json --entropy=False"

if [ -n "${INPUT_BRANCH}" ]; then
  args="${args} --branch ${INPUT_BRANCH}"
fi

pwd
cp /regexes.json regexes.json
which trufflehog
ls -la
echo "Running with ${args}\n"
/usr/local/bin/trufflehog ${args} .
