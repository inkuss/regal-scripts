#! /bin/bash

scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $scriptdir
source variables.conf

YESTERDAY=$(date +"%d/%b/%Y" -d"yesterday")    
IDSITE=4
STATS_LOG=$REGAL_LOGS/stats.log

function loadLogFile() {
    PATTERN=$1
    echo Lade $PATTERN >> $STATS_LOG
    zgrep --no-filename $PATTERN $APACHE_LOG/$APACHE_ACCESS_LOGNAME.*|sort|uniq > $REGAL_TMP/matomoImport.log
    python $MATOMO/misc/log-analytics/import_logs.py --recorder-max-payload-size=200 --url $MATOMO_URL --login $MATOMO_ADMIN --password $MATOMO_PASSWORD $REGAL_TMP/matomoImport.log --idsite=$IDSITE >> $STATS_LOG
}

loadLogFile "$YESTERDAY"
# Beispiel um die Logfiles der letzten 24 Tage zu laden
#
#for i in {4..10};do loadLogFile "$(date +"%d/%b/%Y" -d"$i days ago")";done


cd -
