#!/usr/bin/env bash

set -ue

# Load prefix mappings
. slot-mapping.env

BPM_NUMBER=$1
CRATE_NUMBER=$(/opt/afc-epics-ioc/iocBoot/iocutca/getCrate.sh)
CRATE_NUMBER=${CRATE_NUMBER#0}

# Define which env var to use as prefix
area_prefix_var=CRATE_${CRATE_NUMBER}_BPM_${BPM_NUMBER}_PV_AREA_PREFIX
device_prefix_var=CRATE_${CRATE_NUMBER}_BPM_${BPM_NUMBER}_PV_DEVICE_PREFIX

export EPICS_PV_AREA_PREFIX=${!area_prefix_var}
export EPICS_PV_DEVICE_PREFIX=${!device_prefix_var}

# Use base address and offset it by BPM slot number
IFS="." read -a ip <<< $RFFE_BASE_IP_ADDRESS
export RFFE_IP_ADDRESS=${ip[0]}.${ip[1]}.${ip[2]}.$(( ${ip[3]} + $BPM_NUMBER ))

procServ -f -i ^C^D -L - $(( 1800 + BPM_NUMBER ))  ./st.cmd
