function CM_1()
{
    #dia --inputbox "Test" 0 0
    #ifsmenu
    connectmenu
}

function CM_2()
{
    nsmenu
}

function CM_3()
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

function CM_9()
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
        "1" "Connect to the network" \
        "2" "Handle namespaces" \
        "3" "VLANs" \
        "4" " - Bridge" \
        "5" "IP" \
        "6" "VPN" \
        "7" " - Routing" \
        "8" " - Tap" \
        "9" "Record" \
        "e" "Exit"

    if [ "$DRET" == "e" ] ; then
        return -1
    else
        return 0
    fi
}
