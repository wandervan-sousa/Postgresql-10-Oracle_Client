#!/bin/bash

# Script to start the PostgreSQL server and perform some settings

# Start the PostgreSQL server in the background with pg_ctl and specify log files and additional options.
/usr/lib/postgresql/10/bin/pg_ctl start -D /var/lib/postgresql/10/main -l /var/log/postgresql/postgresql-10-main.log -s -o "-c config_file=/etc/postgresql/10/main/postgresql.conf" -o "-c hba_file=/etc/postgresql/10/main/pg_hba.conf" &

# Wait a second to give the PostgreSQL server time to start completely.
while true ; do

    pg_isready -U postgres

    test "$?" = "0" && break

done

# Run the psql utility to change the password for user 'postgres'.
psql -U postgres -c "ALTER ROLE postgres WITH PASSWORD '$POSTGRES_PASS';"

# Wait for all background processes to complete (in this case, the PostgreSQL server).# 
wait -n

# Stay running locked in tail -f, keeping the container active while waiting for external commands.
tail -f /dev/null
