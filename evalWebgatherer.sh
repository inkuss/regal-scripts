#!/bin/bash
# Auswertung von Log-File webgatherer.log
#| Autor              | Datum      | Beschreibung
#+--------------------+------------+-----------------------------------------
#| I. Kuss            | 02.06.2016 | Neuerstellung
#| I. Kuss            | 12.01.2018 | Auslagerung von Systemvariablen
#+--------------------+------------+-----------------------------------------
#
# Der Pfad, in dem dieses Skript steht
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $scriptdir
source variables.conf
echo "AUSWERTUNG WEBGATHERER.log : "
LOG=$REGAL_APP_LOGS/webgatherer.log
echo "Anzahl gefundener   Sites: " `cat $LOG | grep -o "Found .* webpages"`
echo "Anzahl berabeiteter Sites: " `cat $LOG | grep -c "Precount: "`
echo "Websites, die jetzt eingesammelt werden sollen: Anzahl:" `cat $LOG | grep -c "Die Website $INDEXNAME:.* soll jetzt eingesammelt werden\."`
echo "Davon nicht erfolgreich eingesammelt:"
echo "  - Site unbekannt verzogen.                    Anzahl:" `cat $LOG | grep -c "De Sick $INDEXNAME:.* is unbekannt vertrocke !"`
echo "  - Site umgezogen (wartet auf Bestaetigung).   Anzahl:" `cat $LOG | grep -c "De Sick $INDEXNAME:.* is umjetrocke noh"`
echo "  - Webgatherer ist zu beschaeftigt.            Anzahl:" `cat $LOG | grep -c "Webgathering for $INDEXNAME:.* stopped! Heritrix is too busy\."`
echo "  - Fehlgeformte URL.                           Anzahl:" `cat $LOG | grep -c "Fehlgeformte URL bei $INDEXNAME:.* !"`
echo "  - Ungueltige URL. Neue URL unbekannt.         Anzahl:" `cat $LOG | grep -c "Ungültige URL. Neue URL unbekannt für $INDEXNAME:.* !"`
echo "  - Version konnte nicht angelegt werden.       Anzahl:" `cat $LOG | grep -c "Couldn't create webpage version for"`
echo "Davon erfolgreich eingesammelt:                 Anzahl:" `cat $LOG | grep -c "Version $INDEXNAME:.* zur Website $INDEXNAME:.* erfolgreich angelegt!"`
echo "******* ENDE Zaehlsummen *******"
echo "******* Die Sites im Einzelnen: ******"
echo "Websites, die jetzt eingesammelt werden sollen:"
cat $LOG | grep "Die Website $INDEXNAME:.* soll jetzt eingesammelt werden\."
echo "Davon nicht erfolgreich eingesammelt:"
cat $LOG | grep "De Sick $INDEXNAME:.* is unbekannt vertrocke !"
cat $LOG | grep "De Sick $INDEXNAME:.* is umjetrocke noh"
cat $LOG | grep "Webgathering for $INDEXNAME:.* stopped! Heritrix is too busy\."
cat $LOG | grep "Fehlgeformte URL bei $INDEXNAME:.* !"
cat $LOG | grep "Ungültige URL. Neue URL unbekannt für $INDEXNAME:.* !"
cat $LOG | grep "Couldn't create webpage version for"
echo "Davon erfolgreich eingesammelt:"
cat $LOG | grep "Version $INDEXNAME:.* zur Website $INDEXNAME:.* erfolgreich angelegt!"

# echo "Neu gestartete Crawls mit ID; Anzahl:" `cat $LOG | grep -c "Create new version for:.*"`
# cat $LOG | grep -o "Create new version for:.*"
# echo "Fehlermeldungen; Anzahl:" `cat $LOG | grep -c "ERROR"`
# cat $LOG | grep "ERROR"
# echo "Demnächst anstehende Gatherläufe: Anzahl:" `cat $LOG | grep -c "will be launched next time at"`
# echo "Anstehende sortiert nach Zeitpunkt:"
# cat $LOG | grep -o "will be launched next time at.*" | sort
echo "ENDE AUSWERTUNG WEBGATHERER.log"
