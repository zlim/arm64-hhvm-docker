#!/bin/bash
HHVM_PATH=${HHVM_PATH:-/git/hhvm}
HPHP_TEST=${HPHP_TEST:-all}
PATH=${HHVM_PATH}/hphp/hhvm:${PATH}
pushd ${HHVM_PATH}
hphp/test/run -m interp ${HPHP_TEST}
hphp/test/run -m interp -r ${HPHP_TEST}
hphp/test/run -m jit -a '-vEval.JitPGO=0' ${HPHP_TEST}
hphp/test/run -m jit -r -a '-vEval.JitPGO=0' ${HPHP_TEST}
hphp/test/run -m jit -a '-vEval.JitPGO=1' ${HPHP_TEST}
hphp/test/run -m jit -r -a '-vEval.JitPGO=1' ${HPHP_TEST}
popd # ${HHVM_PATH}
