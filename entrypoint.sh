#!/bin/bash
set -e
#print statements as they are executed
[[ -n $DEBUG_ENTRYPOINT ]] && set -x
source ${RUNTIME_DIR}/functions


case ${1} in
  app:init|app:start)
    map_uidgid

    case ${1} in
      app:start)
        /entrypoint.sh mongod
        ;;
    esac
    ;;
  app:help)
    echo "Available options:"
    echo " app:start        - Starts the mongodb server (default)"
    echo " app:init         - Initialize the mongodb server (e.g. map user IDs)"
    echo " [command]        - Execute the specified command, eg. bash."
    ;;
  *)
    exec "$@"
    ;;
esac

exit 0
