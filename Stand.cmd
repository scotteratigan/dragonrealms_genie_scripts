#REQUIRE Send.cmd

gosub Stand %0
exit

Stand:
	var Stand.option $0
Standing:
	gosub Send Q "stand %Stand.option" "^You stand back up\.$|^You are already standing\.$" "^You try, but in the cramped confines of the tunnel, there's just no room to do that\.$|^You begin to get up and \*\*SMACK\!\*\* your head against the rock ceiling\.$"
	return