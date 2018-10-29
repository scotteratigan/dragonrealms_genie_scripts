#REQUIRE Move.cmd

gosub Northwest %0
exit

Northwest:
	var Northwest.option $0
Northwesting:
	# todo: add in checks for dragging items or sneaking.
	gosub Move northwest %Northwest.option
	return