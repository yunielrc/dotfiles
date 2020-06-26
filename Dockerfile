ARG VERSION=20.04

FROM ubuntu:$VERSION as base
RUN echo 'Acquire::http::Proxy "http://apt-cacher.casa.dylgran.com:3142/";' \
    > '/etc/apt/apt.conf.d/00proxy'
RUN apt-get update -y && \
    apt-get install -y wget file sudo xz-utils uuid-runtime && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd -r user && useradd -r -g user -s `which bash` user

FROM base as dev
RUN apt-get update -y && \
    apt-get install -y git shellcheck build-essential && \
    rm -rf /var/lib/apt/lists/* && \
    cd /tmp/ && \
    git clone https://github.com/bats-core/bats-core.git && \
    cd bats-core && \
    ./install.sh /usr/local && \
    cd - && rm -r /tmp/bats-core && \
    git clone https://github.com/bats-core/bats-assert.git /usr/local/lib/bats-assert && \
    git clone https://github.com/bats-core/bats-support.git /usr/local/lib/bats-support

