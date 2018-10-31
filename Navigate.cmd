#REQUIRE Error.cmd
#REQUIRE Information.cmd
#REQUIRE Move.cmd
#REQUIRE MoveRandom.cmd
#REQUIRE Region.cmd
#REQUIRE Release.cmd
#REQUIRE Send.cmd
#REQUIRE Stand.cmd
#debuglevel 10
gosub Navigate %0
exit

Navigate:
	var Navigate.destinationZone $1
	var Navigate.destinationRoom $2
	var Navigate.failedMoves 0
	action math Navigate.failedMoves add 1;if %Navigate.failedMoves > 5 then goto Navigate when ^You can't go there\.|^What were you referring to\?
	action goto NavigateArrested when ^Arriving at the jail, the guard submits you to a brutal strip search and throws your things into a large sack\.  From there you are dragged down a dark hallway and into a cell\.
	action goto NavigateDestinationNotFound when ^DESTINATION NOT FOUND$
NavigateStart:
	pause .01
	if ("$SpellTimer.UniversalSolvent.active" == "1") then gosub Release USOL
	if ($standing != 1) then gosub Stand
	if ("%Navigate.destinationZone" == "") then {
		gosub Error Navigate: MUST SPECIFY DESTINATION ZONE
		return
	}
	gosub Information Navigating to %Navigate.destinationZone %Navigate.destinationRoom
	# Why am I skipping the lost check in these zones? Can't remember.
	if (contains("|14c|34|40a|", "|$zoneid|")) then goto NavigateSkipLostCheck
	if ($roomid == 0 && $zoneid == 300) then {
		gosub Error Lost in the ways, exiting immediately.
		put #script abort all except %scriptname
		put exit
		pause
		exit
	}
	if ($roomid == 0) then gosub NavigateMoveUntilRoomHasID
NavigateSkipLostCheck:
#CrossingZones:
	var Navigate.toZone1 null
	var Navigate.toZone1j null
	var Navigate.toZone1k null
	var Navigate.toZone1l null
	var Navigate.toZone1m null
	var Navigate.toZone1n null
	var Navigate.toZone2 null
	var Navigate.toZone2a null
	var Navigate.toZone2d null
	var Navigate.toZone3 null
	var Navigate.toZone4 null
	var Navigate.toZone4a null
	var Navigate.toZone5 null
	var Navigate.toZone6 null
	var Navigate.toZone7 null
	var Navigate.toZone7a null
	var Navigate.toZone8 null
	var Navigate.toZone8a null
	var Navigate.toZone9b null
	var Navigate.toZone10 null
	var Navigate.toZone11 null
	var Navigate.toZone12a null
	var Navigate.toZone13 null
	var Navigate.toZone14b null
	var Navigate.toZone14c null
	var Navigate.toZone50 null
#RossmansZones:
	var Navigate.toZone34 null
	var Navigate.toZone34a null
#ShardZones:
	var Navigate.toZone65 null
	var Navigate.toZone66 null
	var Navigate.toZone67 null
	var Navigate.toZone67a null
	var Navigate.toZone68 null
	var Navigate.toZone68a null
	var Navigate.toZone68b null
	var Navigate.toZone69 null
	var Navigate.toZone116 null
	var Navigate.toZone123 null
	var Navigate.toZone126 null
	var Navigate.toZone127 null
	var Navigate.toZone240 null
#RathaZones:
	var Navigate.toZone90 null
	var Navigate.toZone90a null
	var Navigate.toZone90d null
	var Navigate.toZone92 null
	var Navigate.toZone95 null
#M'Riss/Mer'KreshZones:
	var Navigate.toZone107 null
	var Navigate.toZone107a null
	var Navigate.toZone108 null
#OtherZones:
	var Navigate.toZone150 null
	var Navigate.toZone210 null

# CUSTOM SHORTHAND SECTION
	if (contains("fest|festival", "%Navigate.destinationZone")) then var Navigate.destinationZone 210
	if (contains("crossing|xing", "%Navigate.destinationZone")) then var Navigate.destinationZone 1
	if (contains("temple", "%Navigate.destinationZone")) then var Navigate.destinationZone 2a
	if (contains("tiger clan", "%Navigate.destinationZone")) then var Navigate.destinationZone 4a
	if (contains("north gate", "%Navigate.destinationZone")) then var Navigate.destinationZone 6
	if (contains("ntr", "%Navigate.destinationZone")) then var Navigate.destinationZone 7
	if (contains("stoneclan", "%Navigate.destinationZone")) then var Navigate.destinationZone 10
	if (contains("guardians", "%Navigate.destinationZone")) then var Navigate.destinationZone 11
	if (contains("abbey", "%Navigate.destinationZone")) then var Navigate.destinationZone 12a
	if (contains("dirge", "%Navigate.destinationZone")) then var Navigate.destinationZone 13
	if (contains("faldesu", "%Navigate.destinationZone")) then var Navigate.destinationZone 14c
	if (contains("riverhaven", "%Navigate.destinationZone")) then var Navigate.destinationZone 30
	if (contains("rossmans", "%Navigate.destinationZone")) then var Navigate.destinationZone 34
	if (contains("theren|therenborough", "%Navigate.destinationZone")) then var Navigate.destinationZone 42
	if (contains("leth deriel", "%Navigate.destinationZone")) then var Navigate.destinationZone 61
	if (contains("shard", "%Navigate.destinationZone")) then var Navigate.destinationZone 67
	if (contains("wyverns|wyvernmountains", "%Navigate.destinationZone")) then var Navigate.destinationZone 70
	if (contains("ratha", "%Navigate.destinationZone")) then var Navigate.destinationZone 90
	if (contains("mer'kresh|merkresh", "%Navigate.destinationZone")) then var Navigate.destinationZone 107
	if (contains("m'riss|mriss", "%Navigate.destinationZone")) then var Navigate.destinationZone 108
	if (contains("hib|hibarnhvidar|hibbles", "%Navigate.destinationZone")) then var Navigate.destinationZone 116
	if (contains("raven's point|ravens point", "%Navigate.destinationZone")) then var Navigate.destinationZone 123
	if (contains("boarclan", "%Navigate.destinationZone")) then var Navigate.destinationZone 127
	if (contains("ainghazal", "%Navigate.destinationZone")) then var Navigate.destinationZone 114
	if (contains("hibarnhvidar|hibbles", "%Navigate.destinationZone")) then var Navigate.destinationZone 116
	if (contains("maulers|zombies|head-splitters|stompers", "%Navigate.destinationZone")) then {
		var Navigate.destinationZone 127
	}
	# This is necessary because wyvern mountAINs contain AIN (ghazal). This is a GREAT way to die.
	if ("%Navigate.destinationZone" == "ain") then var Navigate.destinationZone 114
	if (contains("fang cove|arch", "%Navigate.destinationZone")) then var Navigate.destinationZone 150
	# Is the following ever used?
	#put #tvar Navigate.destinationZone %Navigate.destinationZone
	if "%Navigate.destinationRoom" != "" then put #tvar Navigate.destinationRoom %Navigate.destinationRoom
	if ("$zoneid" == "%Navigate.destinationZone") then goto NavigateAlreadyInZone
	if ("$zoneid" == "150") then {
		gosub NavigationMoveToNewMap 213
		gosub NavigationResetMap
		gosub Region
		if "$zoneid" == "%Navigate.destinationZone" then goto NavigateAlreadyInZone
	}
	if ("$zoneid" == "210") then {
		gosub NavigationMoveToNewMap leave
		gosub NavigationResetMap
		gosub Region
		if "$zoneid" == "%Navigate.destinationZone" then goto NavigateAlreadyInZone
	}
goto zone$zoneid

zone1:
	#Crossing
	var Navigate.toZone1 NA
	var Navigate.toZone1j 925
	var Navigate.toZone1k 926
	var Navigate.toZone1l 960
	var Navigate.toZone1m 968
	var Navigate.toZone1n 993
	var Navigate.toZone2 172|15
	var Navigate.toZone2a 466
	var Navigate.toZone2d 466|188
	var Navigate.toZone4 172
	var Navigate.toZone4a 172|87
	var Navigate.toZone6 173
	var Navigate.toZone6a 173|172
	var Navigate.toZone7 171
	var Navigate.toZone7a 171|350
	var Navigate.toZone8 170
	var Navigate.toZone8a 170|70
	var Navigate.toZone9b 171|397
	var Navigate.toZone10 171|396
	var Navigate.toZone11 171|394
	var Navigate.toZone12a 171|437
	var Navigate.toZone13 171|147
	var Navigate.toZone14b 171|253
	var Navigate.toZone14c 171|197
	var Navigate.toZone50 172|87|73
	var Navigate.toZone150 702
	var Navigate.toZone210 994
	goto NavigateBegin

