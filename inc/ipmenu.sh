function ipmenu()
{
    menu "IP" "Select task" \
        "1" "Use DHCP on IF" \
        "2" "Assign static IP" \
        "3" "Flush IP"
        
        #TODO Remove only one ip from IF
}

function getip()
{
    local if=$1
    if [ "$NAMESPACE" != "Default" ] ; then
        local netns="ip netns exec $NAMESPACE"  
    fi
    tmux list-windows | cut -d ' ' -f 2 | grep $if &> /dev/null
    if [ $? -eq 0 ] ; then
        local cmd="split -t"
    else
        local cmd="new-window -n"
    fi
    tmux $cmd $if $horiz "sudo $netns dhclient -i ${if} -d -df ${TEMPDIR}/${if}.df -pf ${TEMPDIR}/${if}.pf -lf ${TEMPDIR}/${if}.lf ; read"
    tmux last-window
}

function IP_1()
{   
    ifsmenu || return
    local intf=$RET
    getip $intf $intf
}

function IP_2()
{
    echo
}

function IP_3()
{
    echo
}
