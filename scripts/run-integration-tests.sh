#!/bin/sh
set -e
cd "$(dirname "$0")"

# explicitly set a short TMPDIR to prevent path too long issue on macosx
export TMPDIR=/tmp

echo "build test contracts"
cd ../tests/integration_tests/hardhat
HUSKY_SKIP_INSTALL=1 npm install
npm run typechain
cd ..

TESTS_TO_RUN="${TESTS_TO_RUN:-all}"

if [[ "$TESTS_TO_RUN" == "all" ]]; then
  echo "run all tests"
  pytest -vv -s
else
  echo "run tests matching $TESTS_TO_RUN"
  pytest -vv -s -m "$TESTS_TO_RUN"
fi
