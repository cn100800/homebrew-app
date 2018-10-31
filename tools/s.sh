#!/bin/bash

CONF_DIR=$HOME/.service/
CONF_FILE=$CONF_DIR/service.conf
mkdir -p $CONF_DIR
if [ ! -f $CONF_FILE ]; then
    touch $CONF_FILE
fi

list(){
    cat $CONF_FILE | grep -nv "^#"
}

start(){
    echo "$cmd" | grep "start" >/dev/null 2>&1
    if [[ $? -eq 0 ]]; then
        $cmd
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
        ${cmd//start/stop}
        if [[ $? -ne 0 ]]; then
            printf -- "stop faild. cmd is ${cmd//start/stop}"
        fi
        return 0
    fi
    pid=$(ps -aux | grep -v grep | grep "$cmd" | awk '{printf $2}')
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
        ${cmd//start/restart}
        if [[ $? -ne 0 ]]; then
            printf -- "restart faild . cmd is ${cmd//start/restart}"
        fi
        return 0
    fi
    stop && start
}

status(){
    ps -aux | grep -v grep | grep "$cmd"
}

if [[ $2 != "" ]]; then
    cmd=$(cat $CONF_FILE | awk -v line=$2 -F":" 'NR==line{printf $0}')
fi

case $1 in
    list   )  list  ;;
    start  )  start ;;
    stop   )  stop  ;;
    restart)  restart ;;
    status )  status ;;
    *) printf -- "Usage: $0 {start|stop|restart|status}\n" ;;
esac
