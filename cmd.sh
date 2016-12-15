#!/bin/sh

__ScriptVersion="1"

#===  FUNCTION  ================================================================
#         NAME:  usage
#  DESCRIPTION:  Display usage information.
#===============================================================================
function usage ()
{
    echo "Usage :  $0 [options] COMMAND

    Subcommands:

    setup           Setup new k8s cluster according to group_vars
    stop            Stop cluster according to current hosts
    start           Start/Restart cluster according to current hosts
    clean           Clean previous certs

    Options:
    -h|help         Display this message
    -v|version      Display script version"

}    # ----------  end of function usage  ----------

#-----------------------------------------------------------------------
#  Handle command line arguments
#-----------------------------------------------------------------------

while getopts ":hv" opt
do
  case $opt in

    h|help     )  usage; exit 0   ;;

    v|version  )  echo "$0 -- Version $__ScriptVersion"; exit 0   ;;

    * )  echo -e "\n  Option does not exist : $OPTARG\n"
          usage; exit 1   ;;

  esac    # --- end of case ---
done
shift $(($OPTIND-1))

if [[ "$1" == "" ]]; then
    echo "Missing position parameter: COMMAND" 
    usage
    exit 1
fi

case $1 in
    clean )
        rm -rf ssl/*/_ssl ssl/*/*/_ssl* ssl/*/*/*.json
        exit $? ;;
    setup )
        ansible-playbook -i host setup-kube-cluster.yaml
        exit $? ;;
    stop )
        ansible-playbook -i host stop-kube-cluster.yaml
        exit $? ;;
    start )
        ansible-playbook -i host start-kube-cluster.yaml
        exit $? ;;
esac
