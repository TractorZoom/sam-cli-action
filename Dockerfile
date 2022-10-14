FROM https://registry.hub.docker.com/r/vukomir/aws-sam-cli

ENV SAM_CLI_TELEMETRY 0

RUN apk --update --no-cache add jq curl bash gcc git make musl-dev libc6-compat tar libffi-dev && \
  curl https://dl.google.com/go/go1.14.6.linux-amd64.tar.gz | tar -xvzf - -C /usr/local 
ENV GOROOT /usr/local/go
ENV PATH ${PATH}:${GOROOT}/bin
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
