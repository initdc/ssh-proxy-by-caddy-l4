# syntax=docker/dockerfile:1
FROM --platform=$TARGETPLATFORM golang:1.17-alpine AS build
ARG TARGETPLATFORM
ARG BUILDPLATFORM

RUN set -e \
    && echo "Running on $BUILDPLATFORM, building for $TARGETPLATFORM" \
    && go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest
    
RUN set -e \
    && xcaddy build --with github.com/mholt/caddy-l4 --output /root/caddy
    
FROM --platform=$TARGETPLATFORM alpine
COPY --from=build /root/caddy /usr/local/bin/caddy

WORKDIR /root
COPY caddy.json .

EXPOSE 2201
CMD ["/usr/local/bin/caddy", "run", "--config", "/root/caddy.json"]
