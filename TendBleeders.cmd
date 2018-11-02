#REQUIRE Tend.cmd
#REQUIRE Health.cmd

gosub TendBleeders %0
exit

TendBleeders:
	gosub Health
	if ("%Health.bleederList" == "") then return
	#var TendBleeders.success 0 <- can't really have success var until I identify failure text
	eval TendBleeders.maxIndex count("%Health.bleederArray", "|")
	var TendBleeders.index 0
TendingBleeders:
	eval TendBleeders.currentLocation element("%Health.bleederArray", %TendBleeders.index)
	if (matchre("%TendBleeders.currentLocation", "(%TendBleeders.bodyPartsList)")) then var TendBleeders.currentLocation $1
	gosub Tend my %TendBleeders.currentLocation
	if (matchre("%Tend.response", "^Your .+ is too injured for you to do that\.$")) then {
		var Tend.success 0
		return
	}
	math TendBleeders.index add 1
	if (%TendBleeders.index <= %TendBleeders.maxIndex) then goto TendingBleeders
	return