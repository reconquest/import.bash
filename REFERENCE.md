
* [import:source()](#importsource)
* [import:path:get()](#importpathget)
* [import:path:append()](#importpathappend)
* [import:path:prepend()](#importpathprepend)
* [import:include()](#importinclude)


## import:source()

Sources specified module from vendors dir.

#### Example

```bash
import:source "github.com/reconquest/tests.sh"
```

### Arguments

* **$1** (string): Module name to import.

### Output on stdout

* ? Whatever sourced module outputs.

### Exit codes

* ? Whatever sourced module returns.

## import:path:get()

Returns used IMPORTPATH.

IMPORTPATH is used for looking for vendors while importing.

### Output on stdout

* Paths, separated by colon (:).

_Function has no arguments._

## import:path:append()

Appends given argument to the IMPORTPATH.

All further imports will look for vendors in the specified directories.

### Arguments

* **$1** (string): Path to append.

## import:path:prepend()

Prepends given argument to the IMPORTPATH.

All further imports will look for vendors in the specified directories.

### Arguments

* **$1** (string): Path to prepend.

## import:include()

Sources relative script file.

#### Example

```bash
import:include options.sh
```

### Arguments

* **$1** (string): Script name to source.

### Output on stdout

* ? Whatever sourced script outputs.

### Exit codes

* ? Whatever sourced script returns.

