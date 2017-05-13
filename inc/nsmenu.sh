function nsmenu()
{
    menu "NS" "Select task" \
        "1" "Create namespace" \
        "2" "Remove namespace" \
        "3" "List namespaces" \
        "4" "Add interface into namespace" \
        "5" "Remove interface from namespace" \
        "6" "List interfaces in namespace" \
        "7" "Overview"
}

function nsselectmenu()
{
    menu "IPNS" "Please select namespace" $(sudo ip netns | nl) 2>/dev/null
    RET=$(sudo ip netns | sed "$DRET!d")
}

function NS_1() #Create NS
{ 
    dia --inputbox "Provide name" 0 0
    sudo ip netns add $DRET
}

function NS_2() #Remove NS
{
    nsselectmenu
    sudo ip netns del "$RET"
}

function NS_3() #List NS
{ 
    clear
    sudo ip -c netns | less -R 
}

function NS_4() #Add if
{
    nsselectmenu
    local ns=$RET
    ifsmenu
    sudo ip l s $RET down
    sudo ip l s $RET netns $ns
}

function NS_5() #Remove if
{ 
    nsselectmenu
    local ns=$RET
    ifsmenu "-netns $ns"
    sudo ip -netns $ns l s $RET down
    sudo ip -netns $ns l s $RET netns 1
}

function NS_6() #List if
{
    nsselectmenu
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
