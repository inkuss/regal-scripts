#! /bin/bash

scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $scriptdir
source variables.conf

curl -s -XGET $ELASTICSEARCH/_search -d'{"query":{"match_all":{}},"fields":["/@id"],"size":"50000"}'|egrep -o "$INDEXNAME:[^\"]*" >$REGAL_LOGS/pids.txt

echo "index all"
cat $REGAL_LOGS/pids.txt | parallel --jobs 5 ./indexPid.sh {} $BACKEND >$REGAL_LOGS/index-`date +"%Y%m%d"`.log 2>&1

cd -
