#REQUIRE Move.cmd

gosub South $0
exit

South:
	var South.option $0
Southing:
	# todo: add in checks for dragging items or sneaking.
	gosub Move south %South.option
	return