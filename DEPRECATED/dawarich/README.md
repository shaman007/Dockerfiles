# Deprecated Dawarich image

This derived image is retained for historical reference only. Deployments use
the official `freikin/dawarich` image instead; Kubernetes supplies the non-root
security context, read-only root filesystem, and writable runtime mounts.

The repository's default build discovery does not build images below
`DEPRECATED/`.
