#!/bin/bash

set -euo pipefail

source ${BASH_SOURCE[0]%/*}/vendor/github.com/reconquest/tests.sh/tests.sh

tests:main -d tests/testcases -s tests/local-setup.sh "${@:--A}"
