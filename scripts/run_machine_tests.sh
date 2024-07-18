#!/bin/bash

EXCLUDE_DIRS=("test/integration_tests/data_cache/fitness_functions/")
EXCLUDE_EXPR=""

for DIR in "${EXCLUDE_DIRS[@]}"; do
  EXCLUDE_EXPR="$EXCLUDE_EXPR ! -path '$DIR*'"
done

FILES=$(eval "find test -name '*_test.dart' $EXCLUDE_EXPR")

flutter test --test-randomize-ordering-seed=random --coverage --machine $FILES > test-results.json