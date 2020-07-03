ARG VERSION

FROM ubuntu:${VERSION:-20.04} as base
ARG APT_PROXY
ARG USER
RUN [ -n "$APT_PROXY" ] && echo "$APT_PROXY" | sed "s/'//g" > '/etc/apt/apt.conf.d/00proxy' || :
RUN apt-get update -y && \
    apt-get install -y wget file sudo xz-utils uuid-runtime gnupg tzdata && \
    rm -rf /var/lib/apt/lists/* && \
    useradd --no-log-init --create-home --shell /bin/bash "$USER" && \
    usermod -aG sudo "$USER" && \
    echo "$USER ALL=NOPASSWD:ALL" > /etc/sudoers.d/nopasswd && \
    rm '/etc/localtime' && \
    ln -s '/usr/share/zoneinfo/America/Havana' '/etc/localtime' && \
    echo 'America/Havana' > '/etc/timezone'


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

FROM base as prod
ARG WORKDIR
ARG USER
COPY . "${WORKDIR}"
RUN chown -R "${USER}:${USER}" "${WORKDIR}"
ENTRYPOINT ["./dist/setup-cm"]
