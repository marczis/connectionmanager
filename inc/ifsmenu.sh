function ifsmenu()
{
    if [ "$1" == "" -a  "$NAMESPACE" != "Default" ] ; then
        local netns="-netns $NAMESPACE"
    else
        local netns=$1
    fi

    if [ "$2" != "" ] ; then
        local type="type $2"
    else
        local type=""
    fi

    menu "IFS" "Select Interface" $(sudo \ip $netns -br l sh $type | cut -d ' ' -f 1 | nl) || return -1
    RET=$(sudo \ip $netns -br l sh $type | cut -d ' ' -f 1 | cut -d '@' -f 1 | sed "$DRET!d")
}

function wifiifsmenu()
{
    menu "WIFS" "Select Interface" $(sudo $(hns) \iw dev | grep Interface | cut -d ' ' -f 2 | nl) || return -1
    RET=$(sudo $(hns) \iw dev | grep Interface | cut -d ' ' -f 2 | sed "$DRET!d")
}
