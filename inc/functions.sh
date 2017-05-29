function dia()
{
    exec 3>&1
    DRET=$(dialog "$@" 2>&1 1>&3)
    DSTA=$?
    exec 3>&-
    return $DSTA
}

function menu()
{
    local pref=$1
    local title=$2
    shift 2
    dia --menu "$title" 0 100 100 "$@"
    if [ $DSTA -eq 0 ] ; then
        type ${pref}_${DRET} &> /dev/null
        if [ $? -eq 0 ] ; then
            ${pref}_${DRET}
            return $?
        fi
        return 0
    else
        return $DSTA
    fi
}

function hns() #as handle netns
{
    if [ "$NAMESPACE" != "Default" ] ; then
        echo ip netns exec $NAMESPACE
    fi
}

function removeif()
{
    #TODO this should have a cool filter feature, so we can use it for remove different type of IFs
    ifsmenu || return
    rec sudo $(hns) ip l d $(echo $RET | cut -d '@' -f 1)
}

function tmuxx()
{
    tmux list-windows | cut -d ' ' -f 2 | grep $if &> /dev/null
    if [ $? -eq 0 ] ; then
        local cmd="split -t"
    else
        local cmd="new-window -n"
    fi
    echo "tmux $cmd"
}

function getip()
{
    local if=$1
    rec $(tmuxx) $if $horiz "sudo $(hns) dhclient -i ${if} -d -df ${TEMPDIR}/${if}.df -pf ${TEMPDIR}/${if}.pf -lf ${TEMPDIR}/${if}.lf"
    rec tmux last-window
}

function connect_wifi()
{
    local intf=$1
    local config=$2
    $(tmuxx) "${intf}" "sudo wpa_supplicant -i ${intf} -c $config -d"
    tmux last-pane
    getip "${intf}"
}

