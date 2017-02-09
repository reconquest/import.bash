# @description Sources relative script file.
#
# @example
#   import:include options.sh
#
# @arg $1 string Script name to source.
# @stdout ? Whatever sourced script outputs.
# @exitcode ? Whatever sourced script returns.
import:include() {
    if [ $# -lt 1 ]; then
        echo first argument should be script name to include >&2
        return 1
    fi 2>&1

    local name=$1
    local sourcer_dir=$(dirname "$(readlink -f "${BASH_SOURCE[1]}")")

    source "$sourcer_dir/$name"
}

# @description Sources specified module from vendors dir.
#
# @example
#   import:use "github.com/reconquest/tests.sh"
#
# @arg $1 string Module name to import.
# @stdout ? Whatever sourced module outputs.
# @exitcode ? Whatever sourced module returns.
import:use() {
    if [ $# -lt 1 ]; then
        echo first argument should be name to import >&2
        return 1
    fi 2>&1

    local vendor_name="$1"

    local sourcer_dir=$(dirname "$(readlink -f "${BASH_SOURCE[1]}")")
    local local_git_dir=$(:import:git:print-top-level-dir)
    local project_git_dir=$(:import:git:print-project-dir "$sourcer_dir")
    local vendor_dir
    local base_dir

    for base_dir in "${local_git_dir:-$sourcer_dir}" "$project_git_dir"; do
        vendor_dir=$base_dir/vendor/$vendor_name

        if [[ -f "$vendor_dir/${vendor_name##*/}" ]]; then
            :import:source "$vendor_dir/${vendor_name##*/}"

            return $?
        fi
    done

    if clone_output=$(
        :import:clone "$vendor_name" "$vendor_dir" "$base_dir"
    ); then
        :import:source "$vendor_dir/${vendor_name##*/}"

        return $?
    else
        printf "can't clone '%s'\n%s\n" "$vendor_name" "$clone_output" >&2

        return 1
    fi
}

:import:clone() {
    local vendor_name=$1
    local vendor_dir=$2
    local base_dir=$3

    git clone \
        --local --progress --single-branch \
        "https://$vendor_name" "$vendor_dir" 2>&1 \
            | :import:print-progress "$base_dir"
}

:import:print-progress() {
    local base_dir="$1"

    local previous=""
    local path=""

    while read line; do
        printf "%s\n" "$line" >&3

        if grep -q "^Cloning into" <<< "$line"; then
            previous="$path"

            path=$(
                grep -o "'.*'" <<< "$line" \
                    | tr -d "'"
            )

            path=${path#$base_dir}

            path=$(
                sed -r <<< "$path" \
                    -e 's:vendor/::g' \
                    -e 's:^/::g'
            )

            if [[ "$previous" && "${path#$previous/}" != "$path" ]]; then
                printf "%s\n" "submodule: ${path#$previous/}"
            else
                printf "%s\n" "$path"
            fi
        fi
    done 3>&1 1>&2
}

:import:git:print-top-level-dir() {
    git rev-parse --show-toplevel 2>/dev/null
}

:import:git:print-project-dir() {
    local dir=$1

    cd "$dir"

    {
        printf '%s\n' "$dir"

        while dir=$(:import:git:print-top-level-dir); do
            if [[ ! "$dir" ]]; then
                return
            fi

            printf '%s\n' "$dir"

            cd "$dir/.."
        done
    } | tail -n1
}

:import:source() {
    local file=$1
    local source=$(readlink -f "${BASH_SOURCE[0]}")

    source "$file"
    local exit_code=$?

    # restore original import.bash
    source "$source"

    return "$exit_code"
}

import:source() {
    echo "import:source is deprecated, use import:use instead" >&2
    exit 1
}
