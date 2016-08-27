#!/bin/bash
HHVM_PATH=${HHVM_PATH:-/git/hhvm}
pushd ${HHVM_PATH}
echo "========== `date`"
make clean
echo "========== `date`"
find . -name CMakeCache.txt -delete
echo "========== `date`"
popd # ${HHVM_PATH}
