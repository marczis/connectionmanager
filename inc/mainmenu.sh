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


function mainmenu()
{
    menu "CM" "Connection Manager [$NAMESPACE]" \
        "p" "Profiles" \
        "n" "Handle namespaces" \
        "v" "VLANs" \
        "4" " - Bridge" \
        "5" "IP" \
        "6" "VPN" \
        "7" " - Routing" \
        "8" " - Tap" \
        "t" "Veth pair" \
        "r" "Record profile" \
        "e" "Exit"

    if [ "$DRET" == "e" ] ; then
        return -1
    else
        return 0
    fi
}
