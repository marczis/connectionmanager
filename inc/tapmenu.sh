function tapmenu()
{
    menu "TAP" "Select a task" \
        "a" "Add tap IF" \
        "d" "Delete tap IF"
}

function TAP_a()
{
    dia --inputbox "Please provide a name" 0 0 || return -1
    local tapname=$DRET
    rec sudo $(hns) ip tuntap add mode tap $tapname
}

function TAP_d()
{
    removeif "tun"
}
