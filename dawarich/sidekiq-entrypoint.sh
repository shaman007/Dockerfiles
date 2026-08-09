#!/bin/sh
set -eu

unset BUNDLE_PATH
unset BUNDLE_BIN

. "$(dirname "$0")/entrypoint-env-guard.sh"
sanitize_integer_env BACKGROUND_PROCESSING_CONCURRENCY 3

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

until PGPASSWORD="$DATABASE_PASSWORD" psql -h "$DATABASE_HOST" -p "$DATABASE_PORT" -U "$DATABASE_USERNAME" -d "$DATABASE_NAME" -c '\q'; do
  echo "Postgres is unavailable - retrying..." >&2
  sleep 2
done

exec bundle exec sidekiq
