TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord

# Install xxxSupport.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Build an IOC support library
LIBRARY_IOC += BPMRFFESupport

# Compile and add the code to the support library
BPMRFFESupport_SRCS += xxxRecord.c
BPMRFFESupport_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application.
# This is required for Windows DLL builds.
BPMRFFESupport_SRCS += dbSubExample.c
BPMRFFESupport_SRCS += BPMRFFEHello.c
BPMRFFESupport_SRCS += initTrace.c

BPMRFFESupport_LIBS += $(EPICS_BASE_IOC_LIBS)


# Build the IOC application
PROD_IOC = BPMRFFE

# BPMRFFE.dbd will be created and installed
DBD += BPMRFFE.dbd

# BPMRFFE.dbd will include these files:
BPMRFFE_DBD += base.dbd
BPMRFFE_DBD += xxxSupport.dbd
BPMRFFE_DBD += dbSubExample.dbd
BPMRFFE_DBD += BPMRFFEHello.dbd
BPMRFFE_DBD += initTrace.dbd

# BPMRFFE_registerRecordDeviceDriver.cpp derives from BPMRFFE.dbd
BPMRFFE_SRCS += BPMRFFE_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
BPMRFFE_SRCS_DEFAULT += BPMRFFEMain.cpp
BPMRFFE_SRCS_vxWorks += -nil-

# Link in the code from our support library
BPMRFFE_LIBS += BPMRFFESupport

# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncExample into BPMRFFESupport
    sncExample_SNCFLAGS += +r
    BPMRFFE_DBD += sncExample.dbd
    # A .stt sequence program is *not* pre-processed:
    BPMRFFESupport_SRCS += sncExample.stt
    BPMRFFESupport_LIBS += seq pv
    BPMRFFE_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    # A .st sequence program *is* pre-processed:
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Finally link IOC to the EPICS Base libraries
BPMRFFE_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

