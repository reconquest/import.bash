tests:put script-a.bash <<EOF
echo -n 1
EOF

tests:put script.bash <<EOF
include script-a.bash
EOF

tests:make-tmp-dir some-dir
tests:cd some-dir

tests:ensure source ../script.bash
tests:assert-stdout 1
