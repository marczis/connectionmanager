function vpnmenu()
{
    menu "VPN" "Select VPN Profile" $(\ls -d $VPN_CONF_DIR/* | xargs -i basename {} | nl) || return -1
    RET=$(sudo \ls $VPN_CONF_DIR | sed "$DRET!d")
    tmux split -t "CM.0" "cd $VPN_CONF_DIR/$RET && sudo openvpn *.ovpn"
}
