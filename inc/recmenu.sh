function recmenu()
{
    menu "REC" "Select task" \
        "1" "Start recording" \
        "2" "Stop recording" \
        "3" "Playback"
        #Should be playback here ?
        #A delete recording would be nice 
}

function rec()
{
    if [ "$REC" != "" ] ; then
        #Do record function call
        echo "$@" >> $RECDIR/$REC
    fi
    $@
}

function REC_1() 
{
    dia --inputbox "Enter title" 0 0 || return
    REC="$DRET.cmr"
}

function REC_2()
{
    REC=""
}

function REC_3()
{
    menu "RECFILE" "Select recording" $(\ls ${RECDIR}/*.cmr | xargs basename | nl) || return -1
    RET=$(\ls ${RECDIR}/*.cmr | sed "$DRET!d")
    source $RET 
}
