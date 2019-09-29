
FROM ubuntu:16.04

LABEL maintainer="https://github.com/PaulChanHK/docker-minidlna/tree/master/env"

ARG DEBIAN_FRONTEND=noninteractive
ARG APT_SERVER=""

# update source list
# then pull packages list and perform packages upgrade
RUN ( echo "deb http://opensource.wandisco.com/ubuntu xenial svn19" >> /etc/apt/sources.list.d/subversion19.list \
      && echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu xenial main" >> /etc/apt/sources.list.d/git_core.list \
      && echo "APT_SERVER=$APT_SERVER" \
      && [ -z "$APT_SERVER" ] || { \
         echo 'Acquire::http::Proxy "'http://${APT_SERVER}/'";' >> /etc/apt/apt.conf.d/01proxy \
      && echo 'Acquire::http::Proxy "'http://${APT_SERVER}/ppa/'";' >> /etc/apt/apt.conf.d/01proxy \
      && echo 'Acquire::http::Proxy "'http://${APT_SERVER}/wandisco/'";' >> /etc/apt/apt.conf.d/01proxy ; } \
      && apt-get update -y \
      && apt-get install --yes --assume-yes --allow-unauthenticated \
        wget locales tzdata debconf software-properties-common gnupg \
        curl gettext \
        unzip nano vim \
        subversion git git-core \
        autoconf autopoint \
        build-essential \
        checkinstall \
        libavcodec-ffmpeg56 libavformat-ffmpeg56 libavutil-ffmpeg54 \
        libexif12 libflac8 libid3tag0 libjpeg8 libjpeg-turbo8 \
        libogg0 libsqlite3-0 libvorbis0a libvorbisenc2 libvorbisfile3 \
        libavcodec-dev libavformat-dev libavutil-dev \
        libexif-dev libflac-dev libid3tag0-dev libjpeg-dev \
        libogg-dev libsqlite3-dev libvorbis-dev \
      && apt-get clean && rm -rf /var/lib/apt/lists/* \
      && wget -q -O /usr/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64 \
      && chmod u+x /usr/bin/dumb-init \
    )

ENV LANGUAGE en_US:en

ENTRYPOINT ["/usr/bin/dumb-init", "--", "sleep", "infinity"]
