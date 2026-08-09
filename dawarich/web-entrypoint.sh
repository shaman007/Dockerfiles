#!/bin/sh
set -eu

unset BUNDLE_PATH
unset BUNDLE_BIN

. "$(dirname "$0")/entrypoint-env-guard.sh"
sanitize_integer_env WEB_CONCURRENCY 1

rm -f "$APP_PATH/tmp/pids/server.pid"

if [ -d /tmp/public_assets ]; then
  echo "Syncing static assets to the public volume..."
  rm -rf "$APP_PATH/public/assets"
  cp -r /tmp/public_assets/. "$APP_PATH/public/"
fi

create_database() {
  db_name=$1
  db_password=$2
  db_host=$3
  db_port=$4
  db_username=$5

  PGPASSWORD="$db_password" createdb -h "$db_host" -p "$db_port" -U "$db_username" "$db_name" 2>/dev/null || true
  until PGPASSWORD="$db_password" psql -h "$db_host" -p "$db_port" -U "$db_username" -d "$db_name" -c '\q' 2>/dev/null; do
    echo "Postgres is unavailable - retrying..." >&2
    sleep 2
  done
}

if [ -n "${DATABASE_URL:-}" ]; then
  db_url=${DATABASE_URL#*://}
  db_credentials=${db_url%%@*}
  db_host_path=${db_url#*@}
  DATABASE_USERNAME=${db_credentials%%:*}
  DATABASE_PASSWORD=${db_credentials#*:}
  db_host_port=${db_host_path%%/*}
  DATABASE_NAME=${db_host_path#*/}
  DATABASE_HOST=${db_host_port%%:*}
  if [ "$db_host_port" != "$DATABASE_HOST" ]; then
    DATABASE_PORT=${db_host_port#*:}
  else
    DATABASE_PORT=5432
  fi
fi

export DATABASE_HOST DATABASE_PORT DATABASE_USERNAME DATABASE_PASSWORD DATABASE_NAME

create_database "$DATABASE_NAME" "$DATABASE_PASSWORD" "$DATABASE_HOST" "$DATABASE_PORT" "$DATABASE_USERNAME"
# Rails dumps the post-migration schema by default. The application source is
# deliberately read-only at runtime, so write this generated artifact to /tmp.
SCHEMA=/tmp/schema.rb bundle exec rails db:migrate
bundle exec rake data:migrate
bundle exec rails db:seed

exec bundle exec "$@"
