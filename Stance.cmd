#REQUIRE Send.cmd

gosub Stance %0
exit

Stance:
	var Stance.option $0
	gosub Send W "stance %Stance.option" "^Last Combat Maneuver:|^\s+Block  :|^Your .+ is now set at|^Setting your Evasion stance to|^Viewing \w+ preset \.\.\.|^Your \w+ preset is now saved" "^You must specify a number between 0 and 100\.$|^You do not have enough points to allocate"
	if (%Send.success == 0) then {
		gosub Stance evasion
	}
	return