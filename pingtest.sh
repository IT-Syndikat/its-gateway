#!/bin/bash

LOG="ping.log"

while true; do
	ping -c 1 8.8.8.8 &> /dev/null
	if [[ $? -eq 0 ]]; then
		echo -n $(date) >> $LOG
		echo -e "\tworking" >> $LOG
	else
		echo -n $(date) >> $LOG
		echo -e "\tnot working" >> $LOG
	fi
	sleep 1
done
