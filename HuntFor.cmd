#REQUIRE Hunt.cmd

# Hunt the surrounding rooms for a specified target.
# Example: gosub HuntFor Engineering Society Master Brogir

gosub HuntFor %0
exit

HuntFor:
	var HuntFor.prey $0
	var HuntFor.success 0
	var HuntFor.preyLocation null
	if (contains("$roomobjs", "%HuntFor.prey")) then {
		var HuntFor.success 1
		return
	}
	if (contains("$roomplayers", "%HuntFor.prey")) then {
		var HuntFor.success 1
		return
	}
	action var HuntFor.preyLocation $1 when ^\s+(\d+)\)   %HuntFor.prey
	gosub Hunt
	action remove ^\s+(\d+)\)   %HuntFor.prey
	if (%Hunt.success != 1) then return
	if ("%HuntFor.preyLocation" != "null") then {
		gosub Hunt %HuntFor.preyLocation
		if (%Hunt.success == 1) then var HuntFor.success 1
	}
	return