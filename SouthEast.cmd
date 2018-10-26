#REQUIRE Move.cmd

gosub SouthEast %0
exit

SouthEast:
	var SouthEast.option $0
SouthEasting:
	# todo: add in checks for dragging items or sneaking.
	gosub Move southeast %SouthEast.option
	return