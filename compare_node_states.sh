## CHECK TO SEE IF THE STATE_PREVIOUS_FILE EXISTS; IF SO COMPARE IT TO THE STATE_CURRENT_FILE
# NOTE: If the STATE_PREVIOUS_FILE does NOT exist, or if there are new nodes down/down* then
# we need to prepare and send a report. If either is the case, we'll proceed past this section.
if [[ -f $STATE_PREVIOUS_FILE ]]; then
	grep -v -f $STATE_PREVIOUS_FILE $STATE_CURRENT_FILE >> "$NEW_NODES_FILE"
	# If there are no new nodes, then exit (no need to report).
	are_new_nodes=$(cat $NEW_NODES_FILE)
	if [[ -z $are_new_nodes ]]; then
		# Make the current state the new previous state for the next run.
		cp $STATE_CURRENT_FILE $STATE_PREVIOUS_FILE
		exit 0
	fi
fi
