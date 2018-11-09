#REQUIRE ClearHand.cmd
#REQUIRE Get.cmd
#REQUIRE Move.cmd
#REQUIRE Navigate.cmd
#REQUIRE Put.cmd
#REQUIRE Stand.cmd
#REQUIRE Drop.cmd
#REQUIRE MoveRandom.cmd

FestTeardrinker:
	if ($standing != 1) then gosub Stand
	#if (!matchre("$roomobjs", "an? \S+ \S+ teardrinker\b")) then {
	#	gosub MoveRandom
	#	goto FestTeardrinker
	#}
	if (!matchre("$roomobjs", "an? \S+ \S+ teardrinker\b")) then gosub FindTearDrinkers
	gosub ClearHand both
	gosub Get teardrinker
	if ("$righthandnoun" == "petal") then gosub Drop my petal
	if ("$righthand $lefthand" == "Empty Empty") then goto FestTeardrinker
	if ($standing != 1) then gosub Stand
	if ("$roomid" == "0") then gosub MoveRandom
	gosub Navigate 210 32
	gosub Put teardrinker on shrine
	if ("$righthandnoun" == "petal") then gosub Drop my petal
	gosub ClearHand both
	goto FestTeardrinker

FindTearDrinkers:
	if ("$roomid" == "0") then gosub MoveRandom
	if (matchre("$roomobjs", "an? \S+ \S+ teardrinker\b")) then return
	gosub Navigate 210 32
	random 1 8
	if (%r == 1) then var moveArray northeast|west|north|northwest|south|east|southeast|southwest
	if (%r == 2) then var moveArray east|north|southwest|northeast|west|northwest|south|southeast
	if (%r == 3) then var moveArray northeast|southeast|east|south|southwest|northwest|west|north
	if (%r == 4) then var moveArray east|north|south|northeast|northwest|west|southeast|southwest
	if (%r == 5) then var moveArray north|northwest|southwest|west|east|southeast|south|northeast
	if (%r == 6) then var moveArray west|east|south|southwest|northwest|northeast|southeast|north
	if (%r == 7) then var moveArray southwest|south|southeast|east|northeast|northwest|west|north
	if (%r == 8) then var moveArray north|east|northwest|southeast|west|northeast|southwest|south
	var moveIndex 0
FindingTearDrinkers:
	eval segment element("%moveArray", %moveIndex)
	if ("%segment" == "north") then var moveSegment north|north|northwest|southeast|northeast|southwest|south|south
	if ("%segment" == "northeast") then var moveSegment northeast|northeast|east|west|northeast|southwest|southwest|southwest
	if ("%segment" == "east") then var moveSegment east|east|northeast|southwest|southeast|northwest|west|west
	if ("%segment" == "southeast") then var moveSegment southeast|southeast|east|west|southeast|northwest|northwest|northwest
	if ("%segment" == "south") then var moveSegment south|south|southeast|northwest|southwest|northeast|north|north
	if ("%segment" == "southwest") then var moveSegment southwest|southwest|west|east|southwest|northeast|northeast|northeast
	if ("%segment" == "west") then var moveSegment west|west|northwest|southeast|southwest|northeast|east|east
	if ("%segment" == "northwest") then var moveSegment northwest|northwest|west|east|northwest|southeast|southeast|southeast
	gosub SearchNode
	if (matchre("$roomobjs", "an? \S+ \S+ teardrinker\b")) then return
	math moveIndex add 1
	if (%moveIndex <= 8) then goto FindingTearDrinkers
	put #beep
	put #flash
	echo ***
	echo *** DIDN'T FIND ANY TEARDRINKERS...
	echo ***
	goto FindTearDrinkers

SearchNode:
	var nodeIndex 0
	eval nodeMaxIndex count("%moveSegment", "|")
	if (matchre("$roomobjs", "an? \S+ \S+ teardrinker\b")) then return
SearchingNode:
	eval currentMovement element("%moveSegment", %nodeIndex)
	gosub Move %currentMovement
	if (matchre("$roomobjs", "an? \S+ \S+ teardrinker\b")) then return
	math nodeIndex add 1
	if (%nodeIndex <= %nodeMaxIndex) then goto SearchingNode
	return
