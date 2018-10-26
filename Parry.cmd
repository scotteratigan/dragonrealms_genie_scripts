#REQUIRE Send.cmd

gosub Parry
exit

Parry:
	gosub Send RT "parry" "^Roundtime:" "^You are already in a position to parry\.$"
	return