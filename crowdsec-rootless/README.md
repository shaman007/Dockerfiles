# CrowdSec rootless compatibility image

CrowdSec v1.8.1 base pinned by digest. The numeric USER is 1000:1000 and staged
configuration/application data paths belong to that user. Use with
runAsUser/runAsGroup/fsGroup 1000, runAsNonRoot=true, dropped ALL capabilities,
allowPrivilegeEscalation=false and RuntimeDefault seccomp.

The pinned chart creates `/etc/crowdsec` at startup. `/etc` remains root-owned,
with group 1000 and mode 1775: the group may create new entries, while the sticky
bit protects existing root-owned entries from removal. Existing root-owned files
are not made writable. The upstream entrypoint is retained. A writable container
layer is required; readOnlyRootFilesystem is outside this startup design.

## Legacy database migration

CrowdSec chmods its SQLite database, so fsGroup access alone cannot adopt an old
root-owned database. Run `crowdsec-rootless-prepare-database` in a non-root init
container after the old LAPI writer stops (one replica, Recreate strategy). It
uses SQLite's read-only backup API to copy legacy `crowdsec.db` into a new
UID-owned `crowdsec-rootless.db`. Configure LAPI to use the new path. The original
is retained; no root chown helper or database deletion is needed.

The helper checks SQLite integrity and publishes the verified destination
atomically without overwriting an existing target. Later restarts verify/reuse
the target. Corrupt input, symlink paths and invalid/empty/wrong-owner existing
targets fail closed. The runtime path and helper target must match. Preserve the
existing config/database PVCs and all production secrets. Never bake credentials
or production database contents into this image.

After cutover, the retained original is a stale snapshot: do not revert to its
path and lose newer writes. Returning to a stock root image needs an offline
ownership plan using the current database. Prefer correcting/rolling back the
UID-1000 image with its existing database path.

## Local build and integration test

From the Dockerfiles root:

```sh
podman build -t localhost/crowdsec-rootless:v1.8.1-rootless.1 crowdsec-rootless
```

Extract the pinned chart's LAPI startup script (code only, not secrets), then run
`python3 crowdsec-rootless/test-rootless.py --lapi-startup-script /path/to/docker_start.sh`.
The script accepts `--image` to test another locally available candidate. It uses
only disposable Podman containers/volumes, no production credentials or host
ports, and removes its generated test credentials on cleanup. Tests cover fresh
startup, root-owned/group-accessible legacy files, pre-migration credential
preservation, idempotent restart, UID/capability/no-new-privileges and metrics.
The legacy-fixture setup uses root only inside the disposable rootless Podman
namespace; there is no root init in the production design.

The tested build is AMD64, matching all current cluster nodes. Revalidate other
architectures and every base/chart update. Both copies of the image reference
(global chart image and database init) must remain aligned with the GitOps values.
