#!/bin/bash

MANYLINUX_PYTHON=cp38-cp38

cd /io

ci_before_install() {
    /opt/python/${MANYLINUX_PYTHON}/bin/python scripts/ssl-check.py
    /opt/python/${MANYLINUX_PYTHON}/bin/python -m pip install --disable-pip-version-check --upgrade pip
    /opt/python/${MANYLINUX_PYTHON}/bin/pip install -U scikit-ci scikit-ci-addons
    /opt/python/${MANYLINUX_PYTHON}/bin/ci_addons --install ../addons
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
