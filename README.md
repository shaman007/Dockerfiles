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

The script pushes both `latest` and a UTC timestamp tag to
`harbor.andreybondarenko.com/library`. It prefers Podman and falls back to
Docker Buildx. Set `LOGIN=0` when already authenticated, `PULL=0` to build the
current checkout without updating it, or use `./build.sh --help` for all
overrides.

## Nightly rebuilds

The `Nightly Harbor rebuild` GitHub Actions workflow runs every day at 02:29
UTC and invokes `build.sh` with Podman for every image. It republishes `latest`
and creates an immutable UTC timestamp tag, so rebuilding also incorporates
patched base images and distribution packages.

Configure these GitHub Actions repository secrets before enabling the job:

- `HARBOR_USERNAME`: a Harbor user or robot account with push access to
  `library`
- `HARBOR_PASSWORD`: that account's password or robot token

The existing GHCR workflow continues to run for pushes and pull requests; its
nightly schedule was moved to the Harbor workflow because the cluster consumes
the Harbor images.


## License
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fshaman007%2FDockerfiles.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Fshaman007%2FDockerfiles?ref=badge_large)
