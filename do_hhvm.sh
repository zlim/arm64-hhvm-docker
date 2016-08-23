#!/bin/bash

HHVM_REV=`date +%Y%m%d-%H%M%S`
export HHVM_REV

LOGS_PATH=www/static/logs
mkdir -p ${LOGS_PATH}

HHVM_PATH=/git/hhvm-${HHVM_REV}
HHVM_LOG=${LOGS_PATH}/make-hhvm-${HHVM_REV}.log

make HHVM_PATH=${HHVM_PATH} get summary hhvm test 2>&1 | tee ${HHVM_LOG}

