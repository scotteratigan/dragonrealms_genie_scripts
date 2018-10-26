#REQUIRE Move.cmd

gosub NorthWest %0
exit

NorthWest:
	var NorthWest.option $0
NorthWesting:
	# todo: add in checks for dragging items or sneaking.
	gosub Move northwest %NorthWest.option
	return