#!/bin/bash
tuist generate --no-open
swiftgen --config SwiftGen/swiftgen.yml
open base_project.xcworkspace