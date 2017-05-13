function CM_1()
{
    #dia --inputbox "Test" 0 0
    #ifsmenu
    connectmenu
}

function CM_2()
{
    nsmenu
}

function CM_e()
{
    return -1
}

function mainmenu()
{
    menu "CM" "Connection Manager" \
        "1" "Connect to the network" \
        "2" "Handle namespaces" \
        "e" "Exit"
}
