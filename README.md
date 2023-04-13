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

Afterwards, you should create a container specifying the crate and BPM slot
numbers, RFFEs' base IP address, and set up the network to inherit the host's
configuration. For instance,

```bash
docker run \
    -d \
    --network host \
    --mount type=bind,source=/var/opt/rffe-epics-ioc,target=/var/opt/rffe-epics-ioc \
    -e CRATE_NUMBER=23 \
    -e BPM_NUMBER=1 \
    -e RFFE_BASE_IP_ADDRESS=127.0.0.0 \
    ghcr.io/lnls-dig/rffe-epics-ioc
```

By default, `st.cmd` will run under `procServ`, which will create a stream Unix
socket in `/run/procServ/ioc.sock` that can be used to access the IOC shell.

Autosave is configured to save its files under
`/var/opt/rffe-epics-ioc/autosave` with `.sav` files named after its PVs
prefix. Thus, the directory can be bind mounted to a host directory without
creating conflicts.
