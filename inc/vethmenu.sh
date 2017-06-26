function vethmenu()
{
    menu "VETH" "Select task" \
        "a" "Add VETH Pair" \
        "d" "Delete VETH Pair"
}

function VETH_a()
{
    dia --inputbox "Provide veth name" 0 0 || return
    local name=$DRET
    rec sudo $(hns) ip l a ${name} type veth peer name ${name}_peer
}

function VETH_d()
{
    removeif "veth" || return -1
}
