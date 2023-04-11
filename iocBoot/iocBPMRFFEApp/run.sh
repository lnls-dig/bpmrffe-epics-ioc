#!/usr/bin/env bash

set -ue

# Load prefix mappings
. slot-mapping.env

# Define which env var to use as prefix
area_prefix_var=CRATE_${CRATE_NUMBER}_BPM_${BPM_NUMBER}_PV_AREA_PREFIX
device_prefix_var=CRATE_${CRATE_NUMBER}_BPM_${BPM_NUMBER}_PV_DEVICE_PREFIX

export EPICS_PV_AREA_PREFIX=${!area_prefix_var}
export EPICS_PV_DEVICE_PREFIX=${!device_prefix_var}

socket_path=/run/procServ/ioc.sock
mkdir -p $(dirname $socket_path)

procServ -f -i ^C^D -L - unix:$socket_path ./st.cmd
