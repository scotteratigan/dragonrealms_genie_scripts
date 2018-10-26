#REQUIRE Loot.cmd

gosub CheckLoot %0
exit

CheckLoot:
	var CheckLoot.option $0
	if contains("$roomobjs", "dead") then gosub Loot %CheckLoot.option
	return