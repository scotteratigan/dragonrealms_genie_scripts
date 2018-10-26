#REQUIRE Coil.cmd
#REQUIRE Error.cmd
##REQUIRE Nounify.cmd
##REQUIRE Open.cmd
#REQUIRE Send.cmd
gosub Stow %0
exit

Stow:
	var Stow.command $0
Stowing:
	gosub Send Q "stow %Stow.command" "^You pick up .+$|^You put your .+$" "^But that's closed\.$|^I can't find your container for stowing things in\!  Type STORE HELP for information on how to set up your containers\.$|^You just can't get the .+ to fit|^That's too heavy to go in there\!$" "^The.+rope is too long, even after stuffing it, to fit in the .+\.$"
	# todo: open closed container... need to determine where it was attempting to stow however.
	# todo: if default store isn't set, look for a backpack in inventory and set it (will require a new STORE script, plus a script to get inventory items)
	# Need to match ^You pick up for stowing coins, but delay until next line is processed in the normal case of stowing an item into a container.
	if (matchre("%Send.response", "^You pick up")) then delay .02
	if (matchre("%Send.response", "^You just can't get the \S+ (\bbox\b|\bcaddy\b|\bcasket\b|\bchest\b\b|\bcoffer\b|\bcrate\b|\bskippet\b|\bstrongbox\b|\btrunk\b) to fit in .+, no matter how you arrange it\.$")) then {
		gosub Error %Send.response - Dropping box instead.
		gosub drop my $0
	}
	# Todo: if stow container is closed, open it.
	# Much more difficult than it sounds, because you don't know which container, and not necessarily specified in command (although if specified, that part is easier, still need to parse the string.)
	# Would need to determine item type, and store container.
	#if ("%Send.response" == "But that's closed.") {
	#	gosub 
	#}

	if (matchre("%Send.response", "^The.+rope is too long")) then {
		gosub Coil my rope
		goto Stowing
	}
	return

#	matchre StowTooHeavy ^That's too heavy to go in there\!$
#	matchre StowNoRoomForBox 
#	matchre StowNoRoom ^There isn't any more room in the .+ for that\.$
#	matchre StowPause ^You stop as you realize
#	matchre StowGemPouchFull ^You've already got a wealth of gems in there\!  You'd better tie it up before putting more gems inside\.$
#	matchre StowError ^Stow what\?  Type 'STOW HELP' for details\.$|^But that is already in your inventory\.$
#	matchre StowError ^You are missing your (left|right) hand and your (left|right) hand is full\.  You need a free hand for that\.$
#	matchre GetItemLimit ^Picking up .+ would push you over the item limit of \d+ items\.  Please reduce your inventory count before you try again\.
#	matchre CoilRope ^The heavy rope is too long, even after stuffing it, to fit in the .+\.$
#	matchre StowCarvingItem ^The .+ will probably just damage the bundle and its contents\.  You should really only put skins, pelts, and the like in there\.$
#	matchre Stowed ^You put your
#	matchre Stowed ^You open your pouch and put the .+ inside, closing it once more\.$
#	matchre Stowed ^As you reach for .+, it wavers and fades into nothingness\.$
#	matchre Stowed ^The .+ slides easily into the celpeze-hide bandolier\.  Strangely, the bandolier doesn't seem any fuller\.$
#	matchre Stowed ^You carefully fit .+ into your .+\.$
#	matchre StowPause $RetryStrings
#	matchre StowUnloadFirst ^You should unload the|^You need to unload the
#	matchre StowNoContainer ^I can't find your container for stowing things in\!  Type STORE HELP for information on how to set up your containers\.$