#!/bin/bash
if which swiftgen > /dev/null; then
  swiftgen --config "$SRCROOT/SwiftGen/swiftgen.yml"
else
  echo "warning: SwiftGen not installed, download from https://github.com/SwiftGen/SwiftGen"
fi
