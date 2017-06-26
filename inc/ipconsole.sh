function extrap()
{
    history -w ~/.cm/.ipc_hist
    exit
}
trap extrap INT

history -c
history -r ~/.cm/.ipc_hist
while [ 1 ] ; do
    read -e -p "ip " cmd
    history -s $cmd
    ip -c -br $cmd
    echo
done

