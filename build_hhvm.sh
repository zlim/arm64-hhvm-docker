#!/bin/bash
MAKE="make -j `nproc`"
echo "========== `date`"
cmake -DMYSQL_UNIX_SOCK_ADDR=/var/run/mysqld/mysqld.sock .
echo "========== `date`"
${MAKE}
echo "========== `date`"
