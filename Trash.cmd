#REQUIRE Drop.cmd
#REQUIRE Information.cmd
#REQUIRE Put.cmd
#REQUIRE Send.cmd

gosub Trash %0
exit

Trash:
	var Trash.item $0
	var Trash.success 0
	var Trash.receptacle null
	# Check $roomobjs for a recognizable trash receptacle:
	if (contains("$roomobjs", "a bottomless pit")) then var Trash.receptacle bottomless pit
	if (contains("$roomobjs", "a deep oak bucket")) then var Trash.receptacle oak bucket
	if (contains("$roomobjs", "a dented metal bucket")) then var Trash.receptacle metal bucket
	if (contains("$roomobjs", "a garbage bin")) then var Trash.receptacle garbage bin
	if (contains("$roomobjs", "a garbage chute")) then var Trash.receptacle garbage chute
	if (contains("$roomobjs", "a gem-encrusted bucket of viscous goop")) then var Trash.receptacle gem-encrusted bucket
	if (contains("$roomobjs", "a gloop bucket")) then var Trash.receptacle gloop bucket
	if (contains("$roomobjs", "a hollow tree stump")) then var Trash.receptacle tree stump
	if (contains("$roomobjs", "a large barrel")) then var Trash.receptacle large barrel
	if (contains("$roomobjs", "a large waste bucket")) then var Trash.receptacle bucket
	if (contains("$roomobjs", "a waste basket")) then var Trash.receptacle waste basket
	if (contains("$roomobjs", "a waste bin")) then var Trash.receptacle waste bin
	if (contains("$roomobjs", "a waste bucket")) then var Trash.receptacle waste bucket
	if (contains("$roomobjs", "an ivory urn")) then var Trash.receptacle ivory urn
	if (contains("$roomobjs", "bucket of viscous gloop")) then var Trash.receptacle bucket
	if (contains("$roomobjs", "driftwood log")) then var Trash.receptacle driftwood log
	if (contains("$roomobjs", "a bucket of pumpkin-colored viscous gloop")) then var Trash.receptacle bucket
	# Thieves' Guild bucket is not in roomobjs:
	if (contains("$roomdesc", "A polished silver bucket sits to one side.")) then var Trash.receptacle silver bucket
Trashing:
	if ("%Trash.receptacle" != "null") then {
		gosub Put %Trash.item in %Trash.receptacle
		var Trash.response %Put.response
		if ("%Put.success" == "1") then {
			var Trash.success 1
			return
		}
	}
	gosub Information Could not find trash can, so I'm littering my %Trash.item.
	gosub Drop %Trash.item
	var Trash.response %Drop.response
	if ("%Drop.success" == "1") then var Trash.success 1
	return