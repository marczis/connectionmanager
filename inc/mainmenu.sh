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

function mainmenu()
{
    menu "CM" "Connection Manager [$NAMESPACE]" \
        "p" "Profiles" \
        "n" "Handle namespaces" \
        "v" "VLANs" \
        "4" " - Bridge" \
        "w" "Wifi" \
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
