function dia()
{
    exec 3>&1
    DRET=$(dialog "$@" 2>&1 1>&3)
    DSTA=$?
    exec 3>&-
}

function menu()
{
    local pref=$1
    local title=$2
    shift 2
    dia --menu "$title" 0 100 100 "$@"
    if [ $DSTA -eq 0 ] ; then
        ${pref}_${DRET}
    else
        return $DSTA
    fi
}

