#REQUIRE Block.cmd
#REQUIRE Face.cmd
#REQUIRE Send.cmd
#REQUIRE Waitforre.cmd

gosub AdvanceMelee %0
exit

Advance:
	var Advance.option $0
	if ($monstercount < 1) then gosub Error Advancing with monstercount < 1.
	gosub Send Q "advance %Advance.option" "^You are already at melee with.*$|^You begin to advance on.*$|^You are already advancing on.*$|^You begin to stealthily advance on.*$|^You spin around to face .+\.$" "^What do you want to advance towards\?$|^The .+ is already quite dead\.$|^You have lost sight of your target, so you stop advancing\.$|^You will have to retreat from your current melee first\.$|^You had better stand up first\.$"
	var Advance.response %Send.response
	if ("%Send.response" == "You had better stand up first.") then {
		gosub Stand
		if (%Stand.success == 1) then goto Advance
	}
	return

AdvanceMelee:
	# Calls Advance until at melee range.
	var AdvanceMelee.option $0
AdvancingToMelee:
	gosub Advance %AdvanceMelee.option
	if (matchre("%Send.response", "^You are already at melee with|^You spin around to face")) then {
		var AdvanceMelee.success 1
		return
	}
	if (matchre("%Send.response", "^You will have to retreat from your current melee first\.$")) then {
		gosub Block stop
		goto AdvancingToMelee
	}
	if (%Send.success == 0) then {
		if ($monstercount > 0) then {
			gosub Face next
			gosub AdvanceMelee
		}
		else {
			var AdvanceMelee.success 0
			return
		}
	}
	gosub Waitforre 15 "^You close to melee range on .+\.$|^The .+ stops you from advancing any farther\!$|^You have lost sight of your target, so you stop advancing\.$|closes to melee range on you\.$"
	if (matchre("%Waitforre.response", "^You close to melee|^You are already at melee|advance towards\?$|already quite dead\.$|you stop advancing\.$")) then return
	goto AdvancingToMelee

AdvancePole:
	var AdvancePole.option $0
AdvancingToPole:
	gosub Advance %AdvancePole.option
	if (matchre("%Send.response", "^You are already at melee with|^You spin around to face")) then {
		var AdvancePole.success 1
		return
	}
	if (matchre("%Send.response", "^You will have to retreat from your current melee first\.$")) then {
		gosub Block stop
		goto AdvancingToPole
	}
	gosub Waitforre 10 "^You close to .+ on .+\.$|^The .+ stops you from advancing any farther\!$|^You have lost sight of your target, so you stop advancing\.$|closes to melee range on you\.$"
	if (matchre("%Waitforre.response", "^You close to |^You are already at melee|advance towards\?$|already quite dead\.$|you stop advancing\.$")) then return
	goto AdvancingToPole