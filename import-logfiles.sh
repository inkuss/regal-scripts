#! /bin/bash

scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $scriptdir
source variables.conf

YESTERDAY=$(date +"%d/%b/%Y" -d"yesterday")    
TMP=$REGAL_TMP
IDSITE=$IDSITE
STATS_LOG=$REGAL_LOGS/stats.log

function loadLogFile() {
    PATTERN=$1
    zgrep --no-filename $PATTERN $APACHE_LOG/$APACHE_ACCESS_LOGNAME.*|sort|uniq > $TMP/matomoImport.log
    python $MATOMO/misc/log-analytics/import_logs.py --recorder-max-payload-size=200 --url $MATOMO_URL --login $MATOMO_ADMIN --password $MATOMO_PASSWORD $TMP/matomoImport.log --idsite=$IDSITE >> $STATS_LOG
}

loadLogFile "$YESTERDAY"
CMD="sudo $MATOMO/console core:archive --skip-idsites=$SKIP_IDSITES --force-idsites=$IDSITE --force-all-periods=315576000 --force-date-last-n=1000 --url $MATOMO_URL"
echo "executing command: $CMD >> $STATS_LOG 2>&1"
$CMD >> $STATS_LOG 2>&1

cd -
# Beispiel um die Logfiles der letzten 24 Tage zu laden
#
#for i in {1..24};do echo loadLogFile "$(date +"%d/%b/%Y" -d"$i days ago")";done

