#!/bin/zsh
SCRIPT_DIR=$(cd $(dirname $0)/.. && pwd)
AKSKROTATE="$SCRIPT_DIR/distribution/bin/akskrotate"
set +e

# Test invalid profile names
for invalid_profile in "test|invalid" "test;drop" "test space" "test\$injection" "test<invalid" "test>invalid"; do
  export AWS_PROFILE="$invalid_profile"
  output=$("$AKSKROTATE" 2>&1)
  rc=$?
  
  if [[ $rc -eq 1 ]] && [[ "$output" == *"Invalid AWS_PROFILE format"* ]]; then
    continue
  else
    echo "Failed test for profile '$invalid_profile'"
    echo "Expected exit code 1 and message containing 'Invalid AWS_PROFILE format'"
    echo "Got exit code $rc, output: $output"
    exit 1
  fi
done

# Test valid profile names
for valid_profile in "test" "test.profile" "test_profile" "test-profile" "erik@easytocloud" "test@"; do
  export AWS_PROFILE="$valid_profile"
  export PATH=/nonexistent  # Will fail at jq check, which is expected
  output=$("$AKSKROTATE" 2>&1)
  rc=$?
  
  if [[ $rc -eq 1 ]] && [[ "$output" == "Please install jq before calling akskrotate" ]]; then
    continue
  else
    echo "Failed test for valid profile '$valid_profile'"
    echo "Expected to pass profile validation and fail at jq check"
    echo "Got exit code $rc, output: $output"
    exit 1
  fi
done

echo "All profile validation tests passed"
exit 0