zone1a:
	#5th Passage - Xing to STR (this really needs more thought out & zones added)
	if contains("|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|40|", "|$roomid|") then {
		var Navigate.toZone1 6
		var Navigate.toZone1j 6|925
		var Navigate.toZone1k 6|926
		var Navigate.toZone1l 6|960
		var Navigate.toZone1m 6|968
		var Navigate.toZone1n 6|993
		var Navigate.toZone2 6|172|15
		var Navigate.toZone2a 6|466
		var Navigate.toZone2d 6|466|188
		var Navigate.toZone4 6|172
		var Navigate.toZone4a 6|172|87
		var Navigate.toZone6 6|173
		var Navigate.toZone6a 6|173|172
		var Navigate.toZone7 6|171
		var Navigate.toZone7a 6|171|350
		var Navigate.toZone8 6|170
		var Navigate.toZone8a 6|170|70
		var Navigate.toZone9b 6|171|397
		var Navigate.toZone10 6|171|396
		var Navigate.toZone11 6|171|394
		var Navigate.toZone12a 6|171|437
		var Navigate.toZone13 6|171|147
		var Navigate.toZone14b 6|171|253
		var Navigate.toZone14c 6|171|197
		var Navigate.toZone50 6|172|87|73
		var Navigate.toZone150 6|702
		var Navigate.toZone210 6|994
		var Navigate.toZone60 23
	}
	if contains("|31|32|34|36|37|38|", "|$roomid|") then {
		var Navigate.toZone1 33
	}
	if contains("|1|2|3|", "|$roomid|") then {
		var Navigate.toZone1 5
	}
	if contains("|24|25|26|27|28|", "|$roomid|") then {
		var Navigate.toZone1 29
	}
	goto NavigateBegin
zone1j:
	#Crossing - Market Plaza
	var Navigate.toZone1 1
	var Navigate.toZone1j NA
	var Navigate.toZone1k 1|926
	var Navigate.toZone1l 1|960
	var Navigate.toZone1m 1|968
	var Navigate.toZone1n 1|993
	var Navigate.toZone2 1|172|15
	var Navigate.toZone2a 1|466
	var Navigate.toZone2d 1|466|188
	var Navigate.toZone4 1|172
	var Navigate.toZone4a 1|172|87
	var Navigate.toZone6 1|173
	var Navigate.toZone6a 1|173|172
	var Navigate.toZone7 1|171
	var Navigate.toZone7a 1|171|350
	var Navigate.toZone8 1|170
	var Navigate.toZone8a 1|170|70
	var Navigate.toZone9b 1|171|397
	var Navigate.toZone10 1|171|396
	var Navigate.toZone11 1|171|394
	var Navigate.toZone12a 1|171|437
	var Navigate.toZone13 1|171|147
	var Navigate.toZone14b 1|171|253
	var Navigate.toZone14c 1|171|197
	var Navigate.toZone50 1|172|87|73
	var Navigate.toZone150 1|702
	var Navigate.toZone210 1|994
	goto NavigateBegin
zone1k:
	#Crossing - Engineering Society
	var Navigate.toZone1 6
	var Navigate.toZone1j 6|925
	var Navigate.toZone1k NA
	var Navigate.toZone1l 6|960
	var Navigate.toZone1m 6|968
	var Navigate.toZone1n 6|993
	var Navigate.toZone2 6|172|15
	var Navigate.toZone2a 6|466
	var Navigate.toZone2d 6|466|188
	var Navigate.toZone4 6|172
	var Navigate.toZone4a 6|172|87
	var Navigate.toZone6 6|173
	var Navigate.toZone6a 6|173|172
	var Navigate.toZone7 6|171
	var Navigate.toZone7a 6|171|350
	var Navigate.toZone8 6|170
	var Navigate.toZone8a 6|170|70
	var Navigate.toZone9b 6|171|397
	var Navigate.toZone10 6|171|396
	var Navigate.toZone11 6|171|394
	var Navigate.toZone12a 6|171|437
	var Navigate.toZone13 6|171|147
	var Navigate.toZone14b 6|171|253
	var Navigate.toZone14c 6|171|197
	var Navigate.toZone50 6|172|87|73
	var Navigate.toZone150 6|702
	var Navigate.toZone210 6|994
	goto NavigateBegin
zone1l:
	#Crossing - Forging Society
	var Navigate.toZone1 13
	var Navigate.toZone1j 13|925
	var Navigate.toZone1k 13|926
	var Navigate.toZone1l NA
	var Navigate.toZone1m 13|968
	var Navigate.toZone1n 13|993
	var Navigate.toZone2 13|172|15
	var Navigate.toZone2a 13|466
	var Navigate.toZone2d 13|466|188
	var Navigate.toZone4 13|172
	var Navigate.toZone4a 13|172|87
	var Navigate.toZone6 13|173
	var Navigate.toZone6a 13|173|172
	var Navigate.toZone7 13|171
	var Navigate.toZone7a 13|171|350
	var Navigate.toZone8 13|170
	var Navigate.toZone8a 13|170|70
	var Navigate.toZone9b 13|171|397
	var Navigate.toZone10 13|171|396
	var Navigate.toZone11 13|171|394
	var Navigate.toZone12a 13|171|437
	var Navigate.toZone13 13|171|147
	var Navigate.toZone14b 13|171|253
	var Navigate.toZone14c 13|171|197
	var Navigate.toZone50 13|172|87|73
	var Navigate.toZone150 13|702
	var Navigate.toZone210 13|994
	goto NavigateBegin
zone1m:
	#Crossing - Outfitting Society
	var Navigate.toZone1 11
	var Navigate.toZone1j 11|925
	var Navigate.toZone1k 11|926
	var Navigate.toZone1l 11|960
	var Navigate.toZone1m NA
	var Navigate.toZone1n 11|993
	var Navigate.toZone2 11|172|15
	var Navigate.toZone2a 11|466
	var Navigate.toZone2d 11|466|188
	var Navigate.toZone4 11|172
	var Navigate.toZone4a 11|172|87
	var Navigate.toZone6 11|173
	var Navigate.toZone6a 11|173|172
	var Navigate.toZone7 11|171
	var Navigate.toZone7a 11|171|350
	var Navigate.toZone8 11|170
	var Navigate.toZone8a 11|170|70
	var Navigate.toZone9b 11|171|397
	var Navigate.toZone10 11|171|396
	var Navigate.toZone11 11|171|394
	var Navigate.toZone12a 11|171|437
	var Navigate.toZone13 11|171|147
	var Navigate.toZone14b 11|171|253
	var Navigate.toZone14c 11|171|197
	var Navigate.toZone50 11|172|87|73
	var Navigate.toZone150 11|702
	var Navigate.toZone210 11|994
	goto NavigateBegin
zone1n:
	#echo NAVIGATING FROM ALCHEMY SOCIETY
	#Crossing - Alchemy Society
	var Navigate.toZone1 6
	var Navigate.toZone1j 6|925
	var Navigate.toZone1k 6|926
	var Navigate.toZone1l 6|960
	var Navigate.toZone1m 6|968
	var Navigate.toZone1n NA
	var Navigate.toZone2 6|172|15
	var Navigate.toZone2a 6|466
	var Navigate.toZone2d 6|466|188
	var Navigate.toZone4 6|172
	var Navigate.toZone4a 6|172|87
	var Navigate.toZone6 6|173
	var Navigate.toZone6a 6|173|172
	var Navigate.toZone7 6|171
	var Navigate.toZone7a 6|171|350
	var Navigate.toZone8 6|170
	var Navigate.toZone8a 6|170|70
	var Navigate.toZone9b 6|171|397
	var Navigate.toZone10 6|171|396
	var Navigate.toZone11 6|171|394
	var Navigate.toZone12a 6|171|437
	var Navigate.toZone13 6|171|147
	var Navigate.toZone14b 6|171|253
	var Navigate.toZone14c 7|171|197
	var Navigate.toZone50 6|172|87|73
	var Navigate.toZone150 6|702
	var Navigate.toZone210 6|994
	goto NavigateBegin
zone2:
	#Lake of Dreams (out West Gate) - Lipods, Water Sprites
	var Navigate.toZone1 2|14
	var Navigate.toZone1j 2|14|925
	var Navigate.toZone1k 2|14|926
	var Navigate.toZone1l 2|14|960
	var Navigate.toZone1m 2|14|968
	var Navigate.toZone1n 2|14|993
	var Navigate.toZone2 NA
	var Navigate.toZone2a 2|14|466
	var Navigate.toZone2d 2|14|466|188
	var Navigate.toZone4 2
	var Navigate.toZone4a 2|87
	var Navigate.toZone6 2|264
	var Navigate.toZone6a 2|264|172
	var Navigate.toZone7 2|264|98
	var Navigate.toZone7a 2|264|98|350
	var Navigate.toZone8 2|264|98|348
	var Navigate.toZone8a 2|264|98|348|70
	var Navigate.toZone9b 2|264|98|397
	var Navigate.toZone10 2|264|98|396
	var Navigate.toZone11 2|264|98|394
	var Navigate.toZone12a 2|264|98|437
	var Navigate.toZone13 2|264|98|147
	var Navigate.toZone14b 2|264|98|253
	var Navigate.toZone14c 2|264|98|197
	var Navigate.toZone50 2|87|73
	var Navigate.toZone150 2|14|702
	var Navigate.toZone210 2|14|994
	goto NavigateBegin
zone2a:
	#Crossing Temple
	var Navigate.toZone1 3
	var Navigate.toZone1j 3|925
	var Navigate.toZone1k 3|926
	var Navigate.toZone1l 3|960
	var Navigate.toZone1m 3|968
	var Navigate.toZone1n 3|993
	var Navigate.toZone2 3|172|15
	var Navigate.toZone2a NA
	var Navigate.toZone2d 188
	var Navigate.toZone4 3|172
	var Navigate.toZone4a 3|172|87
	var Navigate.toZone6 3|173
	var Navigate.toZone6a 3|173|172
	var Navigate.toZone7 3|171
	var Navigate.toZone7a 3|171|350
	var Navigate.toZone8 3|170
	var Navigate.toZone8a 3|170|70
	var Navigate.toZone9b 3|171|397
	var Navigate.toZone10 3|171|396
	var Navigate.toZone11 3|171|394
	var Navigate.toZone12a 3|171|437
	var Navigate.toZone13 3|171|147
	var Navigate.toZone14b 3|171|253
	var Navigate.toZone14c 3|171|197
	var Navigate.toZone50 3|172|87|73
	var Navigate.toZone150 3|702
	var Navigate.toZone210 3|994
	goto NavigateBegin
