#REQUIRE Move.cmd

gosub NorthEast %0
exit

NorthEast:
	var NorthEast.option $0
NorthEasting:
	# todo: add in checks for dragging items or sneaking.
	gosub Move northeast %NorthEast.option
	return