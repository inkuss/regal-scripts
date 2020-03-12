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
    echo Lade $PATTERN >> $STATS_LOG
    zgrep --no-filename $PATTERN $APACHE_LOG/$APACHE_ACCESS_LOGNAME.*|sort|uniq > $TMP/matomoImport.log
    python $MATOMO/misc/log-analytics/import_logs.py --recorder-max-payload-size=200 --url $MATOMO_URL --login $MATOMO_ADMIN --password $MATOMO_PASSWORD $TMP/matomoImport.log --idsite=$IDSITE >> $STATS_LOG
}

loadLogFile "$YESTERDAY"
# Beispiel um die Logfiles der letzten 10-40 Tage zu laden
#
#for i in {10..40};do loadLogFile "$(LANG=en;date +"%d/%b/%Y" -d"$i days ago")";done
CMD="sudo $MATOMO/console core:archive --skip-idsites=$SKIP_IDSITES --force-idsites=$IDSITE --force-all-periods=315576000 --force-date-last-n=1000 --url $MATOMO_URL"
echo "executing command: $CMD >> $STATS_LOG 2>&1"
$CMD >> $STATS_LOG 2>&1

# Beispiel um die Differenz in Tagen auszurechnen
#
# A="2018-01-21"
# B="2018-04-08"
# echo $(( (`date -d $B +%s` - `date -d $A +%s`) / 86400 )) days

cd -
