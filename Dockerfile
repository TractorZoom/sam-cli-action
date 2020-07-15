FROM nikolaik/python-nodejs:python3.7-nodejs12-alpine

ENV SAM_CLI_TELEMETRY 0

RUN apk --update --no-cache add jq curl bash gcc git make musl-dev go libc6-compat

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
