#! /bin/bash

scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $scriptdir
source variables.conf
mysql -uoaidnb -p$REGAL_PASSWORD -e"DELETE from oaidnb.rcFailure;"
cd -
