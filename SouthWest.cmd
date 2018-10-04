#REQUIRE Move.cmd

gosub SouthWest $0
exit

SouthWest:
	var SouthWest.option $0
SouthWesting:
	# todo: add in checks for dragging items or sneaking.
	gosub Move southwest %SouthWest.option
	return