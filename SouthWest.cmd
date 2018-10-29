#REQUIRE Move.cmd

gosub Southwest %0
exit

Southwest:
	var Southwest.option $0
Southwesting:
	# todo: add in checks for dragging items or sneaking.
	gosub Move southwest %Southwest.option
	return