#!/bin/bash

TAG_VERSION="${GITHUB_REF#refs/tags/v}"

PUBSPEC_VERSION=$(grep 'version:' pubspec.yaml | awk '{print $2}')

if [ "$TAG_VERSION" != "$PUBSPEC_VERSION" ]; then
  echo "Tag version ($TAG_VERSION) does not match pubspec.yaml version ($PUBSPEC_VERSION)"
  exit 1
fi

echo "TAG_VERSION=$TAG_VERSION" >> $GITHUB_ENV
echo "PUBSPEC_VERSION=$PUBSPEC_VERSION" >> $GITHUB_ENV
