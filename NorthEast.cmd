#REQUIRE Move.cmd

gosub Northeast %0
exit

Northeast:
	var Northeast.option $0
Northeasting:
	# todo: add in checks for dragging items or sneaking.
	gosub Move northeast %Northeast.option
	return