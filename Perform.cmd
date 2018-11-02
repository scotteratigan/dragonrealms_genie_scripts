#REQUIRE Send.cmd

# Note: currently only implemented for perform consume. Need to add lots of additional options.

gosub Perform %0
exit

Perform:
	var Perform.command $0
	var Perform.success 0
	var Perform.target null
	action var Perform.target $1 when ^You kneel over the (.+)'s corpse and make a few quick, precise cuts.*$
Performing:
	gosub Send RT "perform %Perform.command" "^You kneel over the .+'s corpse and make a few quick, precise cuts.*$" "^This ritual may only be performed on a corpse\.$|^This corpse has already been prepared for consumption." ""
	action remove ^You kneel over the (.+)'s corpse and make a few quick, precise cuts.*$
	if ("%Send.success" == "1") then {
		var Perform.success 1
		return
	}
	return