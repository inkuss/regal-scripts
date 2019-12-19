#! /bin/bash

scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $scriptdir
source variables.conf

curl -s -XGET $ELASTICSEARCH/${INDEXNAME}2/part,issue,journal,monograph,volume,file,webpage/_search -d'{"query":{"match_all":{}},"fields":["/@id"],"size":"50000"}'|egrep -o "$INDEXNAME:[^\"]*" >$REGAL_LOGS/pids.txt
curl -s -XGET $ELASTICSEARCH/${INDEXNAME}2/webpage/_search -d '{"query":{"match_all":{}},"fields":["/@id"],"size":"50000"}'|grep -o "$INDEXNAME:[^\"]*" >$REGAL_LOGS/webpagePids.txt
curl -s -XGET $ELASTICSEARCH/${INDEXNAME}2/journal,monograph,webpage/_search -d'{"query":{"match_all":{}},"fields":["/@id"],"size":"50000"}'|egrep -o "$INDEXNAME:[^\"]*">$REGAL_LOGS/titleObjects.txt

echo "lobidify & enrich"
cat $REGAL_LOGS/webpagePids.txt | parallel --jobs 2 ./lobidifyPid.sh {} $BACKEND >$REGAL_LOGS/lobidify-webpages-`date +"%Y%m%d"`.log 2>&1

cd -