zone2d:
	#Crossing Escape Tunnels
	var Navigate.toZone1 62|3
	var Navigate.toZone1j 62|3|925
	var Navigate.toZone1k 62|3|926
	var Navigate.toZone1l 62|3|960
	var Navigate.toZone1m 62|3|968
	var Navigate.toZone1n 62|3|993
	var Navigate.toZone2 62|3|172|15
	var Navigate.toZone2a 62
	var Navigate.toZone2d NA
	var Navigate.toZone4 62|3|172
	var Navigate.toZone4a 62|3|172|87
	var Navigate.toZone6 62|3|173
	var Navigate.toZone6a 62|3|173|172
	var Navigate.toZone7 62|3|171
	var Navigate.toZone7a 62|3|171|350
	var Navigate.toZone8 62|3|170
	var Navigate.toZone8a 62|3|170|70
	var Navigate.toZone9b 62|3|171|397
	var Navigate.toZone10 62|3|171|396
	var Navigate.toZone11 62|3|171|394
	var Navigate.toZone12a 62|3|171|437
	var Navigate.toZone13 62|3|171|147
	var Navigate.toZone14b 62|3|171|253
	var Navigate.toZone14c 62|3|171|197
	var Navigate.toZone50 62|3|172|87|73
	var Navigate.toZone150 62|3|702
	var Navigate.toZone210 62|3|994
	goto NavigateBegin
zone4:
	#Crossing West Gate
	var Navigate.toZone1 14
	var Navigate.toZone1j 14|925
	var Navigate.toZone1k 14|926
	var Navigate.toZone1l 14|960
	var Navigate.toZone1m 14|968
	var Navigate.toZone1n 14|993
	var Navigate.toZone2 15
	var Navigate.toZone2a 14|466
	var Navigate.toZone2d 14|466|188
	var Navigate.toZone4 NA
	var Navigate.toZone4a 87
	var Navigate.toZone6 14|173
	var Navigate.toZone6a 480|172
	var Navigate.toZone7 14|171
	var Navigate.toZone7a 14|171|350
	var Navigate.toZone8 14|171|348
	var Navigate.toZone8a 14|171|348|70
	var Navigate.toZone9b 14|171|397
	var Navigate.toZone10 14|171|396
	var Navigate.toZone11 14|171|394
	var Navigate.toZone12a 14|171|437
	var Navigate.toZone13 14|171|147
	var Navigate.toZone14b 14|171|253
	var Navigate.toZone14c 14|171|197
	var Navigate.toZone50 87|73
	var Navigate.toZone150 14|702
	var Navigate.toZone210 14|994
	goto NavigateBegin
zone4a:
	#Tiger Clan (out West Gate)
	var Navigate.toZone1 15|14
	var Navigate.toZone1j 15|14|925
	var Navigate.toZone1k 15|14|926
	var Navigate.toZone1l 15|14|960
	var Navigate.toZone1m 15|14|968
	var Navigate.toZone1n 15|14|993
	var Navigate.toZone2 15|15
	var Navigate.toZone2a 15|14|466
	var Navigate.toZone2d 15|14|466|188
	var Navigate.toZone4 15
	var Navigate.toZone4a NA
	var Navigate.toZone6 15|480
	var Navigate.toZone6a 15|480|172
	var Navigate.toZone7 15|480|98
	var Navigate.toZone7a 15|480|98|350
	var Navigate.toZone8 15|480|98|348
	var Navigate.toZone8a 15|480|98|348|70
	var Navigate.toZone9b 15|480|98|397
	var Navigate.toZone10 15|480|98|396
	var Navigate.toZone11 15|480|98|394
	var Navigate.toZone12a 15|480|98|437
	var Navigate.toZone13 15|480|98|147
	var Navigate.toZone14b 15|480|98|253
	var Navigate.toZone14c 15|480|98|197
	var Navigate.toZone50 73
	var Navigate.toZone150 15|14|702
	var Navigate.toZone210 15|14|994
	goto NavigateBegin
zone6:
	#Crossing North Gate
	var Navigate.toZone1 23
	var Navigate.toZone1j 23|925
	var Navigate.toZone1k 23|926
	var Navigate.toZone1l 23|960
	var Navigate.toZone1m 23|968
	var Navigate.toZone1n 23|993
	var Navigate.toZone2 113|15
	var Navigate.toZone2a 23|466
	var Navigate.toZone2d 23|466|188
	var Navigate.toZone4 113
	var Navigate.toZone4a 113|87
	var Navigate.toZone6 NA
	var Navigate.toZone6a 172
	var Navigate.toZone7 98
	var Navigate.toZone7a 98|350
	var Navigate.toZone8 98|348
	var Navigate.toZone8a 98|348|70
	var Navigate.toZone9b 98|397
	var Navigate.toZone10 98|396
	var Navigate.toZone11 98|394
	var Navigate.toZone12a 98|437
	var Navigate.toZone13 98|147
	var Navigate.toZone14b 98|253
	var Navigate.toZone14c 98|197
	var Navigate.toZone50 113|87|73
	var Navigate.toZone150 23|702
	var Navigate.toZone210 23|994
	goto NavigateBegin
zone6a:
	#Crossing Necromancer Guild
	var Navigate.toZone1 1|23
	var Navigate.toZone1j 1|23|925
	var Navigate.toZone1k 1|23|926
	var Navigate.toZone1l 1|23|960
	var Navigate.toZone1m 1|23|968
	var Navigate.toZone1n 1|23|993
	var Navigate.toZone2 1|113|15
	var Navigate.toZone2a 1|23|466
	var Navigate.toZone2d 1|23|466|188
	var Navigate.toZone4 1|113
	var Navigate.toZone4a 1|113|87
	var Navigate.toZone6 1
	var Navigate.toZone6a NA
	var Navigate.toZone7 1|98
	var Navigate.toZone7a 1|98|350
	var Navigate.toZone8 1|98|348
	var Navigate.toZone8a 1|98|348|70
	var Navigate.toZone9b 1|98|397
	var Navigate.toZone10 1|98|396
	var Navigate.toZone11 1|98|394
	var Navigate.toZone12a 1|98|437
	var Navigate.toZone13 1|98|147
	var Navigate.toZone14b 1|98|253
	var Navigate.toZone14c 1|98|197
	var Navigate.toZone50 1|113|87|73
	var Navigate.toZone150 1|23|702
	var Navigate.toZone210 1|23|994
	goto NavigateBegin
zone7:
	#Crossing NTR
	var Navigate.toZone1 NA
	var Navigate.toZone1 349
	var Navigate.toZone1j 349|925
	var Navigate.toZone1k 349|926
	var Navigate.toZone1l 349|960
	var Navigate.toZone1m 349|968
	var Navigate.toZone1n 349|993
	var Navigate.toZone2 349|172|15
	var Navigate.toZone2a 349|466
	var Navigate.toZone2d 349|466|188
	var Navigate.toZone4 349|172
	var Navigate.toZone4a 349|172|87
	var Navigate.toZone6 347
	var Navigate.toZone6a 347|172
	var Navigate.toZone7 NA
	var Navigate.toZone7a 350
	var Navigate.toZone8 348
	var Navigate.toZone8a 348|70
	var Navigate.toZone9b 397
	var Navigate.toZone10 396
	var Navigate.toZone11 394
	var Navigate.toZone12a 437
	var Navigate.toZone13 147
	var Navigate.toZone14b 253
	var Navigate.toZone14c 197
	var Navigate.toZone50 349|172|87|73
	var Navigate.toZone150 349|702
	var Navigate.toZone210 349|994
	goto NavigateBegin
zone7a:
	#NTR Vineyard
	var Navigate.toZone1 15|349
	var Navigate.toZone1j 15|349|925
	var Navigate.toZone1k 15|349|926
	var Navigate.toZone1l 15|349|960
	var Navigate.toZone1m 15|349|968
	var Navigate.toZone1n 15|349|993
	var Navigate.toZone2 15|349|172|15
	var Navigate.toZone2a 15|349|466
	var Navigate.toZone2d 15|349|466|188
	var Navigate.toZone4 15|349|172
	var Navigate.toZone4a 15|349|172|87
	var Navigate.toZone6 15|347
	var Navigate.toZone6a 15|347|172
	var Navigate.toZone7 15
	var Navigate.toZone7a NA
	var Navigate.toZone8 15|348
	var Navigate.toZone8a 15|348|70
	var Navigate.toZone9b 397
	var Navigate.toZone10 15|396
	var Navigate.toZone11 15|394
	var Navigate.toZone12a 15|437
	var Navigate.toZone13 15|147
	var Navigate.toZone14b 15|253
	var Navigate.toZone14c 15|197
	var Navigate.toZone50 15|349|172|87|73
	var Navigate.toZone150 15|349|702
	var Navigate.toZone210 15|349|994
	goto NavigateBegin
