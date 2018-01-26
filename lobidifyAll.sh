#! /bin/bash

scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $scriptdir
source variables.conf

curl -s -XGET $ELASTICSEARCH/$INDEXNAME/part,issue,journal,monograph,volume,file,webpage/_search -d'{"query":{"match_all":{}},"fields":["/@id"],"size":"50000"}'|egrep -o "$INDEXNAME:[^\"]*" >$REGAL_LOGS/pids.txt
curl -s -XGET $ELASTICSEARCH/$INDEXNAME/journal/_search -d '{"query":{"match_all":{}},"fields":["/@id"],"size":"50000"}'|grep -o "$INDEXNAME:[^\"]*" >$REGAL_LOGS/journalPids.txt
curl -s -XGET $ELASTICSEARCH/$INDEXNAME/journal,monograph,webpage/_search -d'{"query":{"match_all":{}},"fields":["/@id"],"size":"50000"}'|egrep -o "$INDEXNAME:[^\"]*">$REGAL_LOGS/titleObjects.txt

echo "lobidify & enrich"
cat $REGAL_LOGS/titleObjects.txt | parallel --jobs 5 ./lobidifyPid.sh {} $BACKEND >$REGAL_LOGS/lobidify-`date +"%Y%m%d"`.log 2>&1

cd -
