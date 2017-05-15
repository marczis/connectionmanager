function ifsmenu()
{
    local netns=$1
    menu "IFS" "Select Interface" $(sudo \ip $netns -br l | cut -d ' ' -f 1 | nl) || return -1
    RET=$(sudo \ip $netns -br l | cut -d ' ' -f 1 | sed "$DRET!d")
}
