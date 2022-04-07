# syntax=docker/dockerfile:1
FROM golang:1.17-alpine AS build
ARG TARGETPLATFORM
ARG BUILDPLATFORM

COPY env.rb /root/env.rb
RUN set -e \
    && echo "Running on $BUILDPLATFORM, building for $TARGETPLATFORM" \
    && apk --no-cache add ruby \
    && go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest
    
RUN set -e \
    && ruby /root/env.rb
    
FROM --platform=$TARGETPLATFORM scratch
COPY --from=build /root/caddy /usr/local/bin/caddy

WORKDIR /root
COPY caddy.json .

EXPOSE 2201
CMD ["/usr/local/bin/caddy", "run", "--config", "/root/caddy.json"]
