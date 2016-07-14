#!/bin/sh
BASEPATH=`dirname $0`
LOGPATH=${BASEPATH}/static/logs
export LOGPATH

WEBSOCKETD=${BASEPATH}/websocketd
WS_DIR=${BASEPATH}/scripts
WS_STATICDIR=${BASEPATH}/static

${WEBSOCKETD} --port=13579 --passenv=LOGPATH --dir=${WS_DIR} --staticdir=${WS_STATICDIR}
