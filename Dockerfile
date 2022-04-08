# syntax=docker/dockerfile:1
FROM --platform=$BUILDPLATFORM alpine as build

ARG TARGETPLATFORM
ARG BUILDPLATFORM

COPY env.sh /root/env.sh
RUN set -e \
    apk add --no-cache ca-certificates wget

RUN set -e \
    && echo "Running on $BUILDPLATFORM, building for $TARGETPLATFORM" \
    && chmod +x /root/env.sh && /root/env.sh

FROM scratch
COPY --from=build /root/caddy /usr/local/bin/caddy

WORKDIR /root
COPY caddy.json .

EXPOSE 2201
CMD ["/usr/local/bin/caddy", "run", "--config", "/root/caddy.json"]
