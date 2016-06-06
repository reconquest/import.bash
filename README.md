bash import directive, like in Golang.

# Usage

```bash
source "$(dirname "${BASH_SOURCE[0]}")"/vendors/github.com/reconquest/import.bash/import.bash

import:source "path/to/any/lib.bash"
```

# Example

```bash
import:source "github.com/reconquest/opts"
import:source "github.com/reconquest/types"
```
