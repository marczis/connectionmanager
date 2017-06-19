function l2menu()
{
    menu "L2" "Select task" \
        "u" "Bring IF up" \
        "d" "Bring IF down" \
        "r" "Rename IF"
}

function L2_u()
{
    ifsmenu || return
    local intf=$RET
    rec sudo $(hns) ip l s $intf up
}

function L2_d()
{
    ifsmenu || return
    local intf=$RET
    rec sudo $(hns) ip l s $intf down
}

function L2_r()
{
    ifsmenu || return
    local intf=$RET
    dia --inputbox "Provide new  name" 0 0 || return
    rec sudo $(hns) ip l s $intf name ${RET}
}
