#REQUIRE Climb.cmd
#REQUIRE Close.cmd
#REQUIRE Nounify.cmd
#REQUIRE Open.cmd
#REQUIRE Pull.cmd
#REQUIRE Retreat.cmd
#REQUIRE Send.cmd
#REQUIRE Stand.cmd
#REQUIRE Stow.cmd

gosub Move %0
exit

Move:
	var Move.command $0
	var Move.success 0
	# Note: I'd love to match the ^You lurch/run/wander <direction> line because that won't get fooled by a look command.
	# However, the issue is that when you GO through a portal or CLIMB, there is no text returned except the new room.
	# ^Obvious (paths|exits):|^Ship paths:|^It's pitch dark
Moving:
	if (!$standing) then gosub Stand
	if (contains("$lefthand $righthand", "fishing pole")) then {
		gosub Pull my fishing pole
		gosub Stow my fishing pole
	}
	gosub Send Q "%Move.command" "^Obvious (paths|exits):|^Ship paths:|^It's pitch dark" "^You must be standing to do that\.$|^Stand up first\.$|^You can't do that while (kneeling|lying down|sitting)\!$|^You notice .+ at your feet, and do not wish to leave it behind\.$|^You're still recovering from your recent (attack|cast)\.$|^You are engaged to|^You can't do that while engaged\!$|^You can't go there\.$|^You will have to climb that\.$|^An attendant approaches you and says, .Unfortunately, this shop is closed at the moment\..$|^Running heedlessly over the rough terrain, you trip over an exposed root and are sent flying .+\.$|^You can't just leave your .+ lying on the floor\!$|^You must close the vault before leaving\!$|^Bonk\! You smash your nose\.$|^The .+ is closed\.$|^The .+ seems to be closed\.$|^You can't do that while entangled in a web\.$|^Sorry, they won't let you back in for awhile\.$"
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
	if (matchre("%Send.response", "^You're still recovering from your recent (attack|cast)\.$|^You can't do that while entangled in a web\.$")) then {
		pause .2
		goto Moving
	}
	if (matchre("%Send.response", "^You are engaged to|^You can't do that while engaged\!$")) then {
		gosub RetreatQuickly
		goto Moving
	}
	if (matchre("%Send.response", "^You must be standing to do that\.$|^Stand up first\.$|^Running heedlessly over the rough terrain, you trip over an exposed root and are sent flying .+\.$|^You can't do that while (kneeling|lying down|sitting)\!$")) then {
		gosub Stand
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
	if (matchre("%Send.response", "^You can't just leave your (.+) lying on the floor\!")) then {
		# Trying to leave the vault with items on the ground. No idea what to do so stow the items.
		var Move.itemAtFeet $1
		gosub Nounify %Move.itemAtFeet
		var Move.itemAtFeet %Nounify.noun
		gosub Stow %Move.itemAtFeet
		goto Moving
	}
	if ("%Send.response" == "You must close the vault before leaving!") then {
		# Trying to leave the vault with items on the ground. No idea what to do so stow the items.
		gosub Close vault
		goto Moving
	}
	if (matchre("%Send.response", "^The .+ is closed.$|^The .+ seems to be closed\.$|^Bonk\! You smash your nose\.$")) then {
		# Hmm, portal was closed. Maybe I can open it?
		eval Move.portal replacere("%Move.command", "^go ", "")
		gosub Open %Move.portal
		if ("%Open.success" == "1") then goto Moving
		return
	}
	if ("%Send.response" == "Sorry, they won't let you back in for awhile.") then {
		pause 15
		goto Moving
	}
	return