# syntax=docker/dockerfile:1
FROM --platform=$BUILDPLATFORM alpine:edge AS build
ARG TARGETPLATFORM
ARG BUILDPLATFORM

COPY env.rb /root/env.rb
RUN set -e \
    && echo "Running on $BUILDPLATFORM, building for $TARGETPLATFORM" \
    && apk --no-cache add ruby ca-certificates wget
    
RUN set -e \
    && ruby /root/env.rb
    
FROM scratch
COPY --from=build /root/caddy /usr/local/bin/caddy

WORKDIR /root
COPY caddy.json .

EXPOSE 2201
CMD ["/usr/local/bin/caddy", "run", "--config", "/root/caddy.json"]
