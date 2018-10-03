#REQUIRE Send.cmd

gosub STANCE %0
exit

STANCE:
	var STANCE.option $0
	gosub Send W "stance %STANCE.option" "^Last Combat Maneuver:|^\s+Block  :|^Your .+ is now set at|^Setting your Evasion stance to|^Viewing \w+ preset \.\.\.|^Your \w+ preset is now saved" "^You must specify a number between 0 and 100\.$|^You do not have enough points to allocate"
	if (%SEND.success == 0) then {
		gosub STANCE evasion
	}
	return