# syntax=docker/dockerfile:1
FROM --platform=$BUILDPLATFORM golang:alpine AS build
ARG TARGETPLATFORM
ARG BUILDPLATFORM

RUN set -e \
    && apk add --no-cache ca-certificates wget

RUN set -e \
    && wget "https://caddyserver.com/api/download?os=$(go env GOOS)&arch=$(go env GOARCH)&p=github.com%2Fmholt%2Fcaddy-l4" \
    -O /root/caddy \
    && chmod +x /root/caddy

FROM alpine
COPY --from=build /root/caddy /usr/local/bin/caddy

WORKDIR /root
COPY caddy.json .

EXPOSE 2201
CMD ["/usr/local/bin/caddy", "run", "--config", "/root/caddy.json"]