zone8:
	#Crossing East Gate
	var Navigate.toZone1 43
	var Navigate.toZone1j 43|925
	var Navigate.toZone1k 43|926
	var Navigate.toZone1l 43|960
	var Navigate.toZone1m 43|968
	var Navigate.toZone1n 43|993
	var Navigate.toZone2 53|347|113|15
	var Navigate.toZone2a 43|466
	var Navigate.toZone2d 43|466|188
	var Navigate.toZone4 53|347|113
	var Navigate.toZone4a 53|347|113|87
	var Navigate.toZone6 53|347
	var Navigate.toZone6a 53|347|172
	var Navigate.toZone7 53
	var Navigate.toZone7a 53|350
	var Navigate.toZone8 NA
	var Navigate.toZone8a 70
	var Navigate.toZone9b 53|397
	var Navigate.toZone10 53|396
	var Navigate.toZone11 53||394
	var Navigate.toZone12a 53|437
	var Navigate.toZone13 53|147
	var Navigate.toZone14b 53|253
	var Navigate.toZone14c 53|197
	var Navigate.toZone50 53|347|113|87|73
	var Navigate.toZone150 43|702
	var Navigate.toZone210 43|994
	goto NavigateBegin
zone8a:
	#Lost Crossing (out East Gate)
	var Navigate.toZone1 15|43
	var Navigate.toZone1j 15|43|925
	var Navigate.toZone1k 15|43|926
	var Navigate.toZone1l 15|43|960
	var Navigate.toZone1m 15|43|968
	var Navigate.toZone1n 15|43|993
	var Navigate.toZone2 15|53|347|113|15
	var Navigate.toZone2a 15|43|466
	var Navigate.toZone2d 15|43|466|188
	var Navigate.toZone4 15|53|347|113
	var Navigate.toZone4a 15|53|347|113|87
	var Navigate.toZone6 15|53|347
	var Navigate.toZone6a 15|53|347|172
	var Navigate.toZone7 15|53
	var Navigate.toZone7a 15|53|350
	var Navigate.toZone8 15
	var Navigate.toZone8a NA
	var Navigate.toZone9b 15|53|397
	var Navigate.toZone10 15|53|396
	var Navigate.toZone11 15|53||394
	var Navigate.toZone12a 15|53|437
	var Navigate.toZone13 15|53|147
	var Navigate.toZone14b 15|53|253
	var Navigate.toZone14c 15|53|197
	var Navigate.toZone50 15|53|347|113|87|73
	var Navigate.toZone150 15|43|702
	var Navigate.toZone210 15|43|994
	goto NavigateBegin
zone9b:
	#Sorrow's Reach (Scouts, vipers, buccas)
	var Navigate.toZone1 9|349
	var Navigate.toZone1j 9|349|925
	var Navigate.toZone1k 9|349|926
	var Navigate.toZone1l 9|349|960
	var Navigate.toZone1m 9|349|968
	var Navigate.toZone1n 9|349|993
	var Navigate.toZone2 9|349|172|15
	var Navigate.toZone2a 9|349|466
	var Navigate.toZone2d 9|349|466|188
	var Navigate.toZone4 9|349|172
	var Navigate.toZone4a 9|349|172|87
	var Navigate.toZone6 9|347
	var Navigate.toZone6a 9|347|172
	var Navigate.toZone7 9
	var Navigate.toZone7a 9|350
	var Navigate.toZone8 9|348
	var Navigate.toZone8a 9|348|70
	var Navigate.toZone9b NA
	var Navigate.toZone10 9|396
	var Navigate.toZone11 9|394
	var Navigate.toZone12a 9|437
	var Navigate.toZone13 9|147
	var Navigate.toZone14b 9|253
	var Navigate.toZone14c 9|197
	var Navigate.toZone50 9|349|172|87|73
	var Navigate.toZone150 9|349|702
	var Navigate.toZone210 9|349|994
	goto NavigateBegin
zone10:
	#NTR Abandoned Mine & Lairocott Brach
	var Navigate.toZone1 21|349
	var Navigate.toZone1j 21|349|925
	var Navigate.toZone1k 21|349|926
	var Navigate.toZone1l 21|349|960
	var Navigate.toZone1m 21|349|968
	var Navigate.toZone1n 21|349|993
	var Navigate.toZone2 21|349|172|15
	var Navigate.toZone2a 21|349|466
	var Navigate.toZone2d 21|349|466|188
	var Navigate.toZone4 21|349|172
	var Navigate.toZone4a 21|349|172|87
	var Navigate.toZone6 21|347
	var Navigate.toZone6a 21|347|172
	var Navigate.toZone7 21
	var Navigate.toZone7a 21|350
	var Navigate.toZone8 21|348
	var Navigate.toZone8a 21|348|70
	var Navigate.toZone9b 21|397
	var Navigate.toZone10 NA
	var Navigate.toZone11 21|394
	var Navigate.toZone12a 21|437
	var Navigate.toZone13 21|147
	var Navigate.toZone14b 21|253
	var Navigate.toZone14c 21|197
	var Navigate.toZone50 21|349|172|87|73
	var Navigate.toZone150 21|349|702
	var Navigate.toZone210 21|349|994
	goto NavigateBegin
zone11:
	#NTR Leucros, Vipers, & Rock Guardians
	var Navigate.toZone1 2|349
	var Navigate.toZone1j 2|349|925
	var Navigate.toZone1k 2|349|926
	var Navigate.toZone1l 2|349|960
	var Navigate.toZone1m 2|349|968
	var Navigate.toZone1n 2|349|993
	var Navigate.toZone2 2|349|172|15
	var Navigate.toZone2a 2|349|466
	var Navigate.toZone2d 2|349|466|188
	var Navigate.toZone4 2|349|172
	var Navigate.toZone4a 2|349|172|87
	var Navigate.toZone6 2|347
	var Navigate.toZone6a 2|347|172
	var Navigate.toZone7 2
	var Navigate.toZone7a 2|350
	var Navigate.toZone8 2|348
	var Navigate.toZone8a 2|348|70
	var Navigate.toZone9b 2|397
	var Navigate.toZone10 2|396
	var Navigate.toZone11 NA
	var Navigate.toZone12a 2|437
	var Navigate.toZone13 2|147
	var Navigate.toZone14b 2|253
	var Navigate.toZone14c 2|197
	var Navigate.toZone50 2|349|172|87|73
	var Navigate.toZone150 2|349|702
	var Navigate.toZone210 2|349|994
	goto NavigateBegin
zone12a:
	# NTR Misenor Abbey
	var Navigate.toZone1 60|349
	var Navigate.toZone1j 60|349|925
	var Navigate.toZone1k 60|349|926
	var Navigate.toZone1l 60|349|960
	var Navigate.toZone1m 60|349|968
	var Navigate.toZone1n 60|349|993
	var Navigate.toZone2 60|349|172|15
	var Navigate.toZone2a 60|349|466
	var Navigate.toZone2d 60|349|466|188
	var Navigate.toZone4 60|349|172
	var Navigate.toZone4a 60|349|172|87
	var Navigate.toZone6 60|347
	var Navigate.toZone6a 60|347|172
	var Navigate.toZone7 60
	var Navigate.toZone7a 60|350
	var Navigate.toZone8 60|348
	var Navigate.toZone8a 60|348|70
	var Navigate.toZone9b 60|397
	var Navigate.toZone10 60|396
	var Navigate.toZone11 60|394
	var Navigate.toZone12a NA
	var Navigate.toZone13 60|147
	var Navigate.toZone14b 60|253
	var Navigate.toZone14c 60|197
	var Navigate.toZone50 60|349|172|87|73
	var Navigate.toZone150 60|349|702
	var Navigate.toZone210 60|349|994
	goto NavigateBegin
zone13:
	#Dirge
	var Navigate.toZone1 71|349
	var Navigate.toZone1j 71|349|925
	var Navigate.toZone1k 71|349|926
	var Navigate.toZone1l 71|349|960
	var Navigate.toZone1m 71|349|968
	var Navigate.toZone1n 71|349|993
	var Navigate.toZone2 71|349|172|15
	var Navigate.toZone2a 71|349|466
	var Navigate.toZone2d 71|349|466|188
	var Navigate.toZone4 71|349|172
	var Navigate.toZone4a 71|349|172|87
	var Navigate.toZone6 71|347
	var Navigate.toZone6a 71|347|172
	var Navigate.toZone7 71
	var Navigate.toZone7a 71|350
	var Navigate.toZone8 71|348
	var Navigate.toZone8a 71|348|70
	var Navigate.toZone9b 71|397
	var Navigate.toZone10 71|396
	var Navigate.toZone11 71|394
	var Navigate.toZone12a 71|437
	var Navigate.toZone13 NA
	var Navigate.toZone14b 71|253
	var Navigate.toZone14c 71|197
	var Navigate.toZone50 71|349|172|87|73
	var Navigate.toZone150 71|349|702
	var Navigate.toZone210 71|349|994
	goto NavigateBegin
