#!/bin/sh
set -eu

# Prepare the small, pod-local writable surface that cannot be baked into an
# image: service selection, generated Nginx configuration, and the persistent
# Identity certificate copied to the two applications that consume it.
install -d -m 0755 /runtime/supervisor /runtime/nginx /runtime/identity
cp -a /usr/local/share/bitwarden-supervisor/. /runtime/supervisor/
cp -a /usr/local/share/bitwarden-nginx/. /runtime/nginx/

set_service() {
  sed -i "s/^autostart=true$/autostart=$2/" "/runtime/supervisor/$1.ini"
}
set_service admin "${BW_ENABLE_ADMIN:-true}"
set_service api "${BW_ENABLE_API:-true}"
set_service events "${BW_ENABLE_EVENTS:-false}"
set_service icons "${BW_ENABLE_ICONS:-true}"
set_service identity "${BW_ENABLE_IDENTITY:-true}"
set_service notifications "${BW_ENABLE_NOTIFICATIONS:-true}"
set_service scim "${BW_ENABLE_SCIM:-false}"
set_service sso "${BW_ENABLE_SSO:-false}"

if [ ! -f /etc/bitwarden/identity.pfx ]; then
  certificate_dir="$(mktemp -d)"
  trap 'rm -rf "$certificate_dir"' EXIT
  openssl req -x509 -newkey rsa:4096 -sha256 -nodes \
    -keyout "$certificate_dir/identity.key" \
    -out "$certificate_dir/identity.crt" \
    -subj '/CN=Bitwarden IdentityServer' -days 36500
  openssl pkcs12 -export \
    -out /etc/bitwarden/identity.pfx \
    -inkey "$certificate_dir/identity.key" \
    -in "$certificate_dir/identity.crt" \
    -passout "pass:${globalSettings__identityServer__certificatePassword:-}"
fi

install -m 0600 /etc/bitwarden/identity.pfx /runtime/identity/identity.pfx
install -m 0600 /etc/bitwarden/identity.pfx /runtime/identity/sso-identity.pfx
