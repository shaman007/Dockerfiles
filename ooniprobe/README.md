# OONI Probe

Minimal AMD64/ARM64 runtime image for the official OONI Probe CLI. The release
binaries are pinned to v3.30.0 and verified during the build using the SHA-256
digests published by the upstream GitHub release.

The runtime is `scratch` plus CA certificates, runs as UID/GID 65532, and uses
`/data` as its home and working directory.

Build and publish through the repository build script:

```sh
./build.sh ooniprobe
```