zone14b:
	#NTR Greater Fist Volcano
	var Navigate.toZone1 217|349
	var Navigate.toZone1j 217|349|925
	var Navigate.toZone1k 217|349|926
	var Navigate.toZone1l 217|349|960
	var Navigate.toZone1m 217|349|968
	var Navigate.toZone1n 217|349|993
	var Navigate.toZone2 217|349|172|15
	var Navigate.toZone2a 217|349|466
	var Navigate.toZone2d 217|349|466|188
	var Navigate.toZone4 217|349|172
	var Navigate.toZone4a 217|349|172|87
	var Navigate.toZone6 217|347
	var Navigate.toZone6a 217|347|172
	var Navigate.toZone7 217
	var Navigate.toZone7a 217|350
	var Navigate.toZone8 217|348
	var Navigate.toZone8a 217|348|70
	var Navigate.toZone9b 217|397
	var Navigate.toZone10 217|396
	var Navigate.toZone11 217|394
	var Navigate.toZone12a 217|437
	var Navigate.toZone13 217|147
	var Navigate.toZone14b NA
	var Navigate.toZone14c 217|197
	var Navigate.toZone50 217|349|172|87|73
	var Navigate.toZone150 217|349|702
	var Navigate.toZone210 217|349|994
	goto NavigateBegin
zone14c:
	#TODO: Code Special river section...
	if ($roomid == 11) then gosub Move southwest
	if ($roomid == 2) then {
		gosub Move climb stone bridge
		goto zone7
	}
	gosub Move Southeast
	goto zone14c
zone50:
	#Selgoltha River
	var Navigate.toZone1 36|15|14
	var Navigate.toZone1j 36|15|14|925
	var Navigate.toZone1k 36|15|14|926
	var Navigate.toZone1l 36|15|14|960
	var Navigate.toZone1m 36|15|14|968
	var Navigate.toZone1n 36|15|14|993
	var Navigate.toZone2 36|15|15
	var Navigate.toZone2a 36|15|14|466
	var Navigate.toZone2d 36|15|14|466|188
	var Navigate.toZone4 36|15
	var Navigate.toZone4a 36
	var Navigate.toZone6 36|15|480
	var Navigate.toZone6a 36|15|480|172
	var Navigate.toZone7 36|15|480|98
	var Navigate.toZone7a 36|15|480|98|350
	var Navigate.toZone8 36|15|480|98|348
	var Navigate.toZone8a 36|15|480|98|348|70
	var Navigate.toZone9b 36|15|480|98|397
	var Navigate.toZone10 36|15|480|98|396
	var Navigate.toZone11 36|15|480|98|394
	var Navigate.toZone12a 36|15|480|98|437
	var Navigate.toZone13 36|15|480|98|147
	var Navigate.toZone14b 36|15|480|98|253
	var Navigate.toZone14c 36|15|480|98|197
	var Navigate.toZone50 NA
	var Navigate.toZone150 36|15|14|702
	var Navigate.toZone210 36|15|14|994
	goto NavigateBegin
# ----------------------- END OF ZOLUREN SECTION --------------------------
# ---------------------- BEGIN RIVERHAVEN SECTION -------------------------
zone30:
	# Riverhaven
	var Navigate.toZone30 null
	var Navigate.toZone30a 384
	var Navigate.toZone30b 396
	var Navigate.toZone30c 462
	var Navigate.toZone31 203
	var Navigate.toZone31a 203|100
	var Navigate.toZone31b 203|100|123
	var Navigate.toZone32 204
	var Navigate.toZone33 174
	var Navigate.toZone33a 174|29
	var Navigate.toZone34 174|29|48
	var Navigate.toZone34a 174|29|48|22
	var Navigate.toZone150 445
	goto NavigateBegin
zone30a:
	# Dunshade Manor
	var Navigate.toZone30 57
	var Navigate.toZone30a null
	var Navigate.toZone30b 57|396
	var Navigate.toZone30c 57|462
	var Navigate.toZone31 57|203
	var Navigate.toZone31a 57|203|100
	var Navigate.toZone31b 57|203|100|123
	var Navigate.toZone32 57|204
	var Navigate.toZone33 57|174
	var Navigate.toZone33a 57|174|29
	var Navigate.toZone34 57|174|29|48
	var Navigate.toZone34a 57|174|29|48|22
	var Navigate.toZone150 57|445
	goto NavigateBegin
zone30b:
	# Haven Thief Passages
	var Navigate.toZone30 14
	var Navigate.toZone30a 14|384
	var Navigate.toZone30b null
	var Navigate.toZone30c 14|462
	var Navigate.toZone31 14|203
	var Navigate.toZone31a 14|203|100
	var Navigate.toZone31b 14|203|100|123
	var Navigate.toZone32 14|204
	var Navigate.toZone33 14|174
	var Navigate.toZone33a 14|174|29
	var Navigate.toZone34 14|174|29|48
	var Navigate.toZone34a 14|174|29|48|22
	var Navigate.toZone150 14|445
	goto NavigateBegin
zone30c:
	# Haven Necromancer Guild
	var Navigate.toZone30 19
	var Navigate.toZone30a 19|384
	var Navigate.toZone30b 19|396
	var Navigate.toZone30c null
	var Navigate.toZone31 19|203
	var Navigate.toZone31a 19|203|100
	var Navigate.toZone31b 19|203|100|123
	var Navigate.toZone32 19|204
	var Navigate.toZone33 19|174
	var Navigate.toZone33a 19|174|29
	var Navigate.toZone34 19|174|29|48
	var Navigate.toZone34a 19|174|29|48|22
	var Navigate.toZone150 19|445
	goto NavigateBegin
zone31:
	# Riverhaven East Gate
	var Navigate.toZone30 1
	var Navigate.toZone30a 1|384
	var Navigate.toZone30b 1|396
	var Navigate.toZone30c 1|462
	var Navigate.toZone31 null
	var Navigate.toZone31a 100
	var Navigate.toZone31b 100|123
	var Navigate.toZone32 1|204
	var Navigate.toZone33 1|174
	var Navigate.toZone33a 1|174|29
	var Navigate.toZone34 1|174|29|48
	var Navigate.toZone34a 1|174|29|48|22
	var Navigate.toZone150 1|445
	goto NavigateBegin
zone31a:
	# Zaulfung
	var Navigate.toZone30 122|1
	var Navigate.toZone30a 122|1|384
	var Navigate.toZone30b 122|1|396
	var Navigate.toZone30c 122|1|462
	var Navigate.toZone31 122
	var Navigate.toZone31a null
	var Navigate.toZone31b 123
	var Navigate.toZone32 122|1|204
	var Navigate.toZone33 122|1|174
	var Navigate.toZone33a 122|1|174|29
	var Navigate.toZone34 122|1|174|29|48
	var Navigate.toZone34a 122|1|174|29|48|22
	var Navigate.toZone150 122|1|445
	goto NavigateBegin
zone31b:
	# Maelshyve's Fortress
	var Navigate.toZone30 5|122|1
	var Navigate.toZone30a 5|122|1|384
	var Navigate.toZone30b 5|122|1|396
	var Navigate.toZone30c 5|122|1|462
	var Navigate.toZone31 5|122
	var Navigate.toZone31a 5
	var Navigate.toZone31b null
	var Navigate.toZone32 5|122|1|204
	var Navigate.toZone33 5|122|1|174
	var Navigate.toZone33a 5|122|1|174|29
	var Navigate.toZone34 5|122|1|174|29|48
	var Navigate.toZone34a 5|122|1|174|29|48|22
	var Navigate.toZone150 5|122|1|445
	goto NavigateBegin
zone32:
	# Riverhaven North Gate
	var Navigate.toZone30 1
	var Navigate.toZone30a 1|384
	var Navigate.toZone30b 1|396
	var Navigate.toZone30c 1|462
	var Navigate.toZone31 1|203
	var Navigate.toZone31a 1|203|100
	var Navigate.toZone31b 1|203|100|123
	var Navigate.toZone32 null
	var Navigate.toZone33 1|174
	var Navigate.toZone33a 1|174|29
	var Navigate.toZone34 1|174|29|48
	var Navigate.toZone34a 1|174|29|48|22
	var Navigate.toZone150 1|445
	goto NavigateBegin
zone33:
	# Riverhaven West Gate
	var Navigate.toZone30 1
	var Navigate.toZone30a 1|384
	var Navigate.toZone30b 1|396
	var Navigate.toZone30c 1|462
	var Navigate.toZone31 1|203
	var Navigate.toZone31a 1|203|100
	var Navigate.toZone31b 1|203|100|123
	var Navigate.toZone32 1|204
	var Navigate.toZone33 null
	var Navigate.toZone33a 29
	var Navigate.toZone34 29|48
	var Navigate.toZone34a 29|48|22
	var Navigate.toZone150 1|445
	goto NavigateBegin
zone33a:
	# Road to Therenbourough
	var Navigate.toZone30 46|1
	var Navigate.toZone30a 46|1|384
	var Navigate.toZone30b 46|1|396
	var Navigate.toZone30c 46|1|462
	var Navigate.toZone31 46|1|203
	var Navigate.toZone31a 46|1|203|100
	var Navigate.toZone31b 46|1|203|100|123
	var Navigate.toZone32 46|1|204
	var Navigate.toZone33 46
	var Navigate.toZone33a null
	var Navigate.toZone34 48
	var Navigate.toZone34a 48|22
	var Navigate.toZone150 46|1|445
	goto NavigateBegin
