#!/bin/bash

set -euo pipefail

source ${BASH_SOURCE[0]%/*}/vendor/github.com/reconquest/tests.sh/tests.sh

cd tests/

tests:main -d testcases -s local-setup.sh "${@:--A}"
