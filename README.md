# EPICS IOC for BPM Radio Frequency Front End

This repository contains the Radio Frequency Front End (RFFE) EPICS Input/Output
Controller (IOC) for LNLS Beam Position Monitor (BPM).

## Building the Docker image

In order to build the Docker image, you can execute the following command

```bash
docker compose build
```

## Accessing the IOC Shell

By default, `st.cmd` will run under `procServ` inside the container, which will
create a `ioc.sock` stream Unix socket in the container working directory that
can be used to access the IOC shell.
