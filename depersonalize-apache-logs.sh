#! /bin/bash

#
# Author: Jan Schnasse
#

# only work on files older then $days 
days=7
# look for files in this directory
logDir="/var/log/apache2/"
# with this extension 
extension="*.gz"
# depersonalize by replacing the last two bytes of an IP with this string
anoBytes=".0.0"
# define how to behave after anonymizing 
function postProcess(){
  echo Please remove $1 
  #rm -f $1
}

#-----------config end-----------------


# Generate list of files to work on
filesToAnnonymize=`find $logDir -type f -name $extension -mtime +$days`

# Test if
if touch $logDir/.annonymize-apache-logs.sh.test > /dev/null 2>&1
then
	rm $logDir/.annonymize-apache-logs.sh.test
else
	echo "You don't have permission to write into $logDir"
	exit 1;
fi

#Work through each file
for file in `echo $filesToAnnonymize`
do
	# echo Analyse $file
	# Hashmap to collect ips
 	declare -A anoIps
	# List all ips from $file
	ips=`zgrep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' $file`
	for ip in `echo $ips`
	do
		#anonymize
		anoIp=`echo $ip|grep -Eo '^[0-9]{1,3}\.[0-9]{1,3}'`
		anoIp=${anoIp}${anoBytes}
                #collect
		anoIps[$ip]=$anoIp;
	done

	for key in "${!anoIps[@]}"
	do
	    # echo "Going to replace all $key with ${anoIps[$key]} in $file" 
	    zcat $file| replace $key ${anoIps[$key]} |gzip > ${file%.*}.ano.gz  
	done
    	postProcess $file
done
