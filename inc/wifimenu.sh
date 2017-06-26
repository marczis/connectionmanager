function wifimenu()
{
    menu "WIFI" "Select a task" \
        "c" "Connect to known network"\
        "n" " - Connect to new network"\
        "m" "Setup OTA capture"
}

function wificonfigmenu()
{
    menu "KWF" "Select an SSID" $(\ls $WIFI_CONF_DIR/*.conf | xargs -i basename {} | sed 's/\.conf//' | nl) || return
    local r=$?
    RET=$(\ls $WIFI_CONF_DIR/*.conf | sed "$DRET!d") 
    return $r
}

function wifibandmenu()
{
    menu "WB" "Select an band" 5 "5 Ghz" 2 "2.4 Ghz" || return
    local r=$?
    RET=$DRET
    return $r
}

function wifi5gchmenu()
{
    menu "WC" "Select channel" 36 "36" 149 "149" || return
    local r=$?
    RET=$DRET
    return $r
}

function WIFI_c()
{
    wifiifsmenu || return -1
    local intf=$RET
    wificonfigmenu || return -1
    local conf=$RET
    
    connect_wifi "$intf" "$conf"
}

function WIFI_n()
{
    wifiifsmenu || return -1
    local intf=$RET
    ssidmenu "$intf" || return -1
    local ssid="$RET" 
    local conf="${WIFI_CONF_DIR}/${ssid}.conf"
    while [ 1 ] ; do
        dia --inputbox "Please provide password" 0 0 || return -1
        echo $DRET | wpa_passphrase $ssid > $conf
        if [ $? -eq 0 ] ; then
            break
        fi
        clear
        echo $conf
        read
    done
    connect_wifi "$intf" "$conf"
}

function WIFI_m()
{
    wifiifsmenu || return -1
    local intf=$RET
    wifibandmenu || return -1
    local band=$RET
    
    if [ "$band" == "5" ] ; then
        wifi5gchmenu || return -1
        local ch=$RET


        local lf=0
        local mf=0

        case $ch in
            36)
                lf=5180
                mf=5210 
                ;;
            149)
                lf=5745
                mf=5775
                ;;
        esac
        rec sudo $(hns) ip l s $intf down
        rec sudo $(hns) ip l s $intf up
        rec sudo $(hns) iwconfig $intf mode monitor
        rec sudo $(hns) iw $intf set freq $lf 80 $mf  #TODO BW should be selectable too ! 
        local file="${WIFI_OTA_DIR}/ota_ch${ch}_80mhz.$(date +%d-%m-%Y_%H%M%S).pcap"
        rec  $(tmuxx) "OTA-$intf" "tshark -i $intf -w $file"
    fi
}
