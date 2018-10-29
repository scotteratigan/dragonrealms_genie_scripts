#REQUIRE Climb.cmd
#REQUIRE Nounify.cmd
#REQUIRE Retreat.cmd
#REQUIRE Send.cmd
#REQUIRE Stand.cmd
#REQUIRE Stow.cmd

gosub Move %0
exit

Move:
	var Move.command $0
	var Move.success 0
Moving:
	if (!$standing) then gosub Stand
	gosub Send Q "%Move.command" "$moveSuccessStrings" "^You must be standing to do that\.$|^Stand up first\.$|^You should stop practicing your Athletics skill before you do that\.$|^You notice .+ at your feet, and do not wish to leave it behind\.$|^You're still recovering from your recent (attack|cast)\.$|^You are engaged to|^You can't do that while engaged\!$|^You can't go there\.$|^You will have to climb that\.$|^An attendant approaches you and says, .Unfortunately, this shop is closed at the moment\..$|^Running heedlessly over the rough terrain, you trip over an exposed root and are sent flying .+\.$"
	if (%Send.success) then {
		var Move.success 1
		return
	}
	if (matchre("%Send.response", "^You notice (.+) at your feet, and do not wish to leave it behind\.$")) then {
		# Note: works with multiple items at feet, one at a time. Could code a special routine to be slightly faster, but this is a rare case and the current solution works well.
		var Move.itemAtFeet $1
		gosub Nounify %Move.itemAtFeet
		var Move.itemAtFeet %Nounify.noun
		if (!contains("$righthand $lefthand", "Empty")) then {
			gosub Stow right
			gosub Stow left
		}
		gosub Stow %Move.itemAtFeet
		goto Moving
	}
	if (matchre("%Send.response", "^You're still recovering from your recent (attack|cast)\.$")) then {
		pause .2
		goto Moving
	}
	if (matchre("%Send.response", "^You are engaged to|^You can't do that while engaged\!$")) then {
		gosub RetreatQuickly
		goto Moving
	}
	if (matchre("%Send.response", "^You must be standing to do that\.$|^Stand up first\.$|^Running heedlessly over the rough terrain, you trip over an exposed root and are sent flying .+\.$")) then {
		gosub Stand
		goto Moving
	}
	if (matchre("%Send.response", "^You should stop practicing your Athletics skill before you do that\.$")) then {
		# todo: should this be in the generic send routine?
		# todo: add Stop.cmd and gosub it here
		put send stop practicing
		wait
		goto Moving
	}
	if (matchre("%Send.response", "^You will have to climb that\.$")) then {
		var Move.climbCommand %Move.command
		# todo: test this - ensure no infinite loop.
		eval Move.climbCommand replacere("%Move.climbCommand", "^go ", "")
		gosub Climb %Move.climbCommand
		if ("%Climb.success" == "1") then var Move.success 1
		return
	}
	return