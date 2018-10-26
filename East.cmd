#REQUIRE Move.cmd

#debuglevel 10
gosub East %0
exit

East:
	var East.option $0
Easting:
	# todo: add in checks for dragging items or sneaking.
	gosub Move east %East.option
	return