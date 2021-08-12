#!/bin/bash

set -eo pipefail

cd WeatherApp; swift test --parallel; cd ..
