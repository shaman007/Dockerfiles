#!/bin/sh
set -eu

# Preserve the upstream environment-to-settings translation.  All writes below
# are confined to Kubernetes-mounted writable volumes.
VAULT_SERVICE_URI="https://${BW_DOMAIN:-localhost}"
MYSQL_CONNECTION_STRING="server=${BW_DB_SERVER:-};port=${BW_DB_PORT:-3306};database=${BW_DB_DATABASE:-};user=${BW_DB_USERNAME:-};password=${BW_DB_PASSWORD:-}"
POSTGRESQL_CONNECTION_STRING="Host=${BW_DB_SERVER:-};Port=${BW_DB_PORT:-5432};Database=${BW_DB_DATABASE:-};Username=${BW_DB_USERNAME:-};Password=${BW_DB_PASSWORD:-}"
SQLSERVER_CONNECTION_STRING="Server=${BW_DB_SERVER:-},${BW_DB_PORT:-1433};Database=${BW_DB_DATABASE:-};User Id=${BW_DB_USERNAME:-};Password=${BW_DB_PASSWORD:-};Encrypt=True;TrustServerCertificate=True"
SQLITE_CONNECTION_STRING="Data Source=${BW_DB_FILE:-};"

INTERNAL_IDENTITY_KEY="$(openssl rand -hex 30)"
OIDC_IDENTITY_CLIENT_KEY="$(openssl rand -hex 30)"
DUO_AKEY="$(openssl rand -hex 30)"

export globalSettings__baseServiceUri__vault="${globalSettings__baseServiceUri__vault:-$VAULT_SERVICE_URI}"
export globalSettings__installation__id="${BW_INSTALLATION_ID:-}"
export globalSettings__installation__key="${BW_INSTALLATION_KEY:-}"
export globalSettings__internalIdentityKey="${globalSettings__internalIdentityKey:-$INTERNAL_IDENTITY_KEY}"
export globalSettings__oidcIdentityClientKey="${globalSettings__oidcIdentityClientKey:-$OIDC_IDENTITY_CLIENT_KEY}"
export globalSettings__duo__aKey="${globalSettings__duo__aKey:-$DUO_AKEY}"
export globalSettings__databaseProvider="${BW_DB_PROVIDER:-}"
export globalSettings__mysql__connectionString="${globalSettings__mysql__connectionString:-$MYSQL_CONNECTION_STRING}"
export globalSettings__postgreSql__connectionString="${globalSettings__postgreSql__connectionString:-$POSTGRESQL_CONNECTION_STRING}"
export globalSettings__sqlServer__connectionString="${globalSettings__sqlServer__connectionString:-$SQLSERVER_CONNECTION_STRING}"
export globalSettings__sqlite__connectionString="${globalSettings__sqlite__connectionString:-$SQLITE_CONNECTION_STRING}"

if [ "${BW_ENABLE_SSL:-false}" = "true" ]; then
  echo "BW_ENABLE_SSL=true is unsupported by the hardened image; terminate TLS at the ingress." >&2
  exit 1
fi
export globalSettings__baseServiceUri__internalVault="http://localhost:${BW_PORT_HTTP:-8080}"

# hbs renders only /etc/nginx/http.d/bitwarden.conf. That directory is an
# emptyDir prepared by the init container, so this remains compatible with a
# read-only image filesystem.
/usr/local/bin/hbs
exec /usr/bin/supervisord
