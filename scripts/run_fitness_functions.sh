#!/bin/bash

INCLUDE_DIRS=("test/integration_tests/data_cache/fitness_functions/")
FILES=""

for DIR in "${INCLUDE_DIRS[@]}"; do
  FILES="$FILES $(find "$DIR" -name '*_test.dart')"
done

FILES=$(echo $FILES | tr -s ' ')

flutter test --test-randomize-ordering-seed=random $FILES