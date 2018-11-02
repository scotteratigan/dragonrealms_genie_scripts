#REQUIRE Tend.cmd
#REQUIRE Health.cmd

gosub TendLeeches %0
exit

TendLeeches:
	var TendLeeches.bodyPartsList head|left eye|right eye|neck|chest|abdomen|back|left arm|right arm|left leg|right leg|tail|skin
	gosub Health
	if ("%Health.leechList" == "") then return
	#var TendLeeches.success 0 <- can't really have success var until I identify failure text
	eval TendLeeches.maxIndex count("%Health.leechArray", "|")
	var TendLeeches.index 0
TendingLeeches:
	eval TendLeeches.currentLocation element("%Health.leechArray", %TendLeeches.index)
	if (matchre("%TendLeeches.currentLocation", "(%TendLeeches.bodyPartsList)")) then var TendLeeches.currentLocation $1
	gosub Tend my %TendLeeches.currentLocation
	math TendLeeches.index add 1
	if (%TendLeeches.index <= %TendLeeches.maxIndex) then goto TendingLeeches
	return