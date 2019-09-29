
ARG ENV_IMG="paulchan/minidlna:env-1.0"

ARG SRC_GIT="https://github.com/PaulChanHK/minidlna.git"
ARG SRC_BCH="master"

ARG DEBIAN_FRONTEND=noninteractive
ARG APT_SERVER=""
# defaults = those media_dir from minidlna.conf
ARG MEDIA_DIRS="Movie Episode Music Photo"

################

FROM ${ENV_IMG} as pkg_build

ARG SRC_GIT
ARG SRC_BCH

WORKDIR /tmp

RUN ( git clone ${SRC_GIT} -b ${SRC_BCH} \
  && mkdir /pkg \
  && cd minidlna* \
  && export VERGIT=$(git describe --tags) \
  && export VERSTR=$(echo $VERGIT | sed -e 's/^v//' -e 's/_/./g') \
  && echo VERSTR=$VERSTR \
  && { echo "Git version : $VERGIT" \
  &&   echo "Git branch  : ${SRC_BCH}" \
  &&   echo "Git remote  : $(git remote -v | head -n1)" \
  &&   echo Changes in origin/original..HEAD : \
  &&   git log --pretty=oneline origin/original..HEAD | \
       sed -r 's/^([0-9a-f]{8})[0-9a-f]{32}(.*)/\1\2/'; } | tee /pkg/CHANGES \
  && ./autogen.sh >/dev/null \
  && ./configure >/dev/null  \
  && make -j$(nproc) >/dev/null \
  && checkinstall -y -D --install=no --pkgname=minidlna --pkgversion=$VERSTR \
  && mv minidlna_$VERSTR*.deb /pkg \
  )

################

FROM ubuntu:16.04

LABEL maintainer="https://github.com/PaulChanHK/docker-minidlna/tree/master/run"

ARG DEBIAN_FRONTEND
ARG APT_SERVER
ARG MEDIA_DIRS

COPY --from=pkg_build /pkg /pkg

# update source list
# then pull packages list and perform packages upgrade
# install minidlna deb and create media directories
RUN ( echo "APT_SERVER=$APT_SERVER" \
      && [ -z "$APT_SERVER" ] || { \
         echo 'Acquire::http::Proxy "'http://${APT_SERVER}/'";' >> /etc/apt/apt.conf.d/01proxy ; } \
      && apt-get update -y \
      && apt-get install --yes --assume-yes \
        libavcodec-ffmpeg56 libavformat-ffmpeg56 libavutil-ffmpeg54 \
        libexif12 libflac8 libid3tag0 libjpeg8 libjpeg-turbo8 \
        libogg0 libsqlite3-0 libvorbis0a libvorbisenc2 libvorbisfile3 \
      && cp /pkg/CHANGES / \
      && dpkg -i /pkg/minidlna*.deb \
      && mkdir -p /conf/ \
      && { for i in db ${MEDIA_DIRS}; do mkdir -p /media/$i; done; } \
      && rm -fr /pkg \
      && apt-get clean && rm -rf /var/lib/apt/lists/* \
    )

ENV LANGUAGE en_US:en

COPY entrypoint.sh minidlna.conf /conf/

EXPOSE 8200/tcp
EXPOSE 1900/udp

ENTRYPOINT ["/conf/entrypoint.sh", "-S"]
CMD ["-f", "/conf/minidlna.conf"]

# for debug
#ENTRYPOINT ["/bin/bash", "-c", "sleep infinity"]
