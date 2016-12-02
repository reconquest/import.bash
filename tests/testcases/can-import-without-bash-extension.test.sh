tests:make-tmp-dir -p vendor/x/y/lib-a.bash

tests:put vendor/x/y/lib-a.bash/lib-a.bash <<EOF
echo -n 1
EOF

tests:put script.bash <<EOF
source import.bash

import:use x/y/lib-a
EOF

tests:ensure source script.bash
tests:assert-stdout 1
