#REQUIRE Send.cmd

gosub Drop %0
exit

Drop:
	var Drop.item $0
	var Drop.success 0
Droping:
	# todo: set a var for dropping a shoplifted item? ^You think better of leaving this evidence out where anyone can see it, and stuff it somewhere out of sight\.$
	# todo: add check for items we should never drop. (Or whitelist ones we can drop?)
	gosub Send RT "drop %Drop.item" "^You drop|^You spread .+ on the ground\." "^A guard steps over to you and says, .No littering in the bank\..$|^Trying to go unnoticed, are you\?$" ""
	# No idea what the unnoticed string is from.
	if (%Send.success == 1) then var Drop.success 1
	return