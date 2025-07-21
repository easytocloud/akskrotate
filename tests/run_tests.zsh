#!/bin/zsh
set -e
for t in $(dirname $0)/test_*.zsh; do
  echo "Running ${t}..."
  if zsh "$t"; then
    echo "OK: ${t}"
  else
    echo "FAILED: ${t}"
    exit 1
  fi
done
echo "All tests passed"
