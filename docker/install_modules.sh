#!/usr/bin/env bash

set -ex

# Install module from GitHub tagged versions
install_module() {
    github_org=$1
    module_name=$2
    tag=$3
    release_content="$4"

    # Download release code
    wget https://github.com/$github_org/$module_name/archive/refs/tags/$tag.tar.gz
    tar -xvzf $tag.tar.gz
    rm -f $tag.tar.gz

    mv $module_name-$tag $module_name
    cd $module_name
    echo -e "$release_content" > configure/RELEASE

    make -j ${JOBS} install
    make -j ${JOBS} clean

    cd -
}

install_module 'epics-modules' 'asyn' R$ASYN_VERSION "
EPICS_BASE = ${EPICS_BASE_PATH}
"

install_module 'paulscherrerinstitute' 'StreamDevice' $STREAMDEVICE_VERSION "
ASYN = ${EPICS_MODULES_PATH}/asyn

EPICS_BASE = ${EPICS_BASE_PATH}
"
