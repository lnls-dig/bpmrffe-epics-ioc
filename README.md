# EPICS IOC for BPM Radio Frequency Front End

This repository contains the Radio Frequency Front End (RFFE) EPICS Input/Output
Controller (IOC) for LNLS Beam Position Monitor (BPM).

## Building the Docker image

In order to build the Docker image, you can execute the following command

```bash
docker build \
    -t ghcr.io/lnls-dig/rffe-epics-ioc \
    -f docker/Dockerfile \
    --build-arg JOBS=$(nproc) \
    .
```

The `JOBS` argument specifies the number of concurrent processes (1 by default)
used to build the application and its dependencies. It will not change the
resulting image, only the time for building it.

## Running the IOC

Afterwards, you should create a container specifying the area and device
prefixes, and set up the network to inherit the host's configuration.

```bash
docker run \
    -d \
    -it \
    --network host \
    -e EPICS_PV_AREA_PREFIX=A: \
    -e EPICS_PV_DEVICE_PREFIX=D: \
    ghcr.io/lnls-dig/rffe-epics-ioc
```

Interactive mode (`-it`) is needed to prevent the IOC Shell from exiting due to
EOF even when executing in detached mode (`-d`).

By default, `st.cmd` will be executed.
