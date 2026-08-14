# Dockerfiles
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fshaman007%2FDockerfiles.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Fshaman007%2FDockerfiles?ref=badge_shield)


Here I am keeping the dockerfiles I create or use for my [projects](https://github.com/shaman007/home-k3s).

- PHP-FPM with everything the Wordpress and Nextcloud need. Non-minimal!
- Postfix container
- Dovecot
- Rspamd
- Rsyslog
- \*-cli images are used for backups
- Clamav
- Language tool that is not particulairly useful, since it does not allow you to use Premium features
- VSFTPD: from https://github.com/fauria/docker-vsftpd.git, needed to be build for ARM support.

## Building on Fedora

Fedora uses Podman by default. For the repository's AMD64 + ARM64 builds,
install Podman and the ARM64 userspace emulator once:

```bash
sudo dnf install podman qemu-user-static-aarch64
```

Reboot after installing the emulator (or restart `systemd-binfmt`), authenticate,
then build all images:

```bash
./build.sh
```

Pass directory names to build only selected images:

```bash
./build.sh php postfix redis-cli
```

Image sources retained only for historical reference live under `DEPRECATED/`.
The default one-level `*/Dockerfile` discovery intentionally does not build
Dockerfiles below that directory.

The script pushes both `latest` and a UTC timestamp tag to
`harbor.andreybondarenko.com/library`. It prefers Podman and falls back to
Docker Buildx. Set `LOGIN=0` when already authenticated, `PULL=0` to build the
current checkout without updating it, or use `./build.sh --help` for all
overrides.

## Nightly rebuilds

The home-k8s repository contains a Kubernetes CronJob that runs every day at
02:29 UTC and invokes `build.sh` inside the `podman-builder` image. Harbor
credentials are provided by External Secrets from `kv/harbor`; they are not
stored in either Git repository.

Bootstrap the self-hosted builder once before enabling the CronJob:

```bash
./build.sh podman-builder
```

The CronJob then rebuilds the builder along with every other image, republishes
`latest`, and creates immutable UTC timestamp tags. The builder intentionally
uses Podman's `vfs` storage driver because it runs nested inside Kubernetes.
Its privileged init container registers ARM64 emulation so the existing
AMD64+ARM64 build contract is preserved on the AMD64-only cluster.


## License
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fshaman007%2FDockerfiles.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Fshaman007%2FDockerfiles?ref=badge_large)
