function import() {
    if [ $# -lt 1 ]; then
        echo first argument should be name to import
    fi 2>&1

    local name=$1
    local base_dir=$(dirname "$(readlink -f "${BASH_SOURCE[1]}")")
    source "$base_dir/vendor/$name.bash/${name##*/}.bash"
}
