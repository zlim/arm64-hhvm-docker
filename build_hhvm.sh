#!/bin/bash
CMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE:-Release}
MAKE="make -j `nproc`"
EXTRA_CMAKE_FLAGS="-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} -DENABLE_SPLIT_DWARF=True"
echo "========== `date`"
cmake ${EXTRA_CMAKE_FLAGS} -DMYSQL_UNIX_SOCK_ADDR=/var/run/mysqld/mysqld.sock .
echo "========== `date`"
${MAKE}
echo "========== `date`"
