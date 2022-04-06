# [ssh-proxy-by-caddy-l4](https://github.com/initdc/ssh-proxy-by-caddy-l4)

> Layer 4 proxy server, Powered by Caddy.

## Concept

Solving `git@github.com` network problem in this case.

## Warning

**![DANGER] Private key will send to mirror server, deploy server by yourself**

## Build

`docker buildx build -t caddy-l4:x1 .`

> `-t` for tag: `name:version`

## Run

`docker run --name caddy-l4 -dp 2201:2201 caddy-l4:x1`

## Test

`ssh -T -p 2201 git@localhost`

## Usage

`git clone git@localhost:initdc/Hello_World.git`

## Custom domain

You need set private key and port for ssh

```sh
Host github.com
    Hostname github.com
    IdentityFile ~/.ssh/id_ed25519_github
    User git

Host mirror.example.com
    Hostname mirror.example.com
    IdentityFile ~/.ssh/id_ed25519_github
    Port 2201
    User git
```

## Refs

- https://caddyserver.com/docs/modules/layer4

- https://github.com/mholt/caddy-l4

- https://docs.github.com/en/authentication/troubleshooting-ssh/using-ssh-over-the-https-port

## License

MPL 2.0
