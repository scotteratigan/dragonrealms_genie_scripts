#REQUIRE Block.cmd
#REQUIRE Face.cmd
#REQUIRE Send.cmd

gosub ADVANCE_TO_MELEE %0
exit

ADVANCE:
	var ADVANCE.option $0
	if ($monstercount < 1) then gosub ERROR Advancing with monstercount < 1.
	gosub Send Q "advance %ADVANCE.option" "^You are already at melee with|^You begin to advance on|^You are already advancing on|^You begin to stealthily advance on|^You spin around to face .+\.$" "^What do you want to advance towards\?$|^The .+ is already quite dead\.$|^You have lost sight of your target, so you stop advancing\.$|^You will have to retreat from your current melee first\.$"
	return

ADVANCE_TO_MELEE:
	# Calls ADVANCE until at melee range.
		var ADVANCE_TO_MELEE.option $0
	ADVANCING_TO_MELEE:
		gosub Advance %ADVANCE_TO_MELEE.option
		if (matchre("%SEND.response", "^You are already at melee with|^You spin around to face")) then {
			var ADVANCE_TO_MELEE.success 1
			return
		}
		if (matchre("%SEND.response", "^You will have to retreat from your current melee first\.$")) then {
			gosub BLOCK stop
			goto ADVANCING_TO_MELEE
		}
		if (%SEND.success == 0) then {
			if ($monstercount > 0) then {
				gosub FACE next
				gosub ADVANCE_TO_MELEE
			}
			else {
				var ADVANCE_TO_MELEE.success 0
				return
			}
		}
		gosub WAITFORRE 15 "^You close to melee range on .+\.$|^The .+ stops you from advancing any farther\!$|^You have lost sight of your target, so you stop advancing\.$|closes to melee range on you\.$"
		echo Waitforre response is %WAITFORRE.response
		if (matchre("%WAITFORRE.response", "^You close to melee|^You are already at melee|advance towards\?$|already quite dead\.$|you stop advancing\.$")) then return
		goto ADVANCING_TO_MELEE