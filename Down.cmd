#REQUIRE Move.cmd

gosub Down %0
exit

Down:
	var Down.option $0
Downing:
	gosub Move down %Down.option
	return