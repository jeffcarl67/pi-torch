#!/bin/bash
export USE_CUDA=0
export USE_CUDNN=0
export USE_MKLDNN=0
export USE_NNPACK=1
export USE_QNNPACK=1
export USE_DISTRIBUTED=0
export BUILD_TEST=0
export MAX_JOBS=2 # For Github host
export USE_CFLAGS=1
export CFLAGS="-mfpu=neon -D__NEON__"

apt-get update && apt-get install -y python3-cffi python3-numpy

pip3 install cython wheel

git clone --recursive https://github.com/pytorch/pytorch

cd pytorch

git checkout v1.4.0

git submodule sync --recursive
git submodule update --init --recursive

# Fix from: https://github.com/pytorch/pytorch/issues/22564
git submodule update --remote third_party/protobuf

python3 setup.py install