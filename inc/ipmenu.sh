function ipmenu()
{
    menu "IP" "Select task" \
        "1" "Use DHCP on IF" \
        "2" "Assign static IP" \
        "3" "Flush IP" \
        "4" "Show IPs"
        
        #TODO Remove only one ip from IF
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
    rec sudo $(hns) ip a a $DRET dev ${RET}
    rec sudo $(hns) ip l s $RET up
}

function IP_3()
{
    ifsmenu || return
    local intf=$RET
    rec sudo $(hns) ip a f $intf
}

function IP_4()
{
    sudo $(hns) ip -c a | less -cR
}
