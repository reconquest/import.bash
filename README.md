bash import directive

# Usage

```
local _base_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source "$_base_dir/vendors/github.com/reconquest/import.bash/import.bash"

import "path/to/any/lib.bash"
```

# Example
```
import "github.com/reconquest/opts.bash"
import "github.com/reconquest/types.bash"
```
