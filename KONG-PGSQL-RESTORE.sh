#!/bin/bash

###################
# Variables setting 
###################


HOSTNAME=kong-pgsql.infrastructure.marathon.mesos
PORT=$(nslookup -type=SRV _kong-pgsql.infrastructure._tcp.marathon.mesos | grep service | awk -F' ' '{print $6}')
DUMP=$( find /home/etcconit/KONG-PGSQL-BACKUPS/dump_*.sql -type f -printf "%f\n" )


###################
# Restoring the DB
###################

sudo  docker run -it --rm --name "KONG-RESTORER" --link $HOSTNAME -v "/home/etcconit/KONG-PGSQL-BACKUPS:/dump-bkp"  postgres:9.4 psql -h $HOSTNAME -p $PORT -U postgres -f /dump-bkp/$DUMP

