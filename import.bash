function import() {
    if [ $# -lt 1 ]; then
        echo first argument should be name to import
    fi 2>&1

    local name=$1


    local base_dir=$(cd "$(dirname "${BASH_SOURCE[1]}")" && pwd)
    source "$base_dir/vendor/$name/${name#*/}.bash"
}
