FROM nikolaik/python-nodejs:python3.7-nodejs12-alpine

ENV SAM_CLI_TELEMETRY 0
ENV GLIBC_VERSION=2.31-r0

RUN apk update && apk upgrade && \
    mkdir -p /etc/BUILDS/ && \
    printf "Build of nimmis/alpine-glibc:3.12, date: %s\n"  `date -u +"%Y-%m-%dT%H:%M:%SZ"` > /etc/BUILDS/alpine-glibc && \
    apk add jq curl bash gcc git make musl-dev libc6-compat && \
    curl -Ls -o /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    curl -Ls -o glibc-${GLIBC_VERSION}.apk \
      "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk" && \
    curl -Ls -o glibc-bin-${GLIBC_VERSION}.apk \
      "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk" && \
    apk add  glibc-${GLIBC_VERSION}.apk glibc-bin-${GLIBC_VERSION}.apk && \
    curl -Ls -o /tmp/libz.tar.xz "https://www.archlinux.org/packages/core/x86_64/zlib/download" && \
    mkdir -p /tmp/libz && \
    tar -xJf /tmp/libz.tar.xz -C /tmp/libz && \
    cp /tmp/libz/usr/lib/libz.so.1.2.11 /usr/glibc-compat/lib && \
    /usr/glibc-compat/sbin/ldconfig && \
    rm -rf /tmp/libz /tmp/libz.tar.xz && \
    apk del curl && \
    rm -fr glibc-${GLIBC_VERSION}.apk glibc-bin-${GLIBC_VERSION}.apk /var/cache/apk/* 

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
