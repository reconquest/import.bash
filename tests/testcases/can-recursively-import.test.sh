tests:make-tmp-dir -p vendor/lib-a.bash/vendor/lib-b.bash

tests:put vendor/lib-a.bash/vendor/lib-b.bash/lib-b.bash <<EOF
echo -n 3
EOF

tests:put vendor/lib-a.bash/lib-a.bash <<EOF
import:use lib-b
echo -n 2
EOF

tests:put script.bash <<EOF
source import.bash

import:use lib-a
echo -n 1
EOF

tests:ensure source script.bash
tests:assert-stdout 321
