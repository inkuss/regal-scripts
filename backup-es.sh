#! /bin/bash

scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $scriptdir
source variables.conf

function init(){
    echo "Init"
    echo "Please do apt install jq"
    mkdir -p $REGAL_BACKUP/elasticsearch
    echo "Please do apt install jq"
    echo "Please do chown -R elasticsearch $REGAL_BACKUP/elasticsearch"
    curl -XPUT $ELASTICSEARCH/_snapshot/my_backup -d'{"type":"fs","settings":{"compress":true,"location":"$REGAL_BACKUP/elasticsearch"}}}'
    echo "Done!"
}

function clean(){
    echo "Clean"
    # The amount of snapshots we want to keep.
    LIMIT=30
    # Name of our snapshot repository
    REPO=my_backup
    # Get a list of snapshots that we want to delete
    SNAPSHOTS=`curl -s -XGET "$ELASTICSEARCH/_snapshot/$REPO/_all" \
  | jq -r ".snapshots[:-${LIMIT}][].snapshot"`

    # Loop over the results and delete each snapshot
    for SNAPSHOT in $SNAPSHOTS
    do
	echo "Deleting snapshot: $SNAPSHOT"
	curl -s -XDELETE "$ELASTICSEARCH/_snapshot/$REPO/$SNAPSHOT?pretty"
    done
    echo "Done!"
}

function backup(){
    echo "Backup"
    SNAPSHOT=`date +%Y%m%d-%H%M%S`
    curl -XPUT "$ELASTICSEARCH/_snapshot/my_backup/$SNAPSHOT?wait_for_completion=true"
    echo "Done!"
}


function restore(){
    echo "Restore"
    #
    # Restore a snapshot from our repository
    SNAPSHOT=123

    # We need to close the index first
    curl -XPOST "$ELASTICSEARCH/my_index/_close"

    # Restore the snapshot we want
    curl -XPOST "http://$ELASTICSEARCH/_snapshot/my_backup/$SNAPSHOT/_restore" -d '{
 "indices": "my_index"
}'

    # Re-open the index
    curl -XPOST '$ELASTICSEARCH/my_index/_open'
    echo "Done!"
}

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -i|--init)
	init;
    shift # past argument
    ;;
    -b|--backup)
	backup;
    shift # past argument
    ;;
    -r|--restore)
	restore
    shift # past argument
    ;;
    -c|--clean)
	clean
    shift # past argument
    ;;
    *)
       # unknown option
      echo "Use --init|--backup|--clean|--restore"     
    ;;
esac
shift # past argument or value
done

cd -
