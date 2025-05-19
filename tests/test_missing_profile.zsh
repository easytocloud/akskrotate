#!/usr/bin/env zsh
SCRIPT_DIR=$(cd $(dirname $0)/.. && pwd)
AKSKROTATE="$SCRIPT_DIR/distribution/bin/akskrotate"
set +e
unset AWS_PROFILE
output=$(/usr/bin/zsh "$AKSKROTATE" 2>&1)
rc=$?
set -e
if [[ $rc -eq 1 && "$output" == "Please set AWS_PROFILE before calling akskrotate" ]]; then
  exit 0
else
  echo "expected exit code 1 and message 'Please set AWS_PROFILE before calling akskrotate'"
  echo "got exit code $rc, output: $output"
  exit 1
fi
