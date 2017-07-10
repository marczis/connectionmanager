function CM_p()
{
    #dia --inputbox "Test" 0 0
    #ifsmenu
    connectmenu
}

function CM_n()
{
    nsmenu
}

function CM_v()
{
    vlanmenu
}

function CM_5()
{
    ipmenu
}
function CM_6()
{
    vpnmenu
}

function CM_t()
{
    vethmenu
}

function CM_r()
{
    recmenu
}

function CM_e()
{
    return -1
}

function CM_w()
{
    #Maybe I should think over the wifi menu, separate assoc / disassoc .. so on.
    #But from usability point of view this is better, for hardcore wifi hack, you may need that... well future feature idea ? :)
    wifimenu
}

function CM_b()
{
    brmenu
}

function CM_2()
{
    l2menu
}

function CM_8()
{
    tapmenu
}

function CM_c()
{
    tmux split sudo $(hns) $(dirname $0)/inc/ipconsole.sh ${NAMESPACE}
}

function mainmenu()
{
    menu "CM" "Connection Manager [$NAMESPACE]" \
        "p" "Profiles" \
        "2" "Interface" \
        "n" "Handle namespaces" \
        "v" "VLANs" \
        "b" "Bridge" \
        "w" "Wifi" \
        "5" "IP" \
        "6" "VPN" \
        "7" " - Routing" \
        "8" "Tap" \
        "t" "Veth pair" \
        "c" "ip console" \
        "r" "Record profile" \
        "e" "Exit"

    if [ "$DRET" == "e" ] ; then
        return -1
    else
        return 0
    fi
}
