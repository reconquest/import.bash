tests:make-tmp-dir -p vendor/lib-a.bash

tests:put vendor/lib-a.bash/lib-a.bash <<EOF
echo -n 1
EOF

tests:put script.bash <<EOF
source import.bash

import lib-a
EOF

tests:ensure source script.bash
tests:assert-stdout 1
