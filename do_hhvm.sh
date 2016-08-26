#!/bin/bash

HHVM_REV=`date +%Y%m%d-%H%M%S`
export HHVM_REV

LOGS_PATH=www/static/logs
mkdir -p ${LOGS_PATH}

HHVM_PATH=/git/hhvm-${HHVM_REV}
HHVM_LOG=${LOGS_PATH}/make-hhvm-${HHVM_REV}.log
HHVM_DEBUG_LOG=${LOGS_PATH}/make-hhvm-debug-${HHVM_REV}.log
HPHP_TEST=all

make HHVM_PATH=${HHVM_PATH} HPHP_TEST=${HPHP_TEST} \
	get summary hhvm test 2>&1 | tee ${HHVM_LOG}

make HHVM_PATH=${HHVM_PATH} HPHP_TEST=${HPHP_TEST} CMAKE_BUILD_TYPE=Debug \
	clean summary hhvm test 2>&1 | tee ${HHVM_DEBUG_LOG}

