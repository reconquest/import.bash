:import:declare() {

# @description Sources specified module from vendors dir.
#
# @example
#   import:source "github.com/reconquest/tests.sh"
#
# @arg $1 string Module name to import.
# @stdout ? Whatever sourced module outputs.
# @exitcode ? Whatever sourced module returns.
import:source() {
    :import:source "${@}"
}

:import:source() {
    if [ $# -lt 1 ]; then
        echo first argument should be name to import >&2
        return 1
    fi 2>&1

    local vendor_name="$1"
    local base_dir=$(dirname "$(readlink -f "${BASH_SOURCE[2]}")")

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

    local _basic_vendor=$(dirname "$(readlink -f ${BASH_SOURCE[1]})")
    _basic_vendor=$(dirname "$(dirname "$(dirname "$_basic_vendor")")")

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
        if [[ -f "$vendor_dir/$vendor_name/$(basename $vendor_name)" ]]; then
            found=true
            break
        fi
    done < <(command tr ':' '\n' <<< "$IMPORTPATH")

    if ! $found; then
        if clone_output=$(git clone \
            --local --progress --single-branch \
            "https://$vendor_name" "$_basic_vendor/$vendor_name" 2>&1 \
                | :import:beautify-clone-output ; exit ${PIPESTATUS[0]});
        then
            vendor_dir="$_basic_vendor"
            found=true
        else
            echo "can't clone $vendor_name" >&2
            echo "$clone_output" >&2
            return 1
        fi
    fi

    source "$vendor_dir/$vendor_name/${vendor_name##*/}"

    :import:declare
}

# @description Returns used IMPORTPATH.
#
# IMPORTPATH is used for looking for vendors while importing.
#
# @stdout Paths, separated by colon (:).
# @noargs
import:path:get() {
    echo "$IMPORTPATH"
}

# @description Appends given argument to the IMPORTPATH.
#
# All further imports will look for vendors in the specified directories.
#
# @arg $1 string Path to append.
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


# @description Prepends given argument to the IMPORTPATH.
#
# All further imports will look for vendors in the specified directories.
#
# @arg $1 string Path to prepend.
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


:import:include() {
    if [ $# -lt 1 ]; then
        echo first argument should be script name to include >&2
        return 1
    fi 2>&1

    local name=$1
    local base_dir=$(dirname "$(readlink -f "${BASH_SOURCE[2]}")")

    source "$base_dir/$name"

    :import:declare
}

:import:beautify-clone-output() {
    local previous=""
    local source=""
    local pwd="$(pwd)"

    while read line; do
        printf "%s\n" "$line" >&3

        if grep -Pq "^Cloning into" <<< "$line"; then
            previous="$source"

            source=$(sed -r "s/Cloning into '(.*)'.../\\1/" <<< "$line" \
                | cut -b$(wc -c <<< "$pwd")- \
                | sed -r 's@vendor/@@g' \
                | sed -r 's@\.bash@@g' \
                | sed -r 's@^/@@g' )

            if [ ! "$previous" ]; then
                printf "%s\n" "$source"
                continue
            fi

            if [ "$(grep -bF "$previous" <<< "$source" | cut -f1 -d:)" = "0" ]
            then
                submodule=$(cut -b$(wc -c <<< "$previous/")- <<< "$source")

                printf "%s\n" "submodule: $submodule"
            else
                printf "%s\n" "$source"
            fi
        fi
    done 3>&1 1>&2
}

# @description Sources relative script file.
#
# @example
#   import:include options.sh
#
# @arg $1 string Script name to source.
# @stdout ? Whatever sourced script outputs.
# @exitcode ? Whatever sourced script returns.
import:include() {
    :import:include "${@}"
}

# back compatibility

include() { :import:include "${@}"; }
import()  { :import:source "${@}"; }

} # end of :import:declare

:import:declare
