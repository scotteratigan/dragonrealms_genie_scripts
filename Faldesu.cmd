#REQUIRE Climb.cmd
#REQUIRE Error.cmd
#REQUIRE Move.cmd

gosub Faldesu %0
exit

Faldesu:
	eval Faldesu.direction tolower("$1")
	if (contains("north", "%Faldesu.direction")) then goto FaldesuNorth
	if (contains("south", "%Faldesu.direction")) then goto FaldesuSouth
	gosub Error Faldesu.cmd called without specifying 'north' or 'south'
	return

FaldesuNorth:
	gosub Move north
	if ($north == 1) then goto FaldesuNorth
	gosub Move northwest
FaldesuNortheast:
	gosub Move northeast
	if ($northeast == 1) then goto FaldesuNortheast
	gosub Climb stone bridge
	return

FaldesuSouth:
	gosub Move south
	if ($south == 1) then goto FaldesuSouth
	gosub Move southwest
FaldesuSoutheast:
	gosub Move southeast
	if ($southeast == 1) then goto FaldesuSoutheast
	gosub Climb stone bridge
	return