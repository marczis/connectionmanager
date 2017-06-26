function brmenu()
{
    menu "BR" "Select a task" \
        "a" "Add a bridge" \
        "i" "Add interface to bridge" \
        "r" "Remove interface from bridge" \
        "d" "Remove bridge" \
        "s" "Show overview"
}

function BR_a()
{
    dia --inputbox "Please provide a name" 0 0 || return -1
    local brname=$DRET
    rec sudo $(hns) ip l a name $brname type bridge 
}

function BR_i()
{
    ifsmenu || return -1
    local intf=$RET
    ifsmenu "" "bridge" || return -1 
    local br=$RET
    rec sudo $(hns) ip link set dev $intf master $br
}

function BR_r()
{
    ifsmenu "" "bridge_slave" || return -1
    local intf=$RET
    rec sudo $(hns) ip link set dev $intf nomaster 
}

function BR_d()
{
    removeif "bridge"
}

function BR_s()
{    
    clear
    {
    brctl show
    } | less -R
}
