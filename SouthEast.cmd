#REQUIRE Move.cmd

gosub Southeast %0
exit

Southeast:
	var Southeast.option $0
Southeasting:
	# todo: add in checks for dragging items or sneaking.
	gosub Move southeast %Southeast.option
	return