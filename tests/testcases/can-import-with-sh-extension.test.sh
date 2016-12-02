tests:make-tmp-dir -p vendor/x/y/lib-a.sh

tests:put vendor/x/y/lib-a.sh/lib-a.sh <<EOF
echo -n 1
EOF

tests:put script.bash <<EOF
source import.bash

import:use x/y/lib-a.sh
EOF

tests:ensure source script.bash
tests:assert-stdout 1
