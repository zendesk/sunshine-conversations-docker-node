#
# Node JS Alpine image
#

FROM gliderlabs/alpine:3.6

# Install root filesystem
ADD ./rootfs /
RUN echo -ne "Alpine Linux 3.6 image. (`uname -rsv`)\n" >> /root/.built

# Node and NPM version
ENV NODE_VERSION=8.4.0 NPM_VERSION=5.3.0

# Install Node and NPM
RUN apk update && apk-install curl bash tree make gcc g++ python linux-headers paxctl libgcc libstdc++ && \
  curl -sSL https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}.tar.gz | tar -xz && \
  cd /node-v${NODE_VERSION} && \
  ./configure --prefix=/usr &&\
  make -j$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
  make install && \
  paxctl -cm /usr/bin/node && \
  npm install -g npm@${NPM_VERSION} && \
  apk del make gcc g++ python linux-headers paxctl && \
  find /usr/lib/node_modules/npm -name test -o -name .bin -type d | xargs rm -rf && \
  rm -rf /node-v${NODE_VERSION} \
  /usr/share/man /tmp/* /var/cache/apk/* /root/.npm \
  /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html; exit 0
RUN echo -ne "- with Node.js `node --version`\n" >> /root/.built

CMD ["/bin/bash"]
