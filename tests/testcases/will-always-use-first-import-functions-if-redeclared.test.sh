tests:make-tmp-dir -p vendor/import.bash
tests:make-tmp-dir -p vendor/lib-a.bash

tests:put vendor/import.bash/import.bash <<EOF
import:use() {
    echo ha-ha-ha
}
EOF

tests:put vendor/lib-a.bash/lib-a.bash <<EOF
echo -n 1
EOF

tests:put script.bash <<EOF
source import.bash

import:use import.bash
import:use lib-a.bash
EOF

tests:ensure source script.bash
tests:assert-stdout 1
