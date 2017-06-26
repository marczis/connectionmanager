function recmenu()
{
    menu "REC" "Select task" \
        "1" "Start recording" \
        "2" "Stop recording"
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
    tmux split tail -f $RECDIR/$REC
    RECPID=$!
    tmux last-pane
}

function REC_2()
{
    REC=""
    kill $(ps ax | grep "tail -f $RECDIR/$REC" | cut -d ' ' -f 1)
    tmux refresh
}
