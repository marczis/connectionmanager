function collect_wifi_info()
{
    local intf="$1"
    local tmp=$(mktemp)
    for i in $(seq 1 10) ; do
        sudo iw dev $intf scan > $tmp
        if [ $? -ne 0 ] ; then
            echo "failed, retry"
            sleep 2
            continue
        fi
        break
    done
    local marks=$(sed -n '/^BSS/=' ${tmp})
    local prev=1       
    local cnt=0

    RET=""

    #Here comes an ugly hack for sure ;)
    for i in ${marks} 999999 ; do #MEh, learn sed finally, and get rid of this 999999 hack
        if [ $cnt -eq 0 ] ; then
            cnt=1
            prev=$i
            continue
        fi

        local tmp2=$(mktemp)
        sed -n "${prev},$((i-1))p" ${tmp} > $tmp2
       
        local ssid=$(grep "SSID" ${tmp2} | cut -d ':' -f 2 | sed 's/ //g') #There are spaces out there in the SSIDs... meh. Do something about that... later...
        local auth=$(grep "Authentication" ${tmp2} | cut -d ':' -f 2)
       
        if [ ! -z "${auth}" ] ; then
            echo ${RET} | grep ${ssid} &>/dev/null
            if [ $? -eq 0 ] ; then
                prev=$i
                continue
            fi
            RET+="$ssid\n"
        fi
        
        rm ${tmp2}   
        prev=$i
    done
    rm ${tmp}
}

function ssidmenu()
{
    local intf="$1"
    collect_wifi_info "$intf"
    local s=$(echo -e $RET | nl)
    menu "SSIDS" "Please select the SSID" $s 2>/dev/null
    RET=$(echo -e $RET | sed "$DRET!d") 
}
