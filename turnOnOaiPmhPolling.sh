#! /bin/bash

scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $scriptdir
source variables.conf

mysql -uproai -pproaipwd -e"UPDATE proai.rcAdmin SET pollingEnabled=1;"

