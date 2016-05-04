function import() {
    if [ $# -lt 1 ]; then
        echo first argument should be name to import
    fi 2>&1

    local name=$1

    printf 'XXXXXX import.bash:7: $0: %q\n' $0 >&2
    printf 'XXXXXX import.bash:7: $name: %q\n' $name >&2
    printf 'XXXXXX import.bash:7: ${BASH_SOURCE[@]}: %q\n' ${BASH_SOURCE[@]} >&2

    local base_dir=$(cd "$(dirname "${BASH_SOURCE[1]}")" && pwd)
    source "$base_dir/vendor/$name/${name#*/}.bash"
}
