#REQUIRE Move.cmd

gosub Up $0
exit

Up:
	var Up.option $0
Uping:
	gosub Move up %Up.option
	return