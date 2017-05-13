function ssidmenu()
{
    local tmp=$(mktemp)
    for in in $(seq 1 10) ; do
        sudo iw dev wifi scan | grep SSID | cut -d ':' -f 2 | sed 's/^\s*//' | grep -v '\x00' > $tmp
        if [ $? -eq 0 ] ; then
            break
        fi
        sleep 2
    done
    menu "SSIDS" "Please select the SSID" $(cat $tmp | sed 's/ /_/g' | nl) 2>/dev/null
    RET=$(sed "$DRET!d" $tmp)
    echo $RET
    rm $tmp
}
