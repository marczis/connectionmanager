function ifsmenu()
{
    if [ "$1" == "" -a  "$NAMESPACE" != "Default" ] ; then
        local netns="-netns $NAMESPACE"
    else
        local netns=$1
    fi
    menu "IFS" "Select Interface" $(sudo \ip $netns -br l | cut -d ' ' -f 1 | nl) || return -1
    RET=$(sudo \ip $netns -br l | cut -d ' ' -f 1 | cut -d '@' -f 1 | sed "$DRET!d")
}
