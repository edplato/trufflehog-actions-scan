#!/usr/bin/env sh

args="--regex --entropy=False --max_depth=50"

pwd
ls -la
trufflehog $args file:///github/workspace/.git
