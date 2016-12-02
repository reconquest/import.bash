tests:make-tmp-dir -p vendor/lib-a.bash

tests:put vendor/lib-a.bash/lib-a.bash <<EOF
set -e

import:use lib-b
echo -n 2
EOF

tests:put script.bash <<EOF
set -e

source import.bash

import:use lib-a
echo -n 1
EOF

git() {
    tests:eval echo "$*" '>>' $(tests:get-tmp-dir)/git.log

    command git "$@"
}

tests:not tests:ensure source script.bash
tests:assert-stderr "can't clone 'lib-b.bash'"

expected_path="$(tests:get-tmp-dir)/vendor/lib-a.bash/vendor/lib-b.bash"
tests:assert-re git.log "clone.*https://lib-b.bash $expected_path"
