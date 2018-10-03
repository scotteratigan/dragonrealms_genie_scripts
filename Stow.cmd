#REQUIRE Send.cmd

gosub STOW %0
exit

STOW:
	var STOW.command $0
STOWING:
	gosub Send Q "stow %STOW.command" "^You pick up|^You put your" "^But that's closed\.$|^I can't find your container for stowing things in\!  Type STORE HELP for information on how to set up your containers\.$"
	# todo: open closed container... need to determine where it was attempting to stow however.
	# todo: if default store isn't set, look for a backpack in inventory and set it (will require a new STORE script, plus a script to get inventory items)
	# Need to match ^You pick up for stowing coins, but delay until next line is processed in the normal case of stowing an item into a container.
	if (matchre("%SEND.message", "^You pick up")) then delay .02
	return