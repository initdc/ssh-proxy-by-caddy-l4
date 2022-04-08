#!/bin/sh

set -ex

main() {
    case ${TARGETPLATFORM:-linux/amd64} in
    linux/386)
        export GOARCH=386
        ;;
    linux/amd64)
        export GOARCH=amd64
        ;;
    linux/arm/v5)
        export GOARCH=arm
        export GOARM=5
        ;;
    linux/arm/v6)
        export GOARCH=arm
        export GOARM=6
        ;;
    linux/arm/v7)
        export GOARCH=arm
        export GOARM=7
        ;;
    linux/arm64/v8 | linux/arm64)
        export GOARCH=arm64
        ;;
    linx/mips)
        export GOARCH=mips
        ;;
    linux/mips64)
        export GOARCH=mips64
        ;;
    linux/mips64le)
        export GOARCH=mips64le
        ;;
    linux/mipsle)
        export GOARCH=mipsle
        ;;
    linux/ppc64)
        export GOARCH=ppc64
        ;;
    linux/ppc64le)
        export GOARCH=ppc64le
        ;;
    linux/riscv64)
        export GOARCH=riscv64
        ;;
    linux/s390x)
        export GOARCH=s390x
        ;;
    *)
        echo "Unknown target platform: ${TARGETPLATFORM}"
        exit 1
        ;;
    esac

    if [ $GOARCH == "arm" ] && [ -n $GOARM ]; then
        wget "https://caddyserver.com/api/download?os=linux&arch=arm&arm=$GOARM&p=github.com%2Fmholt%2Fcaddy-l4" -O /root/caddy
        chmod +x /root/caddy
    else
        wget "https://caddyserver.com/api/download?os=linux&arch=$GOARCH&p=github.com%2Fmholt%2Fcaddy-l4" -O /root/caddy
        chmod +x /root/caddy
    fi
}

main
