#!/bin/bash

CONF_DIR=$HOME/.service/

CONF_FILE=$CONF_DIR/service.conf

mkdir -p "$CONF_DIR"

if [ ! -f "$CONF_FILE" ]; then
    touch "$CONF_FILE"
fi

if [[ $2 != "" ]]; then
    cmd=$(awk -v line="$2" -F":" 'NR==line{printf $2}' < "$CONF_FILE")
    server_name=$(awk -v line="$2" -F":" 'NR==line{printf $1}' < "$CONF_FILE")
fi

list(){
    grep -nv "^#" < "$CONF_FILE"
}

start(){
    if echo "$cmd" | grep "start" >/dev/null 2>&1 ; then
        if eval "$cmd" ; then
            printf -- "faild"
        fi
        return 0
    fi

    if nohup "$cmd" >/dev/null 2>&1 & then
        printf -- "faild"
    fi
    return 0
}

stop(){
    if echo "$cmd" | grep "start" >/dev/null 2>&1 ; then
        if eval "${cmd//start/stop}" ; then
            printf -- "stop faild. cmd is %s" "${cmd//start/stop}"
        fi
        return 0
    fi

    if pid=$(pgrep "$server_name" | awk '{printf $1}') ; then
        printf -- "pid faild"
    fi
    if kill -9 "$pid" ; then
        printf -- "kill faild"
    fi
    return 0
}

status(){
    pgrep "$server_name"
}

restart(){
    if echo "$cmd" | grep "start" >/dev/null 2>&1 ; then
        if eval "${cmd//start/restart}" ; then
            printf -- "restart faild . cmd is %s" "${cmd//start/restart}"
        fi
        return 0
    fi

    if pgrep "$server_name" ; then
        stop
    fi
    start
}

case $1 in
    list   )  list  ;;
    start  )  start ;;
    stop   )  stop  ;;
    restart)  restart ;;
    status )  status ;;
    *) printf -- "Usage: %s {start|stop|restart|status}\\n" "$0" ;;
esac
