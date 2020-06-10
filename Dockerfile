FROM nikolaik/python-nodejs:python3.8-nodejs12-alpine

ENV SAM_CLI_TELEMETRY 0

RUN apk --update --no-cache add jq curl bash gcc musl-dev

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
