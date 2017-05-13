function wifimenu()
{
    menu "KWF" "Select an SSID" $(\ls $WIFI_CONF_DIR/*.conf | xargs -i basename {} | sed 's/\.conf//' | nl) 2>/dev/null
    RET=$(\ls $WIFI_CONF_DIR/*.conf | sed "$DRET!d") 
}
