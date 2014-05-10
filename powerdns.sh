#!/usr/bin/env bash

su - postgres <<EOF
pg_ctl -D /var/lib/postgres/data start
EOF

sleep 3 # wait for full startup

if [ $? -eq 0 ]
then
    pdns_server --daemon=no
else
    echo "Postgres didn't start correctly!" 1>2
    exit 100
fi