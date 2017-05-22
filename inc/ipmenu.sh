function ipmenu()
{
    menu "IP" "Select task" \
        "1" "Use DHCP on IF" \
        "2" "Assign static IP" \
        "3" "Flush IP" \
        "4" "Show IPs"
        
        #TODO Remove only one ip from IF
}

function getip()
{
    local if=$1
    tmux list-windows | cut -d ' ' -f 2 | grep $if &> /dev/null
    if [ $? -eq 0 ] ; then
        local cmd="split -t"
    else
        local cmd="new-window -n"
    fi
    tmux $cmd $if $horiz "sudo $(hns) dhclient -i ${if} -d -df ${TEMPDIR}/${if}.df -pf ${TEMPDIR}/${if}.pf -lf ${TEMPDIR}/${if}.lf ; read"
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
    ifsmenu || return
    local intf=$RET
    dia --inputbox "Provide address" 0 0 || return
    sudo $(hns) ip a a $DRET dev ${RET}
    sudo $(hns) ip l s $RET up
}

function IP_3()
{
    ifsmenu || return
    local intf=$RET
    sudo $(hns) ip a f $intf
}

function IP_4()
{
    sudo $(hns) ip -c a | less -cR
}
