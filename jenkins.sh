#!/bin/bash -e

set -x

# '--ios-{multiarch,combined}' do nothing for non-iOS builds
polly.py \
  --toolchain ${TOOLCHAIN} \
  --config ${CONFIG} \
  --verbose \
  --ios-multiarch --ios-combined \
  --fwd \
  HUNTER_SUPPRESS_LIST_OF_FILES=ON \
  BUILD_SHARED_LIBS=${SHARED} \
  HUNTER_BUILD_SHARED_LIBS=${SHARED} \
  ${TEST} \
  --install
