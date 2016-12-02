tests:make-tmp-dir -p vendor/x/lib-a.bash/lib-a
tests:make-tmp-dir -p blah/

tests:eval git init

tests:put vendor/x/lib-a.bash/lib-a.bash <<EOF
echo -n 1
EOF

tests:put blah/script.bash <<EOF
source import.bash

import:use x/lib-a
EOF

tests:eval git add script.bash
tests:eval git commit -m initial

tests:ensure source blah/script.bash
tests:assert-stdout 1
