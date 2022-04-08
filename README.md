# [ssh-proxy-by-caddy-l4](https://github.com/initdc/ssh-proxy-by-caddy-l4)

> Layer 4 proxy server, Powered by Caddy.

## Concept

Solving `git@github.com` network problem in this case.

## Warning

**![DANGER] Private key will send to mirror server, deploy server by yourself**

## Run

`docker run --name caddy-l4 -dp 2201:2201 initdc/caddy-l4:latest`

You need set private key and port for ssh

```sh
# ~/.ssh/config

Host github.com
    Hostname github.com
    IdentityFile ~/.ssh/id_ed25519_github
    User git

Host localhost
    Hostname localhost
    IdentityFile ~/.ssh/id_ed25519_github
    Port 2201
    User git

# ssh.example.com
Host ssh.example.com
    Hostname ssh.example.com
    IdentityFile ~/.ssh/id_ed25519_github
    User git
```

## Test

`ssh -T -p 2201 git@localhost`

## Usage

`git clone git@localhost:initdc/Hello_World.git`

## Prepare to build

change buildx `DRIVER` from `docker` to [ `docker-container` or `kubernetes` ]

```sh
docker buildx create --name mycontext1 --driver docker-container --use --bootstrap

# or
docker buildx create --name mycontext1 --driver kubernetes --use --bootstrap
```

refs:

- https://salesjobinfo.com/multi-arch-container-images-for-docker-and-kubernetes/

- https://github.com/docker/buildx/blob/master/docs/reference/buildx_create.md

## Build

1. local

   `docker buildx build -t caddy-l4:amd64 . --load`

   `docker buildx build --platform linux/arm64 -t caddy-l4:arm64 . --load`

   > `-t` for local tag: `name:arch`

2. for pushing

   `docker buildx build --platform linux/amd64,linux/arm64,linux/riscv64,linux/ppc64le,linux/s390x,linux/386,linux/mips64le,linux/mips64,linux/arm/v7,linux/arm/v6 -t initdc/caddy-l4:v$(TZ=Asia/Shanghai date +%Y.%m.%d) . --push`

   > `latest` -> `v$(TZ=Asia/Shanghai date +%Y.%m.%d)`

   > replace `initdc` with your docker registry user name.

   > check full list with `docker buildx ls`

## Refs

- https://docs.github.com/en/authentication/troubleshooting-ssh/using-ssh-over-the-https-port

- https://github.com/mholt/caddy-l4

- https://caddyserver.com/docs/modules/layer4

- https://github.com/ghthor/caddy-l4-docker

## License

MPL 2.0
