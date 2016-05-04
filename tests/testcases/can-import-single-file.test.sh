tests:make-tmp-dir vendor/lib-a

tests:put vendor/lib-a/lib-a.bash <<EOF
echo -n 1
EOF

tests:put script.bash <<EOF
source import.bash

import lib-a
EOF

tests:ensure source script.bash
tests:assert-stdout 1
