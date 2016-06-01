# @description Sources specified module from vendors dir.
#
# @example
#   import "github.com/reconquest/tests.sh"
#
# @arg $1 string Module name to import.
# @stdout ? Whatever sourced module outputs.
# @exitcode ? Whatever sourced module returns.
import() {
    if [ $# -lt 1 ]; then
        echo first argument should be name to import >&2
        return 1
    fi 2>&1

    local vendor_name="$1"
    local base_dir=$(dirname "$(readlink -f "${BASH_SOURCE[1]}")")

    local git_root_dir=""
    if git_root_dir=$(
        builtin cd "$base_dir" \
            && git rev-parse --show-toplevel 2>/dev/null
    ); then
        :
    fi

    if ! grep -qP '\.bash$|\.sh$' <<< "$vendor_name"; then
        vendor_name="$vendor_name.bash"
    fi

    local base_vendor_dir="$base_dir/vendor"
    if [[ "$git_root_dir" ]]; then
        if [[ -d "$git_root_dir/vendor" && ! -d "$base_dir/vendor" ]]; then
            base_vendor_dir="$git_root_dir/vendor"
        fi
    fi

    import:path:prepend "$base_vendor_dir"

    local found=false
    local vendor_dir=""
    while read -r vendor_dir; do
        if [[ -d "$vendor_dir/$vendor_name" ]]; then
            found=true
            break
        fi
    done < <(/bin/tr ':' '\n' <<< "$IMPORTPATH")

    if ! $found; then
        if git clone --recursive --depth 1 --single-branch \
            "https://$vendor_name" "$base_vendor_dir/$vendor_name";
        then
            vendor_dir="$base_vendor_dir"
            found=true
        else
            echo "can't clone $vendor_name (not found $IMPORTPATH)" >&2
            return 1
        fi
    fi

    source "$vendor_dir/$vendor_name/${vendor_name##*/}"
}

import:path:get() {
    echo "$IMPORTPATH"
}

import:path:append() {
    while [[ $# -ne 0 ]]; do
        if [[ ! -v IMPORTPATH ]]; then
            IMPORTPATH="$1"
        else
            IMPORTPATH="${IMPORTPATH}:$1"
        fi

        shift
    done
}

import:path:prepend() {
    while [[ $# -ne 0 ]]; do
        if [[ ! -v IMPORTPATH ]]; then
            IMPORTPATH="$1"
        else
            IMPORTPATH="$1:${IMPORTPATH}"
        fi

        shift
    done
}


# @description Sources relative script file.
#
# @example
#   include options.sh
#
# @arg $1 string Script name to source.
# @stdout ? Whatever sourced script outputs.
# @exitcode ? Whatever sourced script returns.
include() {
    if [ $# -lt 1 ]; then
        echo first argument should be script name to include >&2
        return 1
    fi 2>&1

    local name=$1
    local base_dir=$(dirname "$(readlink -f "${BASH_SOURCE[1]}")")

    source "$base_dir/$name"
}
