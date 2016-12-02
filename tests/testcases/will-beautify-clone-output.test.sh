tests:put script.bash <<EOF
source import.bash

import:use whatever.bash
EOF

git() {
    root=$(pwd)

    if [ "$1" != "clone" ]; then
        return
    fi

    tests:make-tmp-dir vendor/whatever.bash

    tests:put vendor/whatever.bash/whatever.bash

    cat <<LOG
Cloning into '${root}vendor/github.com/reconquest/test-runner.bash'...
remote: Counting objects: 22, done.
remote: Compressing objects:   6% (1/16)           \r\
remote: Compressing objects:  12% (2/16)           \r\
remote: Compressing objects:  18% (3/16)           \r\
remote: Compressing objects:  25% (4/16)           \r\
remote: Compressing objects:  31% (5/16)           \r\
remote: Compressing objects:  37% (6/16)           \r\
remote: Compressing objects:  43% (7/16)           \r\
remote: Compressing objects:  50% (8/16)           \r\
remote: Compressing objects:  56% (9/16)           \r\
remote: Compressing objects:  62% (10/16)           \r\
remote: Compressing objects:  68% (11/16)           \r\
remote: Compressing objects:  75% (12/16)           \r\
remote: Compressing objects:  81% (13/16)           \r\
remote: Compressing objects:  87% (14/16)           \r\
remote: Compressing objects:  93% (15/16)           \r\
remote: Compressing objects: 100% (16/16)           \r\
remote: Compressing objects: 100% (16/16), done.
remote: Total 22 (delta 2), reused 14 (delta 1), pack-reused 0
Receiving objects:   4% (1/22)   \r\
Receiving objects:   9% (2/22)   \r\
Receiving objects:  13% (3/22)   \r\
Receiving objects:  18% (4/22)   \r\
Receiving objects:  22% (5/22)   \r\
Receiving objects:  27% (6/22)   \r\
Receiving objects:  31% (7/22)   \r\
Receiving objects:  36% (8/22)   \r\
Receiving objects:  40% (9/22)   \r\
Receiving objects:  45% (10/22)   \r\
Receiving objects:  50% (11/22)   \r\
Receiving objects:  54% (12/22)   \r\
Receiving objects:  59% (13/22)   \r\
Receiving objects:  63% (14/22)   \r\
Receiving objects:  68% (15/22)   \r\
Receiving objects:  72% (16/22)   \r\
Receiving objects:  77% (17/22)   \r\
Receiving objects:  81% (18/22)   \r\
Receiving objects:  86% (19/22)   \r\
Receiving objects:  90% (20/22)   \r\
Receiving objects:  95% (21/22)   \r\
Receiving objects: 100% (22/22)   \r\
Receiving objects: 100% (22/22), 3.37 KiB | 0 bytes/s, done.
Resolving deltas:   0% (0/2)   \r\
Resolving deltas: 100% (2/2)   \r\
Resolving deltas: 100% (2/2), done.
Checking connectivity... done.
Submodule 'vendor/github.com/reconquest/import.bash' (https://github.com/reconquest/import.bash) registered for path 'vendor/github.com/reconquest/import.bash'
Cloning into '${root}vendor/github.com/reconquest/test-runner.bash/vendor/github.com/reconquest/import.bash'...
Submodule path 'vendor/github.com/reconquest/import.bash': checked out '022398f7edd799220004c0d1cd3c85846ddeb855'
Submodule 'vendor/github.com/reconquest/tests.sh' (https://github.com/reconquest/tests.sh) registered for path 'vendor/github.com/reconquest/import.bash/vendor/github.com/reconquest/tests.sh'
Cloning into '${root}vendor/github.com/reconquest/test-runner.bash/vendor/github.com/reconquest/import.bash/vendor/github.com/reconquest/tests.sh'...
Submodule path 'vendor/github.com/reconquest/import.bash/vendor/github.com/reconquest/tests.sh': checked out '424dce104a2a2b913ff46afbb0a130b55468dc47'
Submodule 'vendor/github.com/reconquest/shdoc' (https://github.com/reconquest/shdoc) registered for path 'vendor/github.com/reconquest/import.bash/vendor/github.com/reconquest/tests.sh/vendor/github.com/reconquest/shdoc'
Cloning into '${root}vendor/github.com/reconquest/test-runner.bash/vendor/github.com/reconquest/import.bash/vendor/github.com/reconquest/tests.sh/vendor/github.com/reconquest/shdoc'...
Submodule path 'vendor/github.com/reconquest/import.bash/vendor/github.com/reconquest/tests.sh/vendor/github.com/reconquest/shdoc': checked out 'd737d7ad01512396d376c626ffdc7b882ef85768'
Cloning into '${root}vendor/github.com/reconquest/test-runner.bash/vendor/github.com/reconquest/opts.bash'...
Submodule 'vendor/github.com/reconquest/tests.sh' (https://github.com/reconquest/tests.sh) registered for path 'vendor/github.com/reconquest/tests.sh'
Submodule 'vendor/github.com/reconquest/types.bash' (https://github.com/reconquest/types.bash) registered for path 'vendor/github.com/reconquest/types.bash'
Cloning into '${root}vendor/github.com/reconquest/test-runner.bash/vendor/github.com/reconquest/opts.bash/vendor/github.com/reconquest/tests.sh'...
Submodule path 'vendor/github.com/reconquest/tests.sh': checked out '424dce104a2a2b913ff46afbb0a130b55468dc47'
Submodule 'vendor/github.com/reconquest/shdoc' (https://github.com/reconquest/shdoc) registered for path 'vendor/github.com/reconquest/tests.sh/vendor/github.com/reconquest/shdoc'
Cloning into '${root}vendor/github.com/reconquest/test-runner.bash/vendor/github.com/reconquest/opts.bash/vendor/github.com/reconquest/tests.sh/vendor/github.com/reconquest/shdoc'...
Submodule path 'vendor/github.com/reconquest/tests.sh/vendor/github.com/reconquest/shdoc': checked out 'd737d7ad01512396d376c626ffdc7b882ef85768'
Cloning into '${root}vendor/github.com/reconquest/test-runner.bash/vendor/github.com/reconquest/opts.bash/vendor/github.com/reconquest/types.bash'...
Submodule path 'vendor/github.com/reconquest/types.bash': checked out 'a5ed78e7895059c37bc46bfc823fa569904ac664'
Submodule 'vendor/github.com/reconquest/tests.sh' (https://github.com/reconquest/tests.sh) registered for path 'vendor/github.com/reconquest/types.bash/vendor/github.com/reconquest/tests.sh'
Cloning into '${root}vendor/github.com/reconquest/test-runner.bash/vendor/github.com/reconquest/opts.bash/vendor/github.com/reconquest/types.bash/vendor/github.com/reconquest/tests.sh'...
Submodule path 'vendor/github.com/reconquest/types.bash/vendor/github.com/reconquest/tests.sh': checked out '424dce104a2a2b913ff46afbb0a130b55468dc47'
Submodule 'vendor/github.com/reconquest/shdoc' (https://github.com/reconquest/shdoc) registered for path 'vendor/github.com/reconquest/types.bash/vendor/github.com/reconquest/tests.sh/vendor/github.com/reconquest/shdoc'
Cloning into '${root}vendor/github.com/reconquest/test-runner.bash/vendor/github.com/reconquest/opts.bash/vendor/github.com/reconquest/types.bash/vendor/github.com/reconquest/tests.sh/vendor/github.com/reconquest/shdoc'...
Submodule path 'vendor/github.com/reconquest/types.bash/vendor/github.com/reconquest/tests.sh/vendor/github.com/reconquest/shdoc': checked out 'd737d7ad01512396d376c626ffdc7b882ef85768'
Cloning into '${root}vendor/github.com/reconquest/go-test.bash'...
remote: Counting objects: 6, done.
remote: Compressing objects:  16% (1/6)           \r\
remote: Compressing objects:  33% (2/6)           \r\
remote: Compressing objects:  50% (3/6)           \r\
remote: Compressing objects:  66% (4/6)           \r\
remote: Compressing objects:  83% (5/6)           \r\
remote: Compressing objects: 100% (6/6)           \r\
remote: Compressing objects: 100% (6/6), done.
remote: Total 6 (delta 0), reused 3 (delta 0), pack-reused 0
Receiving objects:  16% (1/6)   \r\
Receiving objects:  33% (2/6)   \r\
Receiving objects:  50% (3/6)   \r\
Receiving objects:  66% (4/6)   \r\
Receiving objects:  83% (5/6)   \r\
Receiving objects: 100% (6/6)   \r\
Receiving objects: 100% (6/6), done.
Checking connectivity... done.
LOG
}

tests:ensure source script.bash

tests:assert-no-diff-blank stderr <<EXPECTED
github.com/reconquest/test-runner
submodule: github.com/reconquest/import
submodule: github.com/reconquest/tests.sh
submodule: github.com/reconquest/shdoc
github.com/reconquest/test-runner/github.com/reconquest/opts
submodule: github.com/reconquest/tests.sh
submodule: github.com/reconquest/shdoc
github.com/reconquest/test-runner/github.com/reconquest/opts/github.com/reconquest/types
submodule: github.com/reconquest/tests.sh
submodule: github.com/reconquest/shdoc
github.com/reconquest/go-test
EXPECTED
