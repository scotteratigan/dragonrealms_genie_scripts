#REQUIRE Error.cmd
#REQUIRE Move.cmd
#REQUIRE Navigate.cmd
#REQUIRE RemoveArmor.cmd
#REQUIRE WearArmor.cmd

gosub Segoltha %0
exit

Segoltha:
	eval Segoltha.direction tolower("$0")
	var Segoltha.removedArmor 0
	var RiverRoomDescriptions Rising majestically above the rushing water, a massive rock outcropping emerges from the muddy river in the distance.  Forming a small islet in the watercourse, the top is crowned by a colossal tree.|Towering over the river's surface, the looming bulk of the rocky island creates a sheltered area in the churning currents of the river.  Silt has been deposited in the refuge, forming a small muddy shoreline.  Mud gives way to drier sand of a bank that hugs the edge of the rock.|Scattered driftwood piled along the muddy shore testifies to the power of the river, each pile deposited high above the current waterline by vanished floods.  Tiny tracks of unknown animals spread a delicate tracery across the mud and sand.|Twisting currents of silt-laden water surge just below the river's surface.  A churning, heaving mass of dirty brown waves, the torrent of water stretches as far as the eye can see.
	if ($Athletics.Ranks < 1000) then {
		gosub RemoveArmor
		var Segoltha.removedArmor 1
	}
	if (contains("north", "%Segoltha.direction")) then goto SegolthaNorth
	if (contains("south", "%Segoltha.direction")) then goto SegolthaSouth
	gosub Error Segoltha.cmd called without specifying 'north' or 'south'
	return

SegolthaNorth:
	if (contains("$roomdesc" == "%RiverRoomDescriptions")) then goto SegolthaGoingNorth
	if (contains("|33|34|35|36|", "|$roomid|")) then goto SegolthaGoingNorth
	if (contains("|1|2|3|4|5|6|8|", "|$roomid|")) then goto EastBranch
	#if contains("|23|24|25|26|27|28|29|31|42|43|44|45|46", "|$roomid|") then gosub Navigate 50 22 <- todo: determine what this was for
	gosub Navigate 50 22
SegolthaGoingNorth:
	#if ($west == 1) then {
	#	gosub Move west
	#	goto SegolthaGoingNorth
	#}
	gosub Move north
	if ($north == 1) then goto SegolthaGoingNorth
	if (%Segoltha.removedArmor == 1) then gosub WearArmor
	gosub Navigate 50 36
	return

SegolthaSouth:
	if contains("$roomdesc" == "%RiverRoomDescriptions") then goto SegolthaGoingSouth
	if contains("|22|23|24|25|26|27|28|29|30|31|42|43|44|45|46|", "|$roomid|") then goto SegolthaGoingSouth
	#if contains("|34|35|", "|$roomid|") then gosub Navigate 50 33  <- todo: determine what this was for
	gosub Navigate 50 33
SegolthaGoingSouth:
	#if ($west == 1) then {
	#	gosub Move west
	#	goto SegolthaGoingSouth
	#}
	gosub Move south
	if ($south == 1) then goto SegolthaGoingSouth
	if (%Segoltha.removedArmor == 1) then gosub WearArmor
	gosub Navigate 50 30
	return
