#! /bin/bash

scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $scriptdir
source variables.conf

YESTERDAY=$(LANG=en;date +"%d/%b/%Y" -d"yesterday")    
IDSITE=4
STATS_LOG=$REGAL_LOGS/stats.log

function loadLogFile() {
    PATTERN=$1
    echo Lade $PATTERN >> $STATS_LOG
    zgrep --no-filename $PATTERN /var/log/apache2/other_vhosts_access.*|sort|uniq > $REGAL_TMP/matomoImport.log
    python $MATOMO/misc/log-analytics/import_logs.py --recorder-max-payload-size=200 --url $MATOMO_URL --login $MATOMO_ADMIN --password $MATOMO_PASSWORD $REGAL_TMP/matomoImport.log --idsite=$IDSITE >> $STATS_LOG
}

loadLogFile "$YESTERDAY"
# Beispiel um die Logfiles der letzten 10-40 Tage zu laden
#
#for i in {10..40};do loadLogFile "$(LANG=en;date +"%d/%b/%Y" -d"$i days ago")";done

# Beispiel um die Differenz in Tagen auszurechnen
#
# A="2018-01-21"
# B="2018-04-08"
# echo $(( (`date -d $B +%s` - `date -d $A +%s`) / 86400 )) days

cd -