zone34:
	# Mistwood Forest
	# Note: zone34 connections to Theren have not been thoroughly tested.
	var Navigate.toZone30 15|46|1
	var Navigate.toZone30a 15|46|1|384
	var Navigate.toZone30b 15|46|1|396
	var Navigate.toZone30c 15|46|1|462
	var Navigate.toZone31 15|46|1|203
	var Navigate.toZone31a 15|46|1|203|100
	var Navigate.toZone31b 15|46|1|203|100|123
	var Navigate.toZone32 15|46|1|204
	var Navigate.toZone33 15|46
	var Navigate.toZone33a 15
	var Navigate.toZone34 null
	var Navigate.toZone34a 22
	var Navigate.toZone40 137
	var Navigate.toZone40a 137|263
	var Navigate.toZone41 137|376
	var Navigate.toZone42 137|211
	var Navigate.toZone48 137|376|208
	var Navigate.toZone150 137|378
	var Navigate.toZone230 137|316
	#var Navigate.toZone150 15|46|1|445 <- todo: determine which side of the rope bridge I'm on before traveling
	goto NavigateBegin
zone34a:
	# Rossman's Landing
	var Navigate.toZone30 134|15|46|1
	var Navigate.toZone30a 134|15|46|1|384
	var Navigate.toZone30b 134|15|46|1|396
	var Navigate.toZone30c 134|15|46|1|462
	var Navigate.toZone31 134|15|46|1|203
	var Navigate.toZone31a 134|15|46|1|203|100
	var Navigate.toZone31b 134|15|46|1|203|100|123
	var Navigate.toZone32 134|15|46|1|204
	var Navigate.toZone33 134|15|46
	var Navigate.toZone33a 134|15
	var Navigate.toZone34 134
	var Navigate.toZone34a null
	var Navigate.toZone40 134|137
	var Navigate.toZone40a 134|137|263
	var Navigate.toZone41 134|137|376
	var Navigate.toZone42 134|137|211
	var Navigate.toZone48 134|137|376|208
	var Navigate.toZone230 134|137|316
	var Navigate.toZone150 134|15|46|1|445
	goto NavigateBegin
# ----------------------- END OF RIVERHAVEN SECTION --------------------------
# ----------------------- START OF THEREN SECTION --------------------------
zone40:
	var Navigate.toZone40 null
	var Navigate.toZone40a 263
	var Navigate.toZone41 376
	var Navigate.toZone42 211
	var Navigate.toZone48 376|208
	var Navigate.toZone150 378
	var Navigate.toZone230 316
	goto NavigateBegin
zone40a:
	var Navigate.toZone40 125
	var Navigate.toZone40a null
	var Navigate.toZone41 125|376
	var Navigate.toZone42 125|211
	var Navigate.toZone48 125|376|208
	var Navigate.toZone150 125|378
	var Navigate.toZone230 125|316
	goto NavigateBegin
zone41:
	var Navigate.toZone40 53
	var Navigate.toZone40a 53|263
	var Navigate.toZone41 null
	var Navigate.toZone42 53|211
	var Navigate.toZone48 208
	var Navigate.toZone150 53|378
	var Navigate.toZone230 53|316
	goto NavigateBegin
zone42:
	var Navigate.toZone40 2
	var Navigate.toZone40a 2|263
	var Navigate.toZone41 2|376
	var Navigate.toZone42 null
	var Navigate.toZone48 2|376|208
	var Navigate.toZone150 2|378
	var Navigate.toZone230 2|316
	goto NavigateBegin
zone48:
	var Navigate.toZone40 92|53
	var Navigate.toZone40a 92|53|263
	var Navigate.toZone41 92
	var Navigate.toZone42 92|53|211
	var Navigate.toZone48 null
	var Navigate.toZone150 92|53|378
	var Navigate.toZone230 92|53|316
	goto NavigateBegin
zone230:
	var Navigate.toZone40 101
	var Navigate.toZone40a 101|263
	var Navigate.toZone41 101|376
	var Navigate.toZone42 101|211
	var Navigate.toZone48 101|376|208
	var Navigate.toZone150 101|378
	var Navigate.toZone230 null
	goto NavigateBegin
# ----------------------- END OF THEREN SECTION --------------------------
# -------------------- START OF MUSPAR'I SECTION -------------------------
zone47:
	var Navigate.toZone150 483
	goto NavigateBegin
# ---------------------- END OF MUSPAR'I SECTION -------------------------
# ----------------------- START OF LETH SECTION --------------------------
zone58:
	# Acenmacra Village
	var Navigate.toZone58 null
	var Navigate.toZone59 2|182
	var Navigate.toZone60 2|115
	var Navigate.toZone61 2
	var Navigate.toZone62 2|130
	var Navigate.toZone63 2|130|102
	var Navigate.toZone112 2|126
	var Navigate.toZone150 2|236
	goto NavigateBegin
zone59:
	# Moss Meys (Boggy Wood) by Leth
	var Navigate.toZone58 12|178
	var Navigate.toZone59 null
	var Navigate.toZone60 12|115
	var Navigate.toZone61 12
	var Navigate.toZone62 12|130
	var Navigate.toZone63 12|130|102
	var Navigate.toZone112 12|126
	var Navigate.toZone150 12|236
	goto NavigateBegin
zone60:
	# North of Leth
	var Navigate.toZone58 57|178
	var Navigate.toZone59 57|182
	var Navigate.toZone60 null
	var Navigate.toZone61 57
	var Navigate.toZone62 57|130
	var Navigate.toZone63 57|130|102
	var Navigate.toZone112 57|126
	var Navigate.toZone150 57|236
	goto NavigateBegin
zone61:
	# Leth Deriel
	var Navigate.toZone58 178
	var Navigate.toZone59 182
	var Navigate.toZone60 115
	var Navigate.toZone61 null
	var Navigate.toZone62 130
	var Navigate.toZone63 130|102
	var Navigate.toZone112 126
	var Navigate.toZone150 236
	goto NavigateBegin
zone62:
	# STR / South of Leth
	var Navigate.toZone58 101|178
	var Navigate.toZone59 101|182
	var Navigate.toZone60 101|115
	var Navigate.toZone61 101
	var Navigate.toZone62 null
	var Navigate.toZone63 102
	var Navigate.toZone112 101|126
	var Navigate.toZone150 101|236
	goto NavigateBegin
zone63:
	# Oshu'ehhrsk Manor
	var Navigate.toZone58 112|101|178
	var Navigate.toZone59 112|101|182
	var Navigate.toZone60 112|101|115
	var Navigate.toZone61 112|101
	var Navigate.toZone62 112
	var Navigate.toZone63 null
	var Navigate.toZone112 112|101|126
	var Navigate.toZone150 112|101|236
	goto NavigateBegin
zone112:
	# Ilaya Taipa (River Clan)
	var Navigate.toZone58 112|178
	var Navigate.toZone59 112|182
	var Navigate.toZone60 112|115
	var Navigate.toZone61 112
	var Navigate.toZone62 112|130
	var Navigate.toZone63 112|130|102
	var Navigate.toZone112 null
	var Navigate.toZone150 112|236
	goto NavigateBegin
# ----------------------- END OF LETH SECTION --------------------------
# ----------------------- START OF SHARD SECTION --------------------------
zone65:
	# Undergondola Path North
	var Navigate.toZone65 null
	var Navigate.toZone66 1
	var Navigate.toZone67 1|216
	var Navigate.toZone67a 1|216|595
	var Navigate.toZone68 1|216|230
	var Navigate.toZone68a 1|216|230|214
	var Navigate.toZone68b 1|216|230|207
	var Navigate.toZone69 1|217
	var Navigate.toZone70 1|217|452
	var Navigate.toZone71 1|217|452|95
	var Navigate.toZone116 1|217|283|169
	var Navigate.toZone123 1|217|283
	var Navigate.toZone126 1|217|283|169|217
	var Navigate.toZone127 1|217|283|169|217|103
	var Navigate.toZone128 1|217|283|169|217|103|635
	var Navigate.toZone150 1|618
	var Navigate.toZone240 1|658
	goto NavigateBegin
zone66:
	# North of Shard / South of Gondola
	var Navigate.toZone65 317
	var Navigate.toZone66 null
	var Navigate.toZone67 216
	var Navigate.toZone67a 216|595
	var Navigate.toZone68 216|230
	var Navigate.toZone68a 216|230|214
	var Navigate.toZone68b 216|230|207
	var Navigate.toZone69 217
	var Navigate.toZone70 217|452
	var Navigate.toZone71 217|452|95
	var Navigate.toZone116 217|283|169
	var Navigate.toZone123 217|283
	var Navigate.toZone126 217|283|169|217
	var Navigate.toZone127 217|283|169|217|103
	var Navigate.toZone128 217|283|169|217|103|635
	var Navigate.toZone150 618
	var Navigate.toZone240 658
	goto NavigateBegin
zone67:
	# Shard Proper
	var Navigate.toZone65 132|317
	var Navigate.toZone66 132
	var Navigate.toZone67 null
	var Navigate.toZone67a 595
	var Navigate.toZone68 230
	var Navigate.toZone68a 230|214
	var Navigate.toZone68b 230|207
	var Navigate.toZone69 129
	var Navigate.toZone70 129|452
	var Navigate.toZone71 129|452|95
	var Navigate.toZone116 129|283|169
	var Navigate.toZone123 129|283
	var Navigate.toZone126 129|283|169|217
	var Navigate.toZone127 129|283|169|217|103
	var Navigate.toZone128 129|283|169|217|103|635
	var Navigate.toZone150 132|618
	var Navigate.toZone240 132|658
	goto NavigateBegin
