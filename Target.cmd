#REQUIRE Send.cmd

gosub Target %0
exit

Target:
	var Target.command $0
	var Target.success 0
	var Target.enemyTargeted null
	action var Target.enemyTargeted $1 when ^You begin to weave mana lines into a target pattern around (.+)\.$
Targeting:
	gosub Send Q "target %Target.command" "^You begin to weave mana lines into a target pattern around (.+)\.$" "^You must be preparing a spell in order to target it\!$|^This spell cannot be targeted\.$|^You are not engaged to anything, so you must specify a target to focus on\!$" "WARNING MESSAGES"
	action remove ^You begin to weave mana lines into a target pattern around (.+)\.$
	var Target.response %Send.response
	if ("%Send.success" == "1") then {
		var Target.success 1
		return
	}
	return