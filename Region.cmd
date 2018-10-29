#REQUIRE Error.cmd

# Usage:
# gosub region - sets Region.region to 'Crossing/Riverhaven/Shard/etc'
# gosub region 34 - sets Region.region to current location and Region.destinationRegion to future zone
# Region List: Aesry|Ain|Crossing|Hara|Kresh|Leth|Mriss|Muspari|Ratha|Riverhaven|Shard|Theren|Throne

# Todo List:
# zone 118e Firecats? is currently unconnected to any map - it should connect to Hib but it's a maze so it needs a custom script to exit.
# todo: redo entire script as province list
# Todo: (added Selgoltha river to zone 50 for now, easier to swim north... todo, separate zone by roomid)
# todo: special check for zone 34 - separate sky giant area out to theren, not riverhaven

gosub Region %0
exit

Region:
	debuglevel 10
	eval Region.destinationZone tolower("%1")
	var Region.aesryList 98|98a|99
	var Region.crossingList 1|1a|1j|1k|1l|1m|1n|2|2a|2d|4|4a|6|7|7a|8|8a|9b|10|11|12a|13|14b|14c|50
	var Region.lethList 58|59|60|61|62|63|112
	var Region.muspariList 47|47a
	var Region.rathaList 90|90a|90d|92|95
	var Region.riverhavenList 30|30a|30b|30c|31|31a|31b|32|33|33a|34a
	var Region.shardList 65|66|67|67a|68|68a|68b|69|70|71|116|123|126|127|128|240
	var Region.therenList 40|40a|41|42|48|230
	# The following section would be a lot cleaner if I could return a value.
	if ("%Region.destinationZone" != "") then {
		gosub RegionSet %Region.destinationZone
		var Region.destinationRegion %Region.region
	}
	gosub RegionSet $zoneid
	return

RegionSet:
	var Region.zoneIdToCheck $0
	var Region.region null
	# First, start with non-split zones:
	if ("%Region.zoneIdToCheck" == "150") then {
		var Region.region FangCove
		return
	}
	if (contains("|%Region.shardList|", "|%Region.zoneIdToCheck|")) then {
		var Region.region Shard
		return
	}
	if (contains("|%Region.crossingList|", "|%Region.zoneIdToCheck|")) then {
		var Region.region Crossing
		return
	}
	if (contains("|%Region.riverhavenList|", "|%Region.zoneIdToCheck|")) then {
		var Region.region Riverhaven
		return
	}
	if (contains("|%Region.therenList|", "|%Region.zoneIdToCheck|")) then {
		var Region.region Theren
		return
	}
	if (contains("|%Region.lethList|", "|%Region.zoneIdToCheck|")) then {
		var Region.region Leth
		return
	}
	if (contains("|%Region.rathaList|", "|%Region.zoneIdToCheck|")) then {
		var Region.region Ratha
		return
	}
	if (contains("|%Region.aesryList|", "|%Region.zoneIdToCheck|")) then {
		var Region.region Aesry
		return
	}
	if (contains("|%Region.muspariList|", "|%Region.zoneIdToCheck|")) then {
		var Region.region Muspari
		return
	}
	if ("%Region.zoneIdToCheck" == "106") then {
		var Region.region Hara
		return
	}
	if ("%Region.zoneIdToCheck" == "107") then {
		var Region.region Kresh
		return
	}
	if ("%Region.zoneIdToCheck" == "108") then {
		var Region.region Mriss
		return
	}
	if ("%Region.zoneIdToCheck" == "114") then {
		var Region.region Ain
		return
	}

	# What do do about split zones in destination? That's tricky...
	if ("%Region.zoneIdToCheck" == "34") then {
		if (contains("|121|122|123|124|125|126|127|128|129|130|131|132|133|134|135|136|138|139|140|141|142|143|144|145|146|147|148|149|150|151|152|", "|$roomid|")) then var Region.region Theren
		else var Region.region Riverhaven
		return
	}
	if ("%Region.zoneIdToCheck" == "48") then {
		if (contains("|23|24|69|70|71|72|73|74|75|76|77|78|79|80|81|82|83|84|85|86|87|88|89|90|91|", "|$roomid|")) then var Region.region Theren
		else var Region.region Muspari
		return
	}
	if "%Region.zoneIdToCheck" == "113" then {
		if (contains("|4|8|11|", "|$roomid|")) then var Region.region Ain
		if ($roomid == 6) then var Region.region Shard
		if ($roomid == 1) then var Region.region Leth
		if (contains("|2|3|12|13|", "|$roomid|")) then {
			gosub Error You're on a ferry, not in a defined zone!
		}
		return
	}
	gosub Error Undefined zone encountered in Region.cmd
	return