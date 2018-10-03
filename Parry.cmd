#REQUIRE Send.cmd

gosub PARRY
exit

PARRY:
	gosub Send RT "parry" "^Roundtime:" "^You are already in a position to parry\.$"
	return