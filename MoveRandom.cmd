#REQUIRE Look.cmd
#REQUIRE Move.cmd
#REQUIRE NounifyList.cmd

# Usage:
# .moverandom
# .moverandom portals
# Note: portal setting is ignored if mapper's $roomid is 0 (aka we're lost).

gosub MoveRandom %0
exit

MoveRandom:
	#debuglevel 10
	eval MoveRandom.option tolower("$0")
	var MoveRandom.success 0
	var MoveRandom.potentialDirections 
	if ("$roomid" == "0") then {
		# I'm lost, move any which way I can in order to find my location. (ignore portal setting)
		# If we get lost in a room with a lot of junk it may be hard to leave. Todo: filter list with the portal nouns... wherever I put that.
		gosub Arrayify $roomobjs
		gosub NounifyList %Arrayify.list
		eval MoveRandom.roomObjs replacere("%NounifyList.list", "^|\|", "|go ")
		var MoveRandom.potentialDirections %MoveRandom.potentialDirections|%MoveRandom.roomObjs
	}
	evalmath MoveRandom.normalPortalCount $north + $northeast + $east + $southeast + $south + $southwest + $west + $northwest + $up + $down + $out
	echo normalPortalCount is %MoveRandom.normalPortalCount
	if (%MoveRandom.normalPortalCount == 0) then {
		# In rooms where roomexits are potentially broken, append manually:
		gosub Look
		if ("%Look.exits" != "null") then {
			var MoveRandom.potentialDirections %MoveRandom.potentialDirections|%Look.exits
			eval MoveRandom.potentialDirections replacere("%MoveRandom.potentialDirections", "\|", "|go ")
			# Note: can't grab text in a replacere ($1), and a matchre will only match once, so this is actually the best solution:
			#eval MoveRandom.potentialDirections replace("%MoveRandom.potentialDirections", "clockwise", "go clockwise")
			#eval MoveRandom.potentialDirections replace("%MoveRandom.potentialDirections", "widdershins", "go widdershins")
		}
	}
	if ("$roomid" != "0") then if (contains("portals", "MoveRandom.option")) then var MoveRandom.potentialDirections %MoveRandom.potentialDirections|$roomportals
	if ($north == 1) then var MoveRandom.potentialDirections %MoveRandom.potentialDirections|north
	if ($northeast == 1) then var MoveRandom.potentialDirections %MoveRandom.potentialDirections|northeast
	if ($northwest == 1) then var MoveRandom.potentialDirections %MoveRandom.potentialDirections|northwest
	if ($south == 1) then var MoveRandom.potentialDirections %MoveRandom.potentialDirections|south
	if ($southeast == 1) then var MoveRandom.potentialDirections %MoveRandom.potentialDirections|southeast
	if ($southwest == 1) then var MoveRandom.potentialDirections %MoveRandom.potentialDirections|southwest
	if ($east == 1) then var MoveRandom.potentialDirections %MoveRandom.potentialDirections|east
	if ($west == 1) then var MoveRandom.potentialDirections %MoveRandom.potentialDirections|west
	if ($up == 1) then var MoveRandom.potentialDirections %MoveRandom.potentialDirections|up
	if ($down == 1) then var MoveRandom.potentialDirections %MoveRandom.potentialDirections|down
	if ($out == 1) then var MoveRandom.potentialDirections %MoveRandom.potentialDirections|out
	# Strip out begining | if it exists
	eval MoveRandom.potentialDirections replacere("%MoveRandom.potentialDirections", "^\|+", "")
	# Strip out any extra spaces
	eval MoveRandom.potentialDirections replacere("%MoveRandom.potentialDirections", "^\s*\|", "")
	eval MoveRandom.maxIndex count("%MoveRandom.potentialDirections", "|")
	random 0 %MoveRandom.maxIndex
	eval MoveRandom.direction element("%MoveRandom.potentialDirections", %r)
	gosub Move %MoveRandom.direction
	if ("%Move.success" != "1") then goto MoveRandom
	var MoveRandom.success 1
	return