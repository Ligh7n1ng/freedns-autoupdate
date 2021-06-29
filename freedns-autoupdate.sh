#!/bin/bash

UpdateURL=$1
LogFile=$2

function PermErrorCheck {
    if [ $(echo $?) -ne 0 ]
    then
        echo -e "\nCan't create or modify log file ($LogFile). Not enough permissions?"
        exit 1
    fi
}

if [ $(echo "$UpdateURL" | grep http | wc -l) = 0 ]
then
    echo "Invalid or unspecified URL. Exiting..."
    exit 1
fi

test $LogFile

if [ $(echo $?) = 0 ]
then
    echo -e "Using "$LogFile" log file."
else
    LogFile="/var/log/freedns-autoupdate/ddns-ip.log"
    echo "Log file is not specified. Creating it in the default path $LogFile"
    
    test -f $LogFile
    
    if [ $(echo $?) -ne 0 ]
    then
    	echo "Test record" > $LogFile
	PermErrorCheck
    else 
	touch "$LogFile"
	PermErrorCheck
    fi
fi

LastIP=$(head -n 1 "$LogFile")
CurrentIP=$(curl -s https://api.ipify.org/)

if [ "$LastIP" = "$CurrentIP" ]
then
    echo "IP address has not been changed. No need to update."
else
    echo "IP address has been changed. Recording current IP ($CurrentIP) to log file."
    echo "$CurrentIP" > $LogFile
    PermErrorCheck
    echo "Updating DDNS..."
    curl -s $UpdateURL
    echo -e "\nDone."
fi

exit 0
