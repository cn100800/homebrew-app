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
    nohup $cmd >/dev/null 2>&1 &
    if [[ $? -ne 0 ]]; then
        printf -- "faild"
    fi
    return 0
}

stop(){
    pid=$(ps -aux | grep -v grep | grep "$cmd")
    if [[ $? -ne 0 ]]; then
        printf -- "pid faild"
    fi
    kill -9 pid
    if [[ $? -ne 0 ]]; then
        printf -- "kill faild"
    fi
    return 0
}

restart(){
    stop && start
}

if [[ $2 != "" ]]; then
    cmd=$(cat $CONF_FILE | awk -v line=$2 -F":" 'NR==line{printf $0}')
fi

case $1 in
    list   )  list  ;;
    start  )  start $2 ;;
    stop   )  stop  $2 ;;
    restart)  restart $2 ;;
    *) printf -- "Usage: $0 {start|stop|restart|status}\n" ;;
esac
