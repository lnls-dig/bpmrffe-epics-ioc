#!../../bin/linux-x86_64/BPMRFFE

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/BPMRFFE.dbd"
BPMRFFE_registerRecordDeviceDriver pdbbase

## Setup environment variables
epicsEnvSet("P", "${EPICS_PV_AREA_PREFIX}")
epicsEnvSet("R", "${EPICS_PV_DEVICE_PREFIX}RFFE")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TOP)/BPMRFFEApp/Db")
epicsEnvSet("PORT", "BPMRFFE")

## Set up address
drvAsynIPPortConfigure("$(PORT)", "${RFFE_IP_ADDRESS}:9001", 0, 0, 0)
asynSetOption("$(PORT)", 0, "disconnectOnReadTimeout", "Y")

## Load record instances
dbLoadRecords("$(TOP)/db/bpmrffe.db", "P=$(P), R=$(R), PORT=$(PORT)")

## Load asynRecord for device connection monitoring
dbLoadRecords("$(TOP)/db/asynRecord.db", "P=$(P)$(R), R=asyn, PORT=$(PORT), ADDR=0, OMAX=80, IMAX=80")

## Load autosave monitoring records
dbLoadRecords("$(TOP)/db/save_restoreStatus.db", "P=$(P)$(R)")

cd "${TOP}/iocBoot/${IOC}"

## Configure autosave
< save_restore.cmd

iocInit

create_monitor_set("bpmrffe.req", 30, "P=$(P), R=$(R)")
set_savefile_name("bpmrffe.req", "$(P)$(R)_settings.sav")
