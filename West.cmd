#REQUIRE Move.cmd

gosub West %0
exit

West:
	var West.option $0
Westing:
	# todo: add in checks for dragging items or sneaking.
	gosub Move west %West.option
	return