#!/bin/bash

MANYLINUX_PYTHON=cp38-cp38
export PATH="/opt/python/${MANYLINUX_PYTHON}/bin:$PATH"
export DEFAULT_DOCKCROSS_IMAGE=dockcross/manylinux2014-aarch64


yum install -y openssl-devel zlib-devel libcurl-devel
CMAKE_VERSION=3.12.0
cd /root
curl -L -O https://cmake.org/files/v3.12/cmake-${CMAKE_VERSION}.tar.gz
tar -xzf cmake-${CMAKE_VERSION}.tar.gz
cd cmake-${CMAKE_VERSION}
./bootstrap --system-curl
make -j$(nproc)
make install
cd ..

cd /io


ci_before_install() {
    /opt/python/${MANYLINUX_PYTHON}/bin/python scripts/ssl-check.py
    /opt/python/${MANYLINUX_PYTHON}/bin/pip install scikit-ci scikit-ci-addons scikit-build
}

ci_install() {
    /opt/python/${MANYLINUX_PYTHON}/bin/ci install
}
ci_test() {
    /opt/python/${MANYLINUX_PYTHON}/bin/ci test
}
ci_after_success() {
    /opt/python/${MANYLINUX_PYTHON}/bin/ci after_test
}

ci_before_install
ci_install
ci_test
ci_after_success
