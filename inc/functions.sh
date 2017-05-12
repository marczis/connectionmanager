function dia()
{
    exec 3>&1
    DRET=$(dialog "$@" 2>&1 1>&3)
    exec 3>&-
}

function menu()
{
    local title=$1
    shift 1
    dia --menu "$title" 0 100 100 "$@"
    ${title}_${DRET}
}

