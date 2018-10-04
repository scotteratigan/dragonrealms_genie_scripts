#REQUIRE Send.cmd

gosub SKIN %0
exit

SKIN:
	var SKIN.option $0
	gosub Send RT "skin %SKIN.option" "^Roundtime: \d+ sec\.$|^The .+ cannot be skinned\.$|^The .+ has already been skinned\.$" "^Skin what\?$|^You can't skin something that's not dead\!$"
	# todo: add check for item not bundled here
	return


#>arrange kelpie
#The kelpie cannot be skinned, so you can't arrange it either.

#>arrange all kelp
#You don't know how to do that.

#You begin to arrange the boar's corpse in a manner that, while making the process of obtaining a part more difficult, guarantees a greater reward.
#Roundtime: 2 sec.

#You continue arranging the boar's corpse in a manner that, while making the process of obtaining a part more difficult, guarantees a greater reward.
#Roundtime: 2 sec.

#You complete arranging the boar's corpse in a manner that, while making the process of obtaining a part more difficult, guarantees a greater reward.
#Roundtime: 2 sec.

#That has already been arranged as much as you can manage.

#>arrange boar
#The boar's already been skinned, there's no point.