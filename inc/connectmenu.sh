function connectmenu()
{
    menu "CCM" "Select connection" \
        "1" "Ethernet" \
        "2" "Ethernet Office" \
        "3" "Known WIFI" \
        "4" "New WIFI"
}

function reset_connections()
{
    sudo killall dhclient
    sudo killall wpa_supplicant

    sudo ip l s ${DEF_LAN_DEV} down
    sudo ip l s ${DEF_LAN_DEV} name eth0
    sudo ip l s eth0 up
    sudo ip a f dev eth0

    sudo rfkill unblock all
    sudo ip l s ${DEF_LAN_DEV} down
    sudo ip l s ${DEF_WLAN_DEV} name wifi
    sudo ip l s wifi up
    sudo ip a f dev wifi

    sudo ip l d office
    sudo ip l d test_wan
    sudo ip l d test_lan
    sudo ip l d rpi_ctrl
}

function getip()
{
    local if=$1
    tmux split -t "CM.0" "sudo dhclient -i ${if} -d"
    tmux last-pane
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

function CCM_3()
{
#WIFI
    echo
}

function CCM_4()
{
#NEW Wifi
    echo
}
