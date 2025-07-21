#!/bin/zsh
SCRIPT_DIR=$(cd $(dirname $0)/.. && pwd)
AKSKROTATE="$SCRIPT_DIR/distribution/bin/akskrotate"
set +e
unset AWS_PROFILE
output=$("$AKSKROTATE" 2>&1)
rc=$?
set -e
if [[ $rc -eq 1 && ("$output" == "Please set AWS_PROFILE before calling akskrotate" || "$output" =~ "AWS_PROFILE: parameter not set") ]]; then
  exit 0
else
  echo "expected exit code 1 and message about AWS_PROFILE not being set"
  echo "got exit code $rc, output: $output"
  exit 1
fi
