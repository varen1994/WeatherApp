#!/bin/bash

set -eo pipefail

xcodebuild -workspace WeatherApp.xcworkspace \
            -scheme WeatherApp \
            -destination platform=iOS\ Simulator,OS=13.3,name=iPhone\ 11 \
            clean test | xcpretty

