# import.bash

bash import directive, like in Golang.

![import-bash-2](https://cloud.githubusercontent.com/assets/674812/16044577/d6a56ab6-3266-11e6-86eb-c4bad3745d08.gif)

# Usage

```bash
source "vendor/github.com/reconquest/import.bash/import.bash"

import:use "path/to/any/lib.bash"
```
# How does it work?

import.bash will look into vendor directory and, if vendor missing, will try to
clone it.

Then, file named same as last part of the import name will be sourced.

# Example

```bash
source "vendor/github.com/reconquest/import.bash/import.bash"

import:use "github.com/reconquest/opts.bash"

declare -a args
declare -A opts

opts:parse opts args -a -b: -- "${@}"

echo "-a: ${opts[-a]}"
echo "-b: ${opts[-b]}"

echo "args: ${args[@]}"
```

# Reference

See reference at [REFERENCE.md](REFERENCE.md).

# Various libs

* [types.bash](https://github.com/reconquest/types.bash) &mdash; type check functions;
* [opts.bash](https://github.com/reconquest/opts.bash) &mdash; easy to use arguments parser;
* [tests.sh](https://github.com/reconquest/tests.sh) &mdash; library for writing integration tests for any tool;
* [test-runner.bash](https://github.com/reconquest/test-runner.bash) &mdash; test-runner for tests.sh;
* [progress.bash](https://github.com/reconquest/progress.bash) &mdash; progress indicators;
* [coproc.bash](https://github.com/reconquest/coproc.bash) &mdash; golang-style routiness in bash;
* [go-test.bash](https://github.com/reconquest/go-test.bash) &mdash; collecting coverage from runs of golang binaries;
* [vim-test.bash](https://github.com/reconquest/vim-test.bash) &mdash; framework for writing tests for vim plugins;
* [classes.bash](https://github.com/reconquest/classes.bash) &mdash; classes implementation in bash;
* [blank.bash](https://github.com/reconquest/blank.bash) &mdash; helpers for writing tests using [blankd](https://github.com/kovetskiy/blankd);
* [tmux.bash](https://github.com/reconquest/tmux.bash) &mdash; helpers for managing tmux instances (like, for tests);
* [containers.bash](https://github.com/reconquest/containers.bash) &mdash; helpers for managing containers in tests;
* [hastur.bash](https://github.com/reconquest/hastur.bash) &mdash; helpers for using [hastur](https://github.com/seletskiy/hastur);
