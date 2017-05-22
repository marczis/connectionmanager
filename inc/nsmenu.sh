function nsmenu()
{
    menu "NS" "Select task" \
        "1" "Create namespace" \
        "2" "Remove namespace" \
        "3" "List namespaces" \
        "4" "Add interface into namespace" \
        "5" "Remove interface from namespace" \
        "6" "List interfaces in namespace" \
        "7" "Overview" \
        "8" "Switch namespace"
    return $?
}

function nsselectmenu()
{
    menu "IPNS" "Please select namespace" 0 Default $(sudo ip netns | nl) 2>/dev/null || return -1
    if [ $DRET -eq 0 ] ; then
        RET="Default"
    else 
        RET=$(sudo ip netns | sed "$DRET!d")
    fi
    return $DSTA
}

function NS_1() #Create NS
{ 
    dia --inputbox "Provide name" 0 0 || return
    rec sudo ip netns add $DRET
}

function NS_2() #Remove NS
{
    nsselectmenu || return
    sudo ip netns del "$RET"
}

function NS_3() #List NS
{ 
    clear
    sudo ip -c netns | less -R 
}

function NS_4() #Add if
{
    nsselectmenu || return
    local ns=$RET
    ifsmenu || return
    sudo ip l s $RET down
    sudo iw dev | grep Interface | grep $RET &> /dev/null
    if [ $? -ne 0 ] ; then
        #Ethernet
        sudo ip l s $RET netns $ns
    else
        #Wifi
        echo Pass
        #TODO
    fi
}

function NS_5() #Remove if
{ 
    nsselectmenu || return
    local ns=$RET
    ifsmenu "-netns $ns" || return
    sudo ip -netns $ns l s $RET down
    sudo ip -netns $ns l s $RET netns 1
}

function NS_6() #List if
{
    nsselectmenu || return
    clear
    sudo ip -c -netns $RET l l | less -R
}

function NS_7()
{
    clear
    {
    echo "--- Namespace default ---"
    sudo ip -c l
    for i in $(sudo ip netns) ; do
        echo -e "\n--- Namespace $i ---"
        sudo ip -c -netns $i l
    done
    } | less -R
}

function NS_8()
{
    nsselectmenu || return
    NAMESPACE=$RET 
}