zone67a:
	# Thief Passages
	# Note: Currently impossible to navigate TO rooms 18, 20, 21, 22 due to unconnected passage
	if contains("18|20|21|22","$roomid") then var firstDestination 23
	else var firstDestionation 8
	var Navigate.toZone65 %firstDestionation|132|317
	var Navigate.toZone66 %firstDestionation|132
	var Navigate.toZone67 %firstDestionation
	var Navigate.toZone67a null
	var Navigate.toZone68 %firstDestionation|230
	var Navigate.toZone68a %firstDestionation|230|214
	var Navigate.toZone68b %firstDestionation|230|207
	var Navigate.toZone69 %firstDestionation|129
	var Navigate.toZone70 %firstDestionation|129|452
	var Navigate.toZone71 %firstDestionation|129|452|95
	var Navigate.toZone116 %firstDestionation|129|283|169
	var Navigate.toZone123 %firstDestionation|129|283
	var Navigate.toZone126 %firstDestionation|129|283|169|217
	var Navigate.toZone127 %firstDestionation|129|283|169|217|103
	#var Navigate.toZone128 %firstDestionation|129|283|169|217|103|635 Not possible to navigate from thief passage to necro guild...
	var Navigate.toZone150 %firstDestionation|132|618
	var Navigate.toZone240 %firstDestionation|132|658
	goto NavigateBegin
zone68:
	# South of Shard
	var Navigate.toZone65 225|132|317
	var Navigate.toZone66 225|132
	var Navigate.toZone67 225
	var Navigate.toZone67a 225|162
	var Navigate.toZone68 null
	var Navigate.toZone68a 214
	var Navigate.toZone68b 207
	var Navigate.toZone69 225|129
	var Navigate.toZone70 225|129|452
	var Navigate.toZone71 225|129|452|95
	var Navigate.toZone116 225|129|283|169
	var Navigate.toZone123 225|129|283
	var Navigate.toZone126 225|129|283|169|217
	var Navigate.toZone127 225|129|283|169|217|103
	var Navigate.toZone128 225|129|283|169|217|103|635
	var Navigate.toZone150 225|132|618
	var Navigate.toZone240 225|132|658
	goto NavigateBegin
zone68a:
	# Ice Caves South of Shard
	# Try to avoid crossing the stupid bridge at all costs.
	var FirstRoom 30
	if contains("|1|2|3|4|5|6|", "|$roomid|") then var FirstRoom 29
	var Navigate.toZone65 %FirstRoom|225|132|317
	var Navigate.toZone66 %FirstRoom|225|132
	var Navigate.toZone67 %FirstRoom|225
	var Navigate.toZone67a %FirstRoom|225|162
	var Navigate.toZone68 %FirstRoom
	var Navigate.toZone68a null
	var Navigate.toZone68b %FirstRoom|207
	var Navigate.toZone69 %FirstRoom|225|129
	var Navigate.toZone70 %FirstRoom|225|129|452
	var Navigate.toZone71 %FirstRoom|225|129|452|95
	var Navigate.toZone116 %FirstRoom|225|129|283|169
	var Navigate.toZone123 %FirstRoom|225|129|283
	var Navigate.toZone126 %FirstRoom|225|129|283|169|217
	var Navigate.toZone127 %FirstRoom|225|129|283|169|217|103
	var Navigate.toZone128 %FirstRoom|225|129|283|169|217|103|635
	var Navigate.toZone150 %FirstRoom|225|132|618
	var Navigate.toZone240 %FirstRoom|225|132|658
	goto NavigateBegin
zone68b:
	# Corik's Wall / DMZ
	var Navigate.toZone65 44|225|132|317
	var Navigate.toZone66 44|225|132
	var Navigate.toZone67 44|225
	var Navigate.toZone67a 44|225|162
	var Navigate.toZone68 44
	var Navigate.toZone68a 44|214
	var Navigate.toZone68b null
	var Navigate.toZone69 44|225|129
	var Navigate.toZone70 44|225|129|452
	var Navigate.toZone71 44|225|129|452|95
	var Navigate.toZone116 44|225|129|283|169
	var Navigate.toZone123 44|225|129|283
	var Navigate.toZone126 44|225|129|283|169|217
	var Navigate.toZone127 44|225|129|283|169|217|103
	var Navigate.toZone128 44|225|129|283|169|217|103|635
	var Navigate.toZone150 44|225|132|618
	var Navigate.toZone240 44|225|132|658
	goto NavigateBegin
zone69:
	# West of Shard
	var Navigate.toZone65 1|317
	var Navigate.toZone66 1
	var Navigate.toZone67 31
	var Navigate.toZone67a 31|595
	var Navigate.toZone68 31|230
	var Navigate.toZone68a 31|230|214
	var Navigate.toZone68b 31|230|207
	var Navigate.toZone69 null
	var Navigate.toZone70 452
	var Navigate.toZone71 452|95
	var Navigate.toZone116 283|169
	var Navigate.toZone123 283
	var Navigate.toZone126 283|169|217
	var Navigate.toZone127 283|169|217|103
	var Navigate.toZone128 283|169|217|103|635
	var Navigate.toZone150 1|618
	var Navigate.toZone240 1|658
	goto NavigateBegin
zone70:
	# Wyvern Mountains, West of Shard
	var Navigate.toZone65 3|1|317
	var Navigate.toZone66 3|1
	var Navigate.toZone67 3|31
	var Navigate.toZone67a 3|31|595
	var Navigate.toZone68 3|31|230
	var Navigate.toZone68a 3|31|230|214
	var Navigate.toZone68b 3|31|230|207
	var Navigate.toZone69 3
	var Navigate.toZone70 null
	var Navigate.toZone71 95
	var Navigate.toZone116 3|283|169
	var Navigate.toZone123 3|283
	var Navigate.toZone126 3|283|169|217
	var Navigate.toZone127 3|283|169|217|103
	var Navigate.toZone128 3|283|169|217|103|635
	var Navigate.toZone150 3|1|618
	var Navigate.toZone240 3|1|658
	goto NavigateBegin
zone71:
	# Shard Necromancer Guild
	var Navigate.toZone65 9|3|1|317
	var Navigate.toZone66 9|3|1
	var Navigate.toZone67 9|3|31
	var Navigate.toZone67a 9|3|31|595
	var Navigate.toZone68 9|3|31|230
	var Navigate.toZone68a 9|3|31|230|214
	var Navigate.toZone68b 9|3|31|230|207
	var Navigate.toZone69 9|3
	var Navigate.toZone70 9
	var Navigate.toZone71 null
	var Navigate.toZone116 9|3|283|169
	var Navigate.toZone123 9|3|283
	var Navigate.toZone126 9|3|283|169|217
	var Navigate.toZone127 9|3|283|169|217|103
	var Navigate.toZone128 9|3|283|169|217|103|635
	var Navigate.toZone150 9|3|1|618
	var Navigate.toZone240 9|3|1|658
	goto NavigateBegin
zone113:
	# Ferry Zone between Shard/Leth/Ain Ghazal
	if (contains("|4|11|", "$roomid")) then {
		var Navigate.toZone114 10
		var Navigate.toZone150 10|176
	}
	if ("$roomid" == "8") then {
		var Navigate.toZone114 9
		var Navigate.toZone150 9|176
	}
	if ("$roomid" == "1") then {
		var Navigate.toZone112 5
	}
	if ("$roomid" == "6") then {
		var Navigate.toZone123 7
	}
	goto NavigateBegin
zone114:
	# Ain Ghazal
	var Navigate.toZone113 1
	var Navigate.toZone150 176
	goto NavigateBegin
zone116:
	# Hibarnhvidar
	var Navigate.toZone65 3|175|1|317
	var Navigate.toZone66 3|175|1
	var Navigate.toZone67 3|175|31
	var Navigate.toZone67a 3|175|31|595
	var Navigate.toZone68 3|175|31|230
	var Navigate.toZone68a 3|175|31|230|214
	var Navigate.toZone68b 3|175|31|230|207
	var Navigate.toZone69 3|175
	var Navigate.toZone70 3|175|452
	var Navigate.toZone71 3|175|452|95
	var Navigate.toZone116 null
	var Navigate.toZone123 3
	var Navigate.toZone126 217
	var Navigate.toZone127 217|103
	var Navigate.toZone128 217|103|635
	var Navigate.toZone150 425
	var Navigate.toZone240 3|175|1|658
	goto NavigateBegin
zone123:
	# Raven's Point
	var Navigate.toZone65 175|1|317
	var Navigate.toZone66 175|1
	var Navigate.toZone67 175|31
	var Navigate.toZone67a 175|31|595
	var Navigate.toZone68 175|31|230
	var Navigate.toZone68a 175|31|230|214
	var Navigate.toZone68b 175|31|230|207
	var Navigate.toZone69 175
	var Navigate.toZone70 175|452
	var Navigate.toZone71 175|452|95
	var Navigate.toZone116 169
	var Navigate.toZone123 null
	var Navigate.toZone126 169|217
	var Navigate.toZone127 169|217|103
	var Navigate.toZone128 169|217|103|635
	var Navigate.toZone150 169|425
	var Navigate.toZone240 175|1|658
	goto NavigateBegin
zone126:
	# Hawkstaal Road (Between Hib and Boar Clan)
	var Navigate.toZone65 49|3|175|1|317
	var Navigate.toZone66 49|3|175|1
	var Navigate.toZone67 49|3|175|31
	var Navigate.toZone67a 49|3|175|31|595
	var Navigate.toZone68 49|3|175|31|230
	var Navigate.toZone68a 49|3|175|31|230|214
	var Navigate.toZone68b 49|3|175|31|230|207
	var Navigate.toZone69 49|3|175
	var Navigate.toZone70 49|3|175|452
	var Navigate.toZone71 49|3|175|452|95
	var Navigate.toZone116 49
	var Navigate.toZone123 49|3
	var Navigate.toZone126 null
	var Navigate.toZone127 103
	var Navigate.toZone128 103|635
	var Navigate.toZone150 49|425
	var Navigate.toZone240 49|3|175|1|658
	goto NavigateBegin
