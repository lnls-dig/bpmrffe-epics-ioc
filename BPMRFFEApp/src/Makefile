TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Build the IOC application
PROD_IOC = BPMRFFE

# BPMRFFE.dbd will be created and installed
DBD += BPMRFFE.dbd

BPMRFFE_DBD += base.dbd

BPMRFFE_LIBS += asyn
BPMRFFE_DBD += asyn.dbd
BPMRFFE_DBD += drvAsynIPPort.dbd

BPMRFFE_LIBS += calc
BPMRFFE_DBD += calcSupport.dbd

BPMRFFE_LIBS += stream
BPMRFFE_DBD += stream.dbd

BPMRFFE_LIBS += autosave
BPMRFFE_DBD += asSupport.dbd

# BPMRFFE_registerRecordDeviceDriver.cpp derives from BPMRFFE.dbd
BPMRFFE_SRCS += BPMRFFE_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
BPMRFFE_SRCS_DEFAULT += BPMRFFEMain.cpp
BPMRFFE_SRCS_vxWorks += -nil-

# Finally link IOC to the EPICS Base libraries
BPMRFFE_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE
