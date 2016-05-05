tests:make-tmp-dir -p vendor/x/y/lib-a

tests:put vendor/x/y/lib-a/lib-a.bash <<EOF
echo -n 1
EOF

tests:put script.bash <<EOF
source import.bash

import x/y/lib-a
EOF

tests:ensure source script.bash
tests:assert-stdout 1