zone127:
	# Boar Clan & Asketi's Mount
	var Navigate.toZone65 510|49|3|175|1|317
	var Navigate.toZone66 510|49|3|175|1
	var Navigate.toZone67 510|49|3|175|31
	var Navigate.toZone67a 510|49|3|175|31|595
	var Navigate.toZone68 510|49|3|175|31|230
	var Navigate.toZone68a 510|49|3|175|31|230|214
	var Navigate.toZone68b 510|49|3|175|31|230|207
	var Navigate.toZone69 510|49|3|175
	var Navigate.toZone70 510|49|3|175|452
	var Navigate.toZone71 510|49|3|175|452|95
	var Navigate.toZone116 510|49
	var Navigate.toZone123 510|49|3
	var Navigate.toZone126 510
	var Navigate.toZone127 null
	var Navigate.toZone128 635
	var Navigate.toZone150 510|49|425
	var Navigate.toZone240 510|49|3|175|1|658
	goto NavigateBegin
zone128:
	# P5 Necromancer Guild
	var Navigate.toZone65 4|510|49|3|175|1|317
	var Navigate.toZone66 4|510|49|3|175|1
	var Navigate.toZone67 4|510|49|3|175|31
	var Navigate.toZone67a 4|510|49|3|175|31|595
	var Navigate.toZone68 4|510|49|3|175|31|230
	var Navigate.toZone68a 4|510|49|3|175|31|230|214
	var Navigate.toZone68b 4|510|49|3|175|31|230|207
	var Navigate.toZone69 4|510|49|3|175
	var Navigate.toZone70 4|510|49|3|175|452
	var Navigate.toZone71 4|510|49|3|175|452|95
	var Navigate.toZone116 4|510|49
	var Navigate.toZone123 4|510|49|3
	var Navigate.toZone126 4|510
	var Navigate.toZone127 4
	var Navigate.toZone128 null
	var Navigate.toZone150 4|510|49|425
	var Navigate.toZone240 4|510|49|3|175|1|658
	goto NavigateBegin
zone240:
# Duskruin
	var Navigate.toZone65 28|317
	var Navigate.toZone66 28
	var Navigate.toZone67 28|216
	var Navigate.toZone67a 28|216|595
	var Navigate.toZone68 28|216|230
	var Navigate.toZone68a 28|216|230|214
	var Navigate.toZone68b 28|216|230|207
	var Navigate.toZone69 28|217
	var Navigate.toZone70 28|217|452
	var Navigate.toZone71 28|217|452|95
	var Navigate.toZone116 28|217|283|169
	var Navigate.toZone123 28|217|283
	var Navigate.toZone126 28|217|283|169|217
	var Navigate.toZone127 28|217|283|169|217|103
	var Navigate.toZone128 28|217|283|169|217|103|635
	var Navigate.toZone150 28|618
	var Navigate.toZone240 null
	goto NavigateBegin
# ----------------------- END OF SHARD SECTION --------------------------
# ----------------------- BEGIN RATHA SECTION ---------------------------
zone90:
	# Ratha
	var Navigate.toZone90 null
	var Navigate.toZone90a 228
	var Navigate.toZone90d 628
	var Navigate.toZone92 663
	var Navigate.toZone95 662
	var Navigate.toZone150 841
	goto NavigateBegin
zone90a:
	# Sand Sprites
	var Navigate.toZone90 1
	var Navigate.toZone90a null
	var Navigate.toZone90d 1|628
	var Navigate.toZone92 1|663
	var Navigate.toZone95 1|662
	var Navigate.toZone150 1|841
	goto NavigateBegin
zone90d:
	# Taisgath
	var Navigate.toZone90 63
	var Navigate.toZone90a 63|228
	var Navigate.toZone90d null
	var Navigate.toZone92 63|663
	var Navigate.toZone95 63|662
	var Navigate.toZone150 63|841
	goto NavigateBegin
zone92:
	# NW of Ratha
	var Navigate.toZone90 1
	var Navigate.toZone90a 1|228
	var Navigate.toZone90d 1|628
	var Navigate.toZone92 null
	var Navigate.toZone95 1|662
	var Navigate.toZone150 1|841
	goto NavigateBegin
zone95:
	# NE of Ratha
	var Navigate.toZone90 1
	var Navigate.toZone90a 1|228
	var Navigate.toZone90d 1|628
	var Navigate.toZone92 1|663
	var Navigate.toZone95 null
	var Navigate.toZone150 1|841
	goto NavigateBegin
# ----------------------- END OF RATHA SECTION --------------------------
# ------------------------ BEGIN AESRY SECTION --------------------------
zone98:
	# Road to Aesry
	var Navigate.toZone98 null
	var Navigate.toZone98a 36
	var Navigate.toZone99 86
	var Navigate.toZone150 86|392
	goto NavigateBegin
zone98a:
	# Aesry Sea Caves
	var Navigate.toZone98 97
	var Navigate.toZone98a null
	var Navigate.toZone99 97|86
	var Navigate.toZone150 97|86|392
	goto NavigateBegin
zone99:
	# Aesry Proper
	var Navigate.toZone98 390
	var Navigate.toZone98a 390|35
	var Navigate.toZone99 null
	var Navigate.toZone150 392
	goto NavigateBegin
zone106:
	# Hara'jaal
	var Navigate.toZone150 99
	goto NavigateBegin
zone107:
	# Mer'Kresh
	var Navigate.toZone150 315
	echo * Nothing besides Fang Cove linked from this zone. *
	echo * Use .travel to reach M'riss or other destinations, sorry.
	goto NavigateBegin
zone108:
	# M'Riss
	var Navigate.toZone150 378
	goto NavigateBegin
zone300:
	echo .n.cmd should not be started in the ways, something fucked up
	put #script abort all except %scriptname
	put exit
	pause
	exit
# --------------------- END OF NAVIGATION VAR SETUP ------------------------

NavigateBegin:
	var Navigate.destinationRoomList %Navigate.toZone%Navigate.destinationZone
	if ("%Navigate.destinationRoomList" == "null") then {
		gosub Error NO DEFINED ROUTE FROM $zoneid to %Navigate.destinationZone
		return
	}
	var Navigate.index 0
	eval Navigate.maxIndex count("%Navigate.destinationRoomList","|")
Navigating:
	eval Navigate.nextDestinationRoom element("%Navigate.destinationRoomList", "%Navigate.index")
	gosub NavigationMoveToNewMap %Navigate.nextDestinationRoom
	math Navigate.index add 1
	# Pause for map load:
	pause .2
	if (%Navigate.index <= %Navigate.maxIndex) then goto Navigating
	#echo * Finished navigating zone, now going to destination room. *
NavigateAlreadyInZone:
	if ("$roomname" == "Caught, Behind the Spider") then gosub NavigateWaitOnSpider
	if ("%Navigate.destinationRoom" == "" || "%Navigate.destinationRoom" == "$roomid") then {
		gosub Information Finished Navigation to $zoneid.
		# Note: no destination room selected, or we are already in it.
		goto NavigationFinished
	}
	gosub NavigationMoveTo %Navigate.destinationRoom
NavigationFinished:
	return

NavigationMoveTo:
	pause .5
	var Navigate.roomToMoveTo $0
	put /g %Navigate.roomToMoveTo
	waitforre ^YOU HAVE ARRIVED
	return

NavigationMoveToNewMap:
	var Navigate.roomToMoveTo $0
	var Navigate.originZone $zoneid
	if ("$roomname" == "Caught, Behind the Spider") then gosub NavigateWaitOnSpider
	if ("$roomid" == "0") then gosub NavigateMoveUntilRoomHasID
	put /g %Navigate.roomToMoveTo
	waitforre ^YOU HAVE ARRIVED
WaitingForMapToLoad:
# todo: need to only wait a max amount of time....
	if (contains("$roomdesc", "The landscape is dull and uninteresting, stretching for miles")) then {
		# Special code for the road west of Theren to Seords...
		waitforre ^Just when it seems you will never reach the end of the road, you .+ through a patch of brush to your Navigate.roomToMoveTo\.\.\.
		return
	}
	if ("$zoneid" != "%Navigate.originZone") then return
	echo Pausing for map load...
	pause
	goto WaitingForMapToLoad

NavigationResetMap:
	put #var zoneid 0
	put #mapper reset
NavigationWaitingOnMapReset:
	if "$zoneid" != "0" then return
	echo Waiting on map load after reset...
	pause .05
	goto NavigationWaitingOnMapReset

NavigateArrested:
	#Todo: add arrested.cmd here
	gosub Warning Arrested while navigating!
	exit

NavigateDestinationNotFound:
	# todo: better logic here
	# call map reset, then begin navigation all over again
	put #mapper reset
	pause
	goto NavigateStart

NavigateWaitOnSpider:
	if ("$roomname" != "Caught, Behind the Spider") then return
	pause .3
	goto NavigateWaitOnSpider

NavigateMoveUntilRoomHasID:
	if ($roomid != 0) then return
	gosub MoveRandom
	goto NavigateMoveUntilRoomHasID