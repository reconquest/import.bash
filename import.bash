# @description Sources specified module from vendors dir.
#
# @example
#   import "github.com/reconquest/tests.sh"
#
# @arg $1 string Module name to import.
# @stdout ? Whatever sourced module outputs.
# @exitcode ? Whatever sourced module returns.
function import() {
    if [ $# -lt 1 ]; then
        echo first argument should be name to import
        return 1
    fi 2>&1

    local name=$1
    local base_dir=$(dirname "$(readlink -f "${BASH_SOURCE[1]}")")

    local git_root_dir
    if git_root_dir=$(
        cd "$base_dir" && git rev-parse --show-toplevel 2>/dev/null)
    then
        base_dir="$git_root_dir"
    fi

    if ! grep -qP '\.bash$|\.sh$' <<< "$name"; then
        name="$name.bash"
    fi

    source "$base_dir/vendor/$name/${name##*/}"
}

# @description Sources relative script file.
#
# @example
#   include options.sh
#
# @arg $1 string Script name to source.
# @stdout ? Whatever sourced script outputs.
# @exitcode ? Whatever sourced script returns.
function include() {
    if [ $# -lt 1 ]; then
        echo first argument should be script name to include
        return 1
    fi 2>&1

    local name=$1
    local base_dir=$(dirname "$(readlink -f "${BASH_SOURCE[1]}")")

    source "$base_dir/$name"
}
