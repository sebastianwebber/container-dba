#!/bin/bash
set -e

echo "host  replication    all   0.0.0.0/0  md5" >> ${PGDATA}/pg_hba.conf
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE ROLE ${REPLICATION_USER} password '${REPLICATION_PASSWORD}' login replication;
    SELECT pg_reload_conf();
EOSQL
