#REQUIRE Attack.cmd

gosub AttackUntilKill %0
exit

AttackUntilKill:
	var AttackUntilKill.option $0
AttackingUntilKill:
	gosub Attack %AttackUntilKill.option
	if (!contains("$roomobjs", "dead")) then goto AttackingUntilKill
	return