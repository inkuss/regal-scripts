#!/bin/bash
# Test Ausführen eines Befehls
# Autor               | Datum      | Beschreibung
# --------------------+------------+-----------------------------------------
# Ingolf Kuss         |            |
# --------------------+------------+-----------------------------------------

# Der Pfad, in dem dieses Skript steht
scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Einlesen der Umgebungsvariablen
cd $scriptdir
source variables.conf

# cmd="ls -l"
cmd=`curl -s -XPOST -uedoweb-admin:06edo11web13 "https://api.edoweb-test.hbz-nrw.de/utils/runGatherer"`
# echo "Führe folgendes Kommando aus: $cmd"
# run=`$cmd`
# echo "Ergebnis: $run\n";
echo "Ergebnis: $cmd\n";

