#REQUIRE Move.cmd

gosub Out %0
exit

Out:
	var Out.option $0
Outing:
	gosub Move out %Out.option
	return