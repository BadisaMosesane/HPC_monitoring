## PREPARE AND SEND A REPORT
echo "To: $CONTACT" >> $MAIL_FILE
echo "Subject: LSST: new verify-worker nodes down according to Slurm" >> $MAIL_FILE
echo "From: $FROM" >> $MAIL_FILE
echo "" >> $MAIL_FILE
echo "The following new nodes are down/down* according to Slurm (down = unavailable for use, down* = down and not responding):" >> $MAIL_FILE
if [[ ! -f $NEW_NODES_FILE ]]; then
	touch $NEW_NODES_FILE
fi
for j in $(cat $NEW_NODES_FILE)
do
	if [[ -f $DOWN_NODES_CURRENT_FILE && $(grep ${j} $DOWN_NODES_CURRENT_FILE) ]]; then
		echo "${j} down" >> $MAIL_FILE
	elif [[ -f $DOWNSTAR_NODES_CURRENT_FILE && $(grep ${j} $DOWNSTAR_NODES_CURRENT_FILE) ]]; then
		echo "${j} down*" >> $MAIL_FILE
	else
		exit 1
	fi
done
for k in $(cat $STATE_CURRENT_FILE)
do
	if [[ ! $(grep ${k} $NEW_NODES_FILE) ]]; then
		echo "${k}" >> $OLD_NODES_FILE
	fi
done
if [[ -f $OLD_NODES_FILE ]]; then
	echo "" >> $MAIL_FILE
	echo "The following other nodes are still down/down* according to Slurm:" >> $MAIL_FILE
	for l in $(cat $OLD_NODES_FILE)
	do
		if [[ -f $DOWN_NODES_CURRENT_FILE && $(grep ${l} $DOWN_NODES_CURRENT_FILE) ]]; then
			echo "${l} down" >> $MAIL_FILE
		elif [[ -f $DOWNSTAR_NODES_CURRENT_FILE && $(grep ${l} $DOWNSTAR_NODES_CURRENT_FILE) ]]; then
			echo "${l} down*" >> $MAIL_FILE
		else
			exit 1
		fi
	done
fi
