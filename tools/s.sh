#!/bin/bash

CONF_DIR=$HOME/.service/

CONF_FILE=$CONF_DIR/service.conf

mkdir -p $CONF_DIR

if [ ! -f $CONF_FILE ]; then
    touch $CONF_FILE
fi

if [[ $2 != "" ]]; then
    cmd=$(cat $CONF_FILE | awk -v line=$2 -F":" 'NR==line{printf $2}')
    server_name=$(cat $CONF_FILE | awk -v line=$2 -F":" 'NR==line{printf $1}')
fi

list(){
    cat $CONF_FILE | grep -nv "^#"
}

start(){
    echo "$cmd" | grep "start" >/dev/null 2>&1
    if [[ $? -eq 0 ]]; then
        eval $cmd
        if [[ $? -ne 0 ]]; then
            printf -- "faild"
        fi
        return 0
    fi
    nohup $cmd >/dev/null 2>&1 &
    if [[ $? -ne 0 ]]; then
        printf -- "faild"
    fi
    return 0
}

stop(){
    echo "$cmd" | grep "start" >/dev/null 2>&1
    if [[ $? -eq 0 ]]; then
        eval ${cmd//start/stop}
        if [[ $? -ne 0 ]]; then
            printf -- "stop faild. cmd is ${cmd//start/stop}"
        fi
        return 0
    fi
    pid=$(ps -xc | grep $server_name | awk '{printf $1}')
    if [[ $? -ne 0 ]]; then
        printf -- "pid faild"
    fi
    kill -9 $pid
    if [[ $? -ne 0 ]]; then
        printf -- "kill faild"
    fi
    return 0
}

restart(){
    echo "$cmd" | grep "start" >/dev/null 2>&1
    if [[ $? -eq 0 ]]; then
        eval ${cmd//start/restart}
        if [[ $? -ne 0 ]]; then
            printf -- "restart faild . cmd is ${cmd//start/restart}"
        fi
        return 0
    fi

    if [[ stauts -eq 0 ]]; then
        stop
    fi
    start
}

status(){
    ps -xc | grep $server_name
}


case $1 in
    list   )  list  ;;
    start  )  start ;;
    stop   )  stop  ;;
    restart)  restart ;;
    status )  status ;;
    *) printf -- "Usage: $0 {start|stop|restart|status}\n" ;;
esac
