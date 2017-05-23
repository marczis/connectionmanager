function vlanmenu()
{
    menu "VL" "Select task" \
        "1" "Create VLAN" \
        "2" "Delete VLAN"
}

function VL_1() { #Create VLAN
    ifsmenu || return
    local intf=$RET
    dia --inputbox "Provide name for the new IF" 0 0 || return
    local newif=$DRET
    dia --inputbox "Provide VLAN ID" 0 0 || return 
    local vlan=$DRET
    sudo $(hns) ip l a l $intf name $newif type vlan id $vlan 
}

function VL_2() { #Delete VLAN
    removeif
}
#This should be NS relative feature !
