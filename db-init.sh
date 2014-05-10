#!/usr/bin/env bash

DATA=/var/lib/postgres/data

# Container shuts down right after this, so make sure we clean up after ourselves.
# If the database is shut down forcefully it won't start up correctly next time.
su - postgres <<EOF
pg_ctl -D $DATA initdb
pg_ctl -D $DATA start
sleep 10
pg_ctl -D $DATA status
psql -c "create role pdns with login encrypted password 'pdns';"
psql -c 'create database pdns with owner pdns;'
psql -U pdns -d pdns -f /tmp/schema.sql
pg_ctl -D $DATA stop
EOF
