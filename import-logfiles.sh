#! /bin/bash
set -euo pipefail
IFS=$'\n\t'

scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $scriptdir
source variables.conf

YESTERDAY=$(date +"%d/%b" -d"yesterday")    
TMP=$REGAL_TMP
IDSITE=4
STATS_LOG=$REGAL_LOGS/stats.log

function loadLogFile() {
    PATTERN=$1
    zgrep $PATTERN /var/log/apache2/other_vhosts_access.log.* > $TMP/matomoImport.log
    python /opt/regal/piwik/misc/log-analytics/import_logs.py --recorder-max-payload-size=200 --url $PIWIK_URL --login $MATOMO_ADMIN --password $MATOMO_PASSWORD $TMP/matomoImport.log --idsite=$IDSITE >> $STATS_LOG
}

loadLogFile "$YESTERDAY/[0-9][0-9][0-9][0-9]"

cd -
# Beispiel um die Logfiles der letzten 24 Tage zu laden
#
#for i in {1..24};do echo loadLogFile "$(date +"%d/%b" -d"$i days ago")/[0-9][0-9][0-9][0-9]";done

