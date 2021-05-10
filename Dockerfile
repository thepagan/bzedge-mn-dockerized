FROM ubuntu:latest

RUN apt update && \
    apt install -y locales && \
    sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN DEBIAN_FRONTEND="noninteractive" apt install -y tzdata
RUN apt update && apt install -y \
      build-essential pkg-config libc6-dev m4 g++-multilib sudo dnsutils\
      autoconf libtool ncurses-dev unzip git python vim sharutils pwgen\
      zlib1g-dev libncurses5 wget bsdmainutils curl automake clang systemctl && \
    apt clean -y

RUN useradd -m bzedge
RUN usermod -aG sudo bzedge
RUN echo '%bzedge ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
USER bzedge
RUN mkdir $HOME/.bzedge
RUN git clone -b dev-440 https://github.com/bze-alphateam/bzedge $HOME/bzedge
RUN curl -o $HOME/firstrun.sh https://raw.githubusercontent.com/thepagan/bzedge-mn-dockerized/main/firstrun.sh
RUN chmod +x $HOME/firstrun.sh
RUN CONFIGURE_FLAGS="--disable-tests --disable-bench" HOST=x86_64-linux-gnu ./$HOME/bzedge/zcutil/build.sh
RUN ./$HOME/bzedge/zcutil/fetch-params.sh
RUN touch $HOME/.bzedge/bzedge.conf
RUN echo 'addnode=167.86.99.150' >> $HOME/.bzedge/bzedge.conf
EXPOSE 1980
EXPOSE 1990

ENTRYPOINT ["/bin/bash"]
