tests:put script-a.bash <<EOF
echo -n 1
EOF

tests:put script.bash <<EOF
import:include script-a.bash
EOF

tests:ensure source script.bash
tests:assert-stdout 1
