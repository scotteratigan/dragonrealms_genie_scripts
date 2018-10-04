#REQUIRE Send.cmd
gosub DODGE
exit

DODGE:
	gosub Send RT "dodge" "^Roundtime:" "^But you are already dodging\!$"
	return