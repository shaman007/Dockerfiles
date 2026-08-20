#!/usr/bin/env bash
set -Eeuo pipefail

registry="${REGISTRY:-harbor.andreybondarenko.com}"
namespace="${NAMESPACE:-library}"
platforms="${PLATFORMS:-linux/amd64,linux/arm64}"
timestamp="${TAG:-$(date -u +"%Y-%m-%d-%H%M%S")}"
engine="${CONTAINER_ENGINE:-}"
cache_ttl="${CACHE_TTL:-720h}"

usage() {
  cat <<'EOF'
Usage: ./build.sh [IMAGE ...]

Build and push all image directories, or only the named images. Podman is used
when available (the Fedora default); Docker Buildx is the fallback.

Environment:
  CONTAINER_ENGINE=podman|docker  Select the build engine explicitly
  REGISTRY=host                   Registry (default: harbor.andreybondarenko.com)
  NAMESPACE=name                  Registry namespace (default: library)
  PLATFORMS=list                  Target platforms (default: linux/amd64,linux/arm64)
  TAG=value                       Immutable tag (default: current UTC timestamp)
  CACHE_TTL=duration              Podman cache lifetime (default: 720h)
  LOGIN=0                         Skip the interactive registry login
  PULL=0                          Skip pulling the Git branch before building
EOF
}

die() {
  printf 'error: %s\n' "$*" >&2
  exit 1
}

case "${1:-}" in
  -h|--help)
    usage
    exit 0
    ;;
esac

if [[ "${PULL:-1}" == 1 ]]; then
  command -v git >/dev/null || die "updating the checkout requires git"
  git pull --ff-only
fi

if [[ -z "$engine" ]]; then
  if command -v podman >/dev/null; then
    engine=podman
  elif command -v docker >/dev/null; then
    engine=docker
  else
    die "neither podman nor docker is installed (Fedora: sudo dnf install podman)"
  fi
fi

case "$engine" in
  podman)
    command -v podman >/dev/null || die "CONTAINER_ENGINE=podman, but podman is not installed"
    ;;
  docker)
    command -v docker >/dev/null || die "CONTAINER_ENGINE=docker, but docker is not installed"
    docker buildx version >/dev/null 2>&1 || die "Docker Buildx is not available"
    ;;
  *)
    die "unsupported container engine: $engine (use podman or docker)"
    ;;
esac

apps=()
if (($#)); then
  apps=("$@")
else
  for dockerfile in */Dockerfile; do
    [[ -f "$dockerfile" ]] && apps+=("${dockerfile%/Dockerfile}")
  done
fi

((${#apps[@]})) || die "no image directories found"
for app in "${apps[@]}"; do
  [[ "$app" != */* && "$app" != .* && -f "$app/Dockerfile" ]] || \
    die "invalid image directory: $app"
done

# Rootless Podman needs a binfmt handler to execute ARM64 RUN instructions on
# an x86_64 workstation. Fedora provides it in qemu-user-static-aarch64.
if [[ "$engine" == podman && "$(uname -m)" == x86_64 && "$platforms" == *linux/arm64* && \
      ! -e /proc/sys/fs/binfmt_misc/qemu-aarch64 ]]; then
  die "ARM64 emulation is unavailable; run 'sudo dnf install qemu-user-static-aarch64', then reboot (or restart systemd-binfmt)"
fi

if [[ "${LOGIN:-1}" == 1 ]]; then
  "$engine" login "$registry"
fi

printf 'Engine: %s\nRegistry: %s/%s\nPlatforms: %s\nTag: %s\nImages: %s\n' \
  "$engine" "$registry" "$namespace" "$platforms" "$timestamp" "${apps[*]}"

for app in "${apps[@]}"; do
  image="$registry/$namespace/$app"
  cache_image="$registry/$namespace/build-cache/$app"
  versioned_image="$image:$timestamp"

  printf '\n-------- BUILDING %s:latest and %s --------\n' "$image" "$versioned_image"

  if [[ "$engine" == podman ]]; then
    # With multiple platforms Podman writes the results to a manifest list.
    podman build \
      --layers \
      --cache-from "$cache_image" \
      --cache-to "$cache_image" \
      --cache-ttl "$cache_ttl" \
      --platform "$platforms" \
      --manifest "$versioned_image" \
      "$app"
    podman manifest push --all "$versioned_image" "docker://$versioned_image"
    podman manifest push --all "$versioned_image" "docker://$image:latest"
  else
    docker buildx build \
      --platform "$platforms" \
      --cache-from "type=registry,ref=$cache_image" \
      --cache-to "type=registry,ref=$cache_image,mode=max" \
      --provenance=true \
      --sbom=true \
      --tag "$image:latest" \
      --tag "$versioned_image" \
      --push \
      "$app"
  fi
done
