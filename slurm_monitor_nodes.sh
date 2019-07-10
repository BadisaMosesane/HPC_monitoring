## CHECK TO SEE IF NODES ARE DOWN AND REPORT INTO THE APPROPRIATE FILES
down_nodes_compact=$(sinfo | grep "down " | awk '{print $6}' | tr '\n' ',')
downstar_nodes_compact=$(sinfo | grep "down\* " | awk '{print $6}' | tr '\n' ',')

if [[ ! -z $down_nodes_compact ]]; then
	down_nodes_list=$(scontrol show hostname $down_nodes_compact | sort)
	for i in $down_nodes_list
	do
		# echo the node names into the file adding a comma to aid future parsing
		echo "${i}," >> $STATE_CURRENT_UNSORTED_FILE
		echo "${i}," >> $DOWN_NODES_CURRENT_FILE
	done
fi
