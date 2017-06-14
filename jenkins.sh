#!/bin/bash -e

set -x

# '--ios-{multiarch,combined}' do nothing for non-iOS builds
polly.py \
  --toolchain ${TOOLCHAIN} \
  --config ${CONFIG} \
  --verbose \
  --ios-multiarch --ios-combined \
  --fwd \
  HUNTER_USE_CACHE_SERVERS=ONLY \
  HUNTER_DISABLE_BUILDS=ON \
  HUNTER_SUPPRESS_LIST_OF_FILES=ON \
  GAUZE_ANDROID_USE_EMULATOR=ON \
  --test \
  --install
