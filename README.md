bash import directive, like in Golang.

# Usage

```bash
source "$(dirname "${BASH_SOURCE[0]}")"/vendors/github.com/reconquest/import.bash/import.bash

import "path/to/any/lib.bash"
```

# Example

```bash
import "github.com/reconquest/opts.bash"
import "github.com/reconquest/types.bash"
```
