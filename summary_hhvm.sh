#!/bin/bash
HHVM_PATH=${HHVM_PATH:-/git/hhvm}
pushd ${HHVM_PATH}
echo "[hhvm]"
git log -10 --boundary --oneline `git show-branch --merge-base`..
echo "[hhvm-submodules]"
git submodule status --recursive
git submodule foreach git submodule summary
popd # ${HHVM_PATH}
