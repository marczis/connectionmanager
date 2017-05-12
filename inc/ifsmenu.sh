function ifsmenu()
{
    menu "IFS" "Select Interface" $(\ip -br l | cut -d ' ' -f 1 | nl)
    RET=$(\ip -br l | cut -d ' ' -f 1 | sed "$DRET!d")
}
