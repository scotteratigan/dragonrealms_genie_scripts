#REQUIRE Info.cmd
#REQUIRE Send.cmd

gosub Stance %0
exit

Stance:
	var Stance.option $0
	if ("%Stance.option" == "$stance") then gosub Info Setting stance %Stance.option but stance is already $stance.
	action put #tvar stance $1 when ^You are now set to use your (.+) stance:
	gosub Send W "stance %Stance.option" "^Last Combat Maneuver:|^\s*Block\s+:|^Your .+ is now set at|^Setting your Evasion stance to|^Viewing \w+ preset \.\.\.|^Your \w+ preset is now saved" "^You must specify a number between 0 and 100\.$|^You do not have enough points to allocate"
	if (%Send.success == 0) then {
		gosub Stance evasion
	}
	action remove ^You are now set to use your (.+) stance:
	return