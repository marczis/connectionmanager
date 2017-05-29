function connectmenu()
{
    menu "PRO" "Select connection profile" $(\ls $RECDIR/*.cmr | xargs basename | sed 's/\.cmr//' | nl) || return -1
    RET=$(\ls $RECDIR/*.cmr | sed "$DRET!d")
    . $RET    
}

#TODO everything below should go away

#function connectmenu()
#{
#    menu "CCM" "Select connection" \
#        "1" "Ethernet" \
#        "2" "Ethernet Office" \
#        "3" "Known WIFI" \
#        "4" "New WIFI"
#    return $?
#}

function reset_connections()
{
    sudo killall dhclient
    sudo killall wpa_supplicant

    sudo ip l s ${DEF_LAN_DEV} down
    sudo ip l s ${DEF_LAN_DEV} name eth0
    sudo ip l s eth0 up
    sudo ip a f dev eth0

    sudo rfkill unblock all
    sudo ip l s ${DEF_WLAN_DEV} down
    sudo ip l s ${DEF_WLAN_DEV} name wifi
    sudo ip l s wifi up
    sudo ip a f dev wifi

    sudo ip l d office
    sudo ip l d test_wan
    sudo ip l d test_lan
    sudo ip l d rpi_ctrl

    #Workaround for my failing ethernet
    sudo ethtool -K eth0 gso off gro off tso off
}

function CCM_1()
{
    reset_connections
    getip "eth0"
}

function CCM_2()
{
    reset_connections
    sudo ip l a l eth0 name office   type vlan id 10
    sudo ip l a l eth0 name test_wan type vlan id 20
    sudo ip l a l eth0 name test_lan type vlan id 30
    sudo ip l a l eth0 name rpi_ctrl type vlan id 40
    sudo ip l s office up
    sudo ip l s test_wan up
    sudo ip l s test_lan up
    sudo ip l s rpi_ctrl up
    getip "office"
}

