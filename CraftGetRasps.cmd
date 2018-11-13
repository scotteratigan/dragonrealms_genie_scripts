#REQUIRE Navigate.cmd
#REQUIRE Nod.cmd
#REQUIRE Stow.cmd

gosub CraftGetRasps
exit

CraftGetRasps:
	var CraftGetRasps.donorList Copernicus|Fynmenger
	var CraftGetRasps.donationItem rasp
	action var CraftGetRasps.donationComplete 1 when ^(%CraftGetRasps.donorList) nods to you\.$
	gosub Navigate 150 anvil1
	gosub CraftGetRaspsCheckForAlt
	gosub Navigate 150 anvil2
	gosub CraftGetRaspsCheckForAlt
	gosub Navigate 150 anvil3
	gosub CraftGetRaspsCheckForAlt
	action remove ^(%CraftGetRasps.donorList) nods to you\.$
	return
	
CraftGetRaspsCheckForAlt:
	var CraftGetRasps.donationComplete 0
	if ("$roomplayers" == "") then return
	var CraftGetRasps.donor null
	if (matchre("$roomplayers", "(%CraftGetRasps.donorList)")) then var CraftGetRasps.donor $1
	echo CraftGetRasps.donor %CraftGetRasps.donor
	if ("%CraftGetRasps.donor" == "null") then return
	gosub Nod %CraftGetRasps.donor
CraftGettingRasps:
	pause .25
	if (contains("$roomobjs", "%CraftGetRasps.donationItem")) then {
		gosub Stow %CraftGetRasps.donationItem
		goto CraftGettingRasps
		}
	if (%CraftGetRasps.donationComplete == 1) then return
	if (!contains("$roomplayers", "%CraftGetRasps.donor")) then return
	goto CraftGettingRasps