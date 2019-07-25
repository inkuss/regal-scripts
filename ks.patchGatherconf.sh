#!/bin/bash
# Der Pfad, in dem dieses Skript steht
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $scriptdir
# Umgebungsvariablen einlesen
source variables.conf

# Umgebungsvariablen ausgeben
server=$SERVER; echo "server=$server"
regalApi=$BACKEND; echo "regalApi=$regalApi"

# Aktion
pid="edoweb:10119"
cmd="curl -H \"Content-Type: application/json\" -XGET -u$REGAL_ADMIN:$REGAL_PASSWORD \"$regalApi/resource/$pid/conf\""
echo $cmd
# exit 0

cmd="curl -H \"Content-Type: application/json\" -XPUT -u$REGAL_ADMIN:$REGAL_PASSWORD -d'{\"name\":\"edoweb:10118\",\"active\":true,\"url\":\"http://www.pirmasens.de/\",\"httpResponseCode\":0,\"invalidUrl\":false,\"deepness\":-1,\"robotsPolicy\":\"ignore\",\"interval\":\"once\",\"crawlerSelection\":\"wpull\",\"agentIdSelection\":\"Chrome\",\"startDate\":\"2019-07-24T00:00:00.000+0000\",\"localDir\":\"/opt/regal/wpull-data/edoweb:10118/20190724175635\",\"openWaybackLink\":\"https://api.edoweb-dev.hbz-nrw.de/wayback/20190724/http://www.pirmasens.de/\",\"maxCrawlSize\":0,\"waitSecBtRequests\":0,\"randomWait\":true,\"tries\":5,\"waitRetry\":20}' \"$regalApi/resource/$pid/conf\""
echo $cmd
exit 0
