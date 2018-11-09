#REQUIRE Send.cmd

gosub Stir %0
exit

Stir:
	var Stir.command $0
	var Stir.success 0
Stiring:
	gosub Send RT "stir %Stir.command" "^With a shove, the crucible moves over a bed of hot coals and you watch as the contents begins to melt\.$|^Grunting, you begin stirring the contents of the crucible with your rod\.  Every so often you stop to wipe the end clean of accumulated slag.*$|^Using the rod as a lever, you walk around and slowly spin the crucible while mixing the contents inside.*$|^Using the stirring rod as a club, you smash apart several lumpy pieces of metal in the crucible\.  Satisfied, you dip the rod back in and slowly stir the mix around.*$|^You plunk the stirring rod down into the oozing metal and churn up the contents using a paddling motion, as though rowing a boat.*$" "FAIL MESSAGES" "WARNING MESSAGES"
	var Stir.response %Send.response
	if ("%Send.success" == "1") then {
		var Stir.success 1
		return
	}
	return