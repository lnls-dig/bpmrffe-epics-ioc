#!../../bin/linux-x86_64/BPMRFFE

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/BPMRFFE.dbd"
BPMRFFE_registerRecordDeviceDriver pdbbase

## Setup environment variables
epicsEnvSet("P", "${EPICS_PV_AREA_PREFIX}")
epicsEnvSet("R", "${EPICS_PV_DEVICE_PREFIX}")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TOP)/BPMRFFEApp/Db")
epicsEnvSet("PORT", "BPMRFFE")

## Set up address
drvAsynIPPortConfigure("$(PORT)", "10.20.21.36:9001", 0, 0, 0)
asynSetOption("$(PORT)", 0, "disconnectOnReadTimeout", "Y")

## Load record instances
dbLoadRecords("$(TOP)/db/bpmrffe.db", "P=$(P), R=$(R), PORT=$(PORT)")

## Load asynRecord for device connection monitoring
dbLoadRecords("$(ASYN)/db/asynRecord.db", "P=$(P)$(R), R=RFFEasyn, PORT=$(PORT), ADDR=0, OMAX=80, IMAX=80")

cd "${TOP}/iocBoot/${IOC}"
iocInit
