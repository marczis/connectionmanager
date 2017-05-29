function wifimenu()
{
    menu "WIFI" "Select a task" "c" "Connect to known network" "n" "Connect to new network"
}

function wificonfigmenu()
{
    menu "KWF" "Select an SSID" $(\ls $WIFI_CONF_DIR/*.conf | xargs -i basename {} | sed 's/\.conf//' | nl) || return
    local r=$?
    RET=$(\ls $WIFI_CONF_DIR/*.conf | sed "$DRET!d") 
    return $r
}

function WIFI_c()
{
    ifsmenu
    local intf=$RET
    wificonfigmenu 
    local conf=$RET
    
    connect_wifi "$intf" "$conf"
}

function WIFI_n()
{
    ifsmenu
    local intf=$RET
    ssidmenu "$intf"
    local ssid="$RET" 
    local conf="${WIFI_CONF_DIR}/${ssid}.conf"
    while [ 1 ] ; do
        dia --inputbox "Please provide password" 0 0 || return -1
        echo $DRET | wpa_passphrase $ssid > $conf
        if [ $? -eq 0 ] ; then
            break
        fi
        clear
        cat $conf
        read
    done
    connect_wifi "$intf" "$conf"
}
