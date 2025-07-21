#!/bin/zsh
SCRIPT_DIR=$(cd $(dirname $0)/.. && pwd)
AKSKROTATE="$SCRIPT_DIR/distribution/bin/akskrotate"
set +e
export AWS_PROFILE=dummy
PATH=/nonexistent
output=$("$AKSKROTATE" 2>&1)
rc=$?
set -e
if [[ $rc -eq 1 && "$output" == "Please install jq before calling akskrotate" ]]; then
  exit 0
else
  echo "expected exit code 1 and message 'Please install jq before calling akskrotate'"
  echo "got exit code $rc, output: $output"
  exit 1
fi
