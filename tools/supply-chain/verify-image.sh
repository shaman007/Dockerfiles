#!/usr/bin/env bash
# Registry signature discovery can lag behind a successful push.
set -Eeuo pipefail

error_file="$(mktemp)"
trap 'rm -f "$error_file"' EXIT
for attempt in 1 2 3 4 5 6; do
  if cosign verify "$@" 2>"$error_file"; then
    cat "$error_file" >&2
    exit 0
  else
    status=$?
  fi
  cat "$error_file" >&2
  # Retry missing signatures only; certificate and integrity failures are final.
  if ! grep -q 'no signatures found' "$error_file" || [[ "$attempt" == 6 ]]; then
    exit "$status"
  fi
  echo "Signature not discoverable yet; retrying ($attempt/6)" >&2
  sleep 10
done
