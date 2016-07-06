#!/bin/bash
echo "========== `date`"
make clean
echo "========== `date`"
find $(HHVM_PATH) -name CMakeCache.txt -delete
echo "========== `date`"
