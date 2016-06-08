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
        if clone_output=$(git clone \
            --progress --recursive --depth 1 --single-branch \
            "https://$vendor_name" "$base_vendor_dir/$vendor_name" 2>&1 \
                | :import:beautify-clone-output);
        then
            vendor_dir="$base_vendor_dir"
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
                | sed -r 's@\.bash@@g')

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
