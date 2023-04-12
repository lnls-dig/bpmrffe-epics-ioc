FROM debian:11.6

ARG JOBS=1

ENV TZ America/Sao_Paulo
ENV DEBIAN_FRONTEND noninteractive

RUN apt update -y && \
    apt install -y --no-install-recommends \
        build-essential \
        wget \
        ca-certificates \
        procserv

ENV EPICS_BASE_PATH /opt/epics/base
ENV EPICS_BASE_VERSION 3.15.9

WORKDIR /opt/epics
COPY docker/install_epics.sh .
RUN ./install_epics.sh && \
    rm install_epics.sh

ENV EPICS_MODULES_PATH /opt/epics/modules
ENV ASYN_VERSION 4-44-2
ENV STREAMDEVICE_VERSION 2.8.24
ENV AUTOSAVE_VERSION 5-10-2

WORKDIR ${EPICS_MODULES_PATH}
COPY docker/install_modules.sh .
RUN ./install_modules.sh && \
    rm install_modules.sh

WORKDIR /opt/rffe-epics-ioc

COPY . .

RUN make -j ${JOBS}

RUN apt remove -y \
        wget \
        build-essential && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt/rffe-epics-ioc/iocBoot/iocBPMRFFEApp

CMD ./run.sh
