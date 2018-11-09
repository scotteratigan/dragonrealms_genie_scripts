#REQUIRE Send.cmd

gosub Stand %0
exit

Stand:
	var Stand.option $0
	var Stand.success 0
Standing:
	gosub Send Q "stand %Stand.option" "^You stand back up\.$|^You stand up in the water\.$" "The weight of all your possessions prevents you from standing\.$|^You are so unbalanced you cannot manage to stand\.$|^You try, but in the cramped confines of the tunnel, there's just no room to do that\.$|^You begin to get up and \*\*SMACK\!\*\* your head against the rock ceiling\.$|^This place is too small\.  You can't stand up in here\!$" "^You are already standing\.$"
	if (%Send.success == 1) then {
		var Stand.success 1
		return
	}
	if (matchre("%Send.response", "^The weight of all your possessions prevents you from standing\.$|^You are so unbalanced you cannot manage to stand\.$")) then goto Standing
	return