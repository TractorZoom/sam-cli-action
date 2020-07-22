FROM nikolaik/python-nodejs:python3.7-nodejs12-alpine

ENV SAM_CLI_TELEMETRY 0

RUN apk --update --no-cache add jq curl bash gcc git make musl-dev libc6-compat tar
RUN curl https://dl.google.com/go/go1.14.6.src.tar.gz | tar -xzf - -C /usr/local 
ENV GOROOT /usr/local/go
ENV PATH ${PATH}:${GOROOT}/bin
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
