#!/bin/bash
HHVM_PATH=${HHVM_PATH:-/git/hhvm}
git clone --depth 1 https://github.com/facebook/hhvm.git ${HHVM_PATH}
pushd ${HHVM_PATH}
git checkout -b arm64
#git fetch origin pull/7206/head:sunil-sk-pr7206
#git cherry-pick sunil-sk-pr7206 || git cherry-pick --abort
#git fetch origin pull/7218/head:lpathy-pr7218
#git cherry-pick lpathy-pr7218 || git cherry-pick --abort
#git fetch origin pull/7226/head:sunil-sk-pr7226
#git cherry-pick sunil-sk-pr7226 || git cherry-pick --abort
echo 'target_link_libraries(hhvm "-Wl,--no-fix-cortex-a53-843419")' >> hphp/hhvm/CMakeLists.txt
git commit -m 'gold 843419 internal error workaround' hphp/hhvm/CMakeLists.txt
git submodule update --init --recursive
pushd third-party/folly/src/
git checkout -b arm64
#git fetch origin pull/429/head:lpathy-pr429
#git cherry-pick lpathy-pr429 || git cherry-pick --abort
#git fetch origin pull/430/head:zhangkehong2brad-pr430
#git cherry-pick zhangkehong2brad-pr430 || git cherry-pick --abort
git fetch origin pull/456/head:guoxiao-pr456
git cherry-pick guoxiao-pr456 || git cherry-pick --abort
popd # third-party/folly/src/
pushd third-party/mcrouter/src/
git checkout -b arm64
git fetch origin pull/134/head:zhangkehong2brad-pr134
git cherry-pick zhangkehong2brad-pr134 || git cherry-pick --abort
popd # third-party/mcrouter/src/
