#!/bin/bash
# Der Pfad, in dem dieses Skript steht
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $scriptdir
# Umgebungsvariablen einlesen
source variables.conf

# Umgebungsvariablen ausgeben
echo "REGAL_ADMIN=$REGAL_ADMIN"
echo "REGAL_PASSWORD=$REGAL_PASSWORD"
echo "BACKEND=$BACKEND" # regal-api

# Aktion
pid="edoweb:100472"
# curl -XPOST -H"content-Type:application/json" -u$REGAL_ADMIN:$REGAL_PASSWORD "$BACKEND/resource/$pid/createVersion"
# curl -XPOST -u$REGAL_ADMIN:$REGAL_PASSWORD "$BACKEND/resource/$pid/createVersion?label=2019-11-17&location=/home/edoweb3/local/opt/regal/wpull-data/edoweb:100472/20191017172728/WEB-www.alsenz-obermoschel.de-20191017.warc.gz"
curl -XPOST -u$REGAL_ADMIN:$REGAL_PASSWORD "$BACKEND/resource/$pid/createVersion"
