#REQUIRE Move.cmd

gosub North $0
exit

North:
	var North.option $0
Northing:
	# todo: add in checks for dragging items or sneaking.
	gosub Move north %North.option
	return