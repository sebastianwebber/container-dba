#!/bin/bash
set -xe

/usr/lib/postgresql/13/bin/pg_ctl \
    stop \
    --mode=immediate \
    --pgdata=${PGDATA}

rm -rf ${PGDATA}/*

export PGPASSWORD="${REPLICATION_PASSWORD}"

/usr/bin/pg_basebackup \
    --username=${REPLICATION_USER} \
    --host=db1 \
    --pgdata=${PGDATA} \
    --write-recovery-conf \
    --wal-method=stream \
    --progress \
    --verbose \
    --checkpoint=fast


/usr/lib/postgresql/13/bin/pg_ctl \
    start \
    --pgdata=${PGDATA}