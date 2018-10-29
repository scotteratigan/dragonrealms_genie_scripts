#REQUIRE Error.cmd
#REQUIRE Information.cmd
#REQUIRE Move.cmd
#REQUIRE Release.cmd
#REQUIRE Send.cmd
#REQUIRE Stand.cmd


gosub Navigate %0
exit

Navigate:
var Navigate.destinationZone $1
var Navigate.destinationRoom $2
var Navigate.failedMoves 0
action math Navigate.failedMoves add 1;if %Navigate.failedMoves > 5 then goto Navigate when ^You can't go there\.|^What were you referring to\?
action goto NavigateArrested when ^Arriving at the jail, the guard submits you to a brutal strip search and throws your things into a large sack\.  From there you are dragged down a dark hallway and into a cell\.
action goto NavigateClearHandsReset when ^The going gets quite difficult and highlights the need to free up your hands to climb down any further\.$
action goto NavigateTrippedReset when ^Running heedlessly over the rough terrain, you trip over an exposed root and are sent flying .+\.$
action echo Fell to ground, re-sending navigation command.;put #queue clear;goto Navigate when ^The ground approaches you at an alarming rate\!  SPLAT\!$
action goto NavigateDestinationNotFound when ^DESTINATION NOT FOUND$

Navigate:
pause .01
if ("$SpellTimer.UniversalSolvent.active" != "0") then gosub Release USOL
if ($standing != 1) then gosub Stand
if ("%Navigate.destinationZone" == "") then {
	gosub Error Navigate: MUST SPECIFY DESTINATION ZONE
	return
}
gosub Information Navigating to %Navigate.destinationZone %Navigate.destinationRoom

if (contains("|14c|34|40a|", "|$zoneid|")) then goto NavigateSkipLostCheck


# Todo: add clockwise/widdershins and forward/aft to random move section?

if $roomid == 0 then
{
	echo * Automapper currently lost *
	if "$zoneid" == "150" then
	{
		if "$north" == 1 then gosub Move north
		if "$roomdesc" == "Crinkled patches of metal stain the dolomite floor.  The splattering becomes more numerous and expands to form concentric circles near the room's center, where a large granite crucible hangs over a large fire." then gosub Move go door
		if "$roomid" != "0" then
		{
			gosub alert white Successfully fixed room issue in Fang Cove!
			goto FindLocation
		}
	}

	if "$zoneid" == "300" then
	{
		echo * Lost in The Ways, no bueno! *
		put #script abort reconnect
		pause
		put #script abort all except n
		pause
		put exit
		put exit
		put exit
		pause 10
		exit
	}
	gosub alert red * I'm lost: Attempting to move randomly to find current location. *
	if $out then
	{
		action send retreat;send out when ^You are engaged
		put out
		wait
		goto FindLocation
	}
	if $north then
	{
		action send retreat;send north when ^You are engaged
		put north
		wait
		goto FindLocation
	}
	if $northeast then
	{
		action send retreat;send northeast when ^You are engaged
		put northeast
		wait
		goto FindLocation
	}
	if $east then
	{
		action send retreat;send east when ^You are engaged
		put east
		wait
		goto FindLocation
	}
	if $southeast then
	{
		action send retreat;send southeast when ^You are engaged
		put southeast
		wait
		goto FindLocation
	}
	if $south then
	{
		action send retreat;send south when ^You are engaged
		put south
		wait
		goto FindLocation
	}
	if $southwest then
	{
		action send retreat;send southwest when ^You are engaged
		put southwest
		wait
		goto FindLocation
	}
	if $west then
	{
		action send retreat;send west when ^You are engaged
		put west
		wait
		goto FindLocation
	}
	if $northwest then
	{
		action send retreat;send northwest when ^You are engaged
		put northwest
		wait
		goto FindLocation
	}
	if $up then
	{
		action send retreat;send up when ^You are engaged
		put up
		wait
		goto FindLocation
	}
	if $down then
	{
		action send retreat;send down when ^You are engaged
		put down
		wait
		goto FindLocation
	}
	if $out then
	{
		action send retreat;send out when ^You are engaged
		put out
		wait
		goto FindLocation
	}
	echo No known cardinal directions exist. Todo: code special list of broken rooms.
}

NavigateSkipLostCheck:
#CrossingZones:
var tozone1 NULL
var tozone1j NULL
var tozone1k NULL
var tozone1l NULL
var tozone1m NULL
var tozone1n NULL
var tozone2 NULL
var tozone2a NULL
var tozone2d NULL
var tozone3 NULL
var tozone4 NULL
var tozone4a NULL
var tozone5 NULL
var tozone6 NULL
var tozone7 NULL
var tozone7a NULL
var tozone8 NULL
var tozone8a NULL
var tozone9b NULL
var tozone10 NULL
var tozone11 NULL
var tozone12a NULL
var tozone13 NULL
var tozone14b NULL
var tozone14c NULL
var tozone50 NULL

#RossmansZones:
var tozone34 NULL
var tozone34a NULL

#ShardZones:
var tozone65 NULL
var tozone66 NULL
var tozone67 NULL
var tozone67a NULL
var tozone68 NULL
var tozone68a NULL
var tozone68b NULL
var tozone69 NULL
var tozone116 NULL
var tozone123 NULL
var tozone126 NULL
var tozone127 NULL
var tozone240 NULL

#RathaZones:
var tozone90 NULL
var tozone90a NULL
var tozone90d NULL
var tozone92 NULL
var tozone95 NULL

#M'Riss/Mer'KreshZones:
var tozone107 NULL
var tozone107a NULL
var tozone108 NULL

#OtherZones:
var tozone150 NULL
var tozone210 NULL

# CUSTOM SHORTHAND SECTION
eval DestinationZone tolower("%1")
# Note: this list is also in travel.cmd, be sure to make any updates there as well.
if contains("fest|festival", "%DestinationZone") then var DestinationZone 210
if contains("crossing|xing", "%DestinationZone") then var DestinationZone 1
if contains("temple", "%DestinationZone") then var DestinationZone 2a
if contains("tiger clan", "%DestinationZone") then var DestinationZone 4a
if contains("north gate", "%DestinationZone") then var DestinationZone 6
if contains("ntr", "%DestinationZone") then var DestinationZone 7
if contains("stoneclan", "%DestinationZone") then var DestinationZone 10
if contains("guardians", "%DestinationZone") then var DestinationZone 11
if contains("abbey", "%DestinationZone") then var DestinationZone 12a
if contains("dirge", "%DestinationZone") then var DestinationZone 13
if contains("faldesu", "%DestinationZone") then var DestinationZone 14c
if contains("riverhaven", "%DestinationZone") then var DestinationZone 30
if contains("rossmans", "%DestinationZone") then var DestinationZone 34
if contains("theren|therenborough", "%DestinationZone") then var DestinationZone 42
if contains("leth deriel", "%DestinationZone") then var DestinationZone 61
if contains("shard", "%DestinationZone") then var DestinationZone 67
if contains("wyverns|wyvernmountains", "%DestinationZone") then var DestinationZone 70
if contains("ratha", "%DestinationZone") then var DestinationZone 90
if contains("mer'kresh|merkresh", "%DestinationZone") then var DestinationZone 107
if contains("m'riss|mriss", "%DestinationZone") then var DestinationZone 108
if contains("hib|hibarnhvidar|hibbles", "%DestinationZone") then var DestinationZone 116
if contains("raven's point|ravens point", "%DestinationZone") then var DestinationZone 123
if contains("boarclan", "%DestinationZone") then var DestinationZone 127
if contains("ainghazal", "%DestinationZone") then var DestinationZone 114
if contains("hibarnhvidar|hibbles", "%DestinationZone") then var DestinationZone 116
if contains("maulers|zombies|head-splitters|stompers", "%DestinationZone") then
{
	var DestinationZone 127
	#var DestinationRoom 613
}
# This is necessary because wyvern mountAINs contain AIN (ghazal). This is a GREAT way to die.
if "%DestinationZone" == "ain" then var DestinationZone 114

# Is the following ever used?
put #tvar DestinationZone %DestinationZone
if "%2" != "" then put #tvar DestinationRoom %2

if "$zoneid" == "%DestinationZone" then goto AlreadyInZone
if "$zoneid" == "150" then
{
	gosub MoveToNewMap 213
	gosub ResetMap
	gosub RunScriptSafe region
	# TODO: Add detection for failed map reset.
	if "$zoneid" == "%DestinationZone" then goto AlreadyInZone
}
if "$zoneid" == "210" then
{
	gosub MoveToNewMap leave
	gosub ResetMap
	gosub RunScriptSafe region
	if "$zoneid" == "%DestinationZone" then goto AlreadyInZone
}
goto zone$zoneid

zone1:
	#Crossing
	var tozone1 NA
	var tozone1j 925
	var tozone1k 926
	var tozone1l 960
	var tozone1m 968
	var tozone1n 993
	var tozone2 172|15
	var tozone2a 466
	var tozone2d 466|188
	var tozone4 172
	var tozone4a 172|87
	var tozone6 173
	var tozone6a 173|172
	var tozone7 171
	var tozone7a 171|350
	var tozone8 170
	var tozone8a 170|70
	var tozone9b 171|397
	var tozone10 171|396
	var tozone11 171|394
	var tozone12a 171|437
	var tozone13 171|147
	var tozone14b 171|253
	var tozone14c 171|197
	var tozone50 172|87|73
	var tozone150 702
	var tozone210 994
	goto BeginNavigating

zone1a:
	#5th Passage - Xing to STR (this really needs more thought & zones added)
	if contains("|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|40|", "|$roomid|") then {
		var tozone1 6
		var tozone1j 6|925
		var tozone1k 6|926
		var tozone1l 6|960
		var tozone1m 6|968
		var tozone1n 6|993
		var tozone2 6|172|15
		var tozone2a 6|466
		var tozone2d 6|466|188
		var tozone4 6|172
		var tozone4a 6|172|87
		var tozone6 6|173
		var tozone6a 6|173|172
		var tozone7 6|171
		var tozone7a 6|171|350
		var tozone8 6|170
		var tozone8a 6|170|70
		var tozone9b 6|171|397
		var tozone10 6|171|396
		var tozone11 6|171|394
		var tozone12a 6|171|437
		var tozone13 6|171|147
		var tozone14b 6|171|253
		var tozone14c 6|171|197
		var tozone50 6|172|87|73
		var tozone150 6|702
		var tozone210 6|994
		var tozone60 23
	}
	if contains("|31|32|34|36|37|38|", "|$roomid|") then {
		var tozone1 33
	}
	if contains("|1|2|3|", "|$roomid|") then {
		var tozone1 5
	}
	if contains("|24|25|26|27|28|", "|$roomid|") then {
		var tozone1 29
	}
	goto BeginNavigating

zone1j:
	#Crossing - Market Plaza
	var tozone1 1
	var tozone1j NA
	var tozone1k 1|926
	var tozone1l 1|960
	var tozone1m 1|968
	var tozone1n 1|993
	var tozone2 1|172|15
	var tozone2a 1|466
	var tozone2d 1|466|188
	var tozone4 1|172
	var tozone4a 1|172|87
	var tozone6 1|173
	var tozone6a 1|173|172
	var tozone7 1|171
	var tozone7a 1|171|350
	var tozone8 1|170
	var tozone8a 1|170|70
	var tozone9b 1|171|397
	var tozone10 1|171|396
	var tozone11 1|171|394
	var tozone12a 1|171|437
	var tozone13 1|171|147
	var tozone14b 1|171|253
	var tozone14c 1|171|197
	var tozone50 1|172|87|73
	var tozone150 1|702
	var tozone210 1|994
	goto BeginNavigating

zone1k:
	#Crossing - Engineering Society
	var tozone1 6
	var tozone1j 6|925
	var tozone1k NA
	var tozone1l 6|960
	var tozone1m 6|968
	var tozone1n 6|993
	var tozone2 6|172|15
	var tozone2a 6|466
	var tozone2d 6|466|188
	var tozone4 6|172
	var tozone4a 6|172|87
	var tozone6 6|173
	var tozone6a 6|173|172
	var tozone7 6|171
	var tozone7a 6|171|350
	var tozone8 6|170
	var tozone8a 6|170|70
	var tozone9b 6|171|397
	var tozone10 6|171|396
	var tozone11 6|171|394
	var tozone12a 6|171|437
	var tozone13 6|171|147
	var tozone14b 6|171|253
	var tozone14c 6|171|197
	var tozone50 6|172|87|73
	var tozone150 6|702
	var tozone210 6|994
	goto BeginNavigating

zone1l:
	#Crossing - Forging Society
	var tozone1 13
	var tozone1j 13|925
	var tozone1k 13|926
	var tozone1l NA
	var tozone1m 13|968
	var tozone1n 13|993
	var tozone2 13|172|15
	var tozone2a 13|466
	var tozone2d 13|466|188
	var tozone4 13|172
	var tozone4a 13|172|87
	var tozone6 13|173
	var tozone6a 13|173|172
	var tozone7 13|171
	var tozone7a 13|171|350
	var tozone8 13|170
	var tozone8a 13|170|70
	var tozone9b 13|171|397
	var tozone10 13|171|396
	var tozone11 13|171|394
	var tozone12a 13|171|437
	var tozone13 13|171|147
	var tozone14b 13|171|253
	var tozone14c 13|171|197
	var tozone50 13|172|87|73
	var tozone150 13|702
	var tozone210 13|994
	goto BeginNavigating

zone1m:
	#Crossing - Outfitting Society
	var tozone1 11
	var tozone1j 11|925
	var tozone1k 11|926
	var tozone1l 11|960
	var tozone1m NA
	var tozone1n 11|993
	var tozone2 11|172|15
	var tozone2a 11|466
	var tozone2d 11|466|188
	var tozone4 11|172
	var tozone4a 11|172|87
	var tozone6 11|173
	var tozone6a 11|173|172
	var tozone7 11|171
	var tozone7a 11|171|350
	var tozone8 11|170
	var tozone8a 11|170|70
	var tozone9b 11|171|397
	var tozone10 11|171|396
	var tozone11 11|171|394
	var tozone12a 11|171|437
	var tozone13 11|171|147
	var tozone14b 11|171|253
	var tozone14c 11|171|197
	var tozone50 11|172|87|73
	var tozone150 11|702
	var tozone210 11|994
	goto BeginNavigating

zone1n:
	#echo NAVIGATING FROM ALCHEMY SOCIETY
	#Crossing - Alchemy Society
	var tozone1 6
	var tozone1j 6|925
	var tozone1k 6|926
	var tozone1l 6|960
	var tozone1m 6|968
	var tozone1n NA
	var tozone2 6|172|15
	var tozone2a 6|466
	var tozone2d 6|466|188
	var tozone4 6|172
	var tozone4a 6|172|87
	var tozone6 6|173
	var tozone6a 6|173|172
	var tozone7 6|171
	var tozone7a 6|171|350
	var tozone8 6|170
	var tozone8a 6|170|70
	var tozone9b 6|171|397
	var tozone10 6|171|396
	var tozone11 6|171|394
	var tozone12a 6|171|437
	var tozone13 6|171|147
	var tozone14b 6|171|253
	var tozone14c 7|171|197
	var tozone50 6|172|87|73
	var tozone150 6|702
	var tozone210 6|994
	goto BeginNavigating

zone2:
	#Lake of Dreams (out West Gate) - Lipods, Water Sprites
	var tozone1 2|14
	var tozone1j 2|14|925
	var tozone1k 2|14|926
	var tozone1l 2|14|960
	var tozone1m 2|14|968
	var tozone1n 2|14|993
	var tozone2 NA
	var tozone2a 2|14|466
	var tozone2d 2|14|466|188
	var tozone4 2
	var tozone4a 2|87
	var tozone6 2|264
	var tozone6a 2|264|172
	var tozone7 2|264|98
	var tozone7a 2|264|98|350
	var tozone8 2|264|98|348
	var tozone8a 2|264|98|348|70
	var tozone9b 2|264|98|397
	var tozone10 2|264|98|396
	var tozone11 2|264|98|394
	var tozone12a 2|264|98|437
	var tozone13 2|264|98|147
	var tozone14b 2|264|98|253
	var tozone14c 2|264|98|197
	var tozone50 2|87|73
	var tozone150 2|14|702
	var tozone210 2|14|994
	goto BeginNavigating

zone2a:
	#Crossing Temple
	var tozone1 3
	var tozone1j 3|925
	var tozone1k 3|926
	var tozone1l 3|960
	var tozone1m 3|968
	var tozone1n 3|993
	var tozone2 3|172|15
	var tozone2a NA
	var tozone2d 188
	var tozone4 3|172
	var tozone4a 3|172|87
	var tozone6 3|173
	var tozone6a 3|173|172
	var tozone7 3|171
	var tozone7a 3|171|350
	var tozone8 3|170
	var tozone8a 3|170|70
	var tozone9b 3|171|397
	var tozone10 3|171|396
	var tozone11 3|171|394
	var tozone12a 3|171|437
	var tozone13 3|171|147
	var tozone14b 3|171|253
	var tozone14c 3|171|197
	var tozone50 3|172|87|73
	var tozone150 3|702
	var tozone210 3|994
	goto BeginNavigating

zone2d:
	#Crossing Escape Tunnels
	var tozone1 62|3
	var tozone1j 62|3|925
	var tozone1k 62|3|926
	var tozone1l 62|3|960
	var tozone1m 62|3|968
	var tozone1n 62|3|993
	var tozone2 62|3|172|15
	var tozone2a 62
	var tozone2d NA
	var tozone4 62|3|172
	var tozone4a 62|3|172|87
	var tozone6 62|3|173
	var tozone6a 62|3|173|172
	var tozone7 62|3|171
	var tozone7a 62|3|171|350
	var tozone8 62|3|170
	var tozone8a 62|3|170|70
	var tozone9b 62|3|171|397
	var tozone10 62|3|171|396
	var tozone11 62|3|171|394
	var tozone12a 62|3|171|437
	var tozone13 62|3|171|147
	var tozone14b 62|3|171|253
	var tozone14c 62|3|171|197
	var tozone50 62|3|172|87|73
	var tozone150 62|3|702
	var tozone210 62|3|994
	goto BeginNavigating

zone4:
	#Crossing West Gate
	var tozone1 14
	var tozone1j 14|925
	var tozone1k 14|926
	var tozone1l 14|960
	var tozone1m 14|968
	var tozone1n 14|993
	var tozone2 15
	var tozone2a 14|466
	var tozone2d 14|466|188
	var tozone4 NA
	var tozone4a 87
	var tozone6 14|173
	var tozone6a 480|172
	var tozone7 14|171
	var tozone7a 14|171|350
	var tozone8 14|171|348
	var tozone8a 14|171|348|70
	var tozone9b 14|171|397
	var tozone10 14|171|396
	var tozone11 14|171|394
	var tozone12a 14|171|437
	var tozone13 14|171|147
	var tozone14b 14|171|253
	var tozone14c 14|171|197
	var tozone50 87|73
	var tozone150 14|702
	var tozone210 14|994
	goto BeginNavigating

zone4a:
	#Tiger Clan (out West Gate)
	var tozone1 15|14
	var tozone1j 15|14|925
	var tozone1k 15|14|926
	var tozone1l 15|14|960
	var tozone1m 15|14|968
	var tozone1n 15|14|993
	var tozone2 15|15
	var tozone2a 15|14|466
	var tozone2d 15|14|466|188
	var tozone4 15
	var tozone4a NA
	var tozone6 15|480
	var tozone6a 15|480|172
	var tozone7 15|480|98
	var tozone7a 15|480|98|350
	var tozone8 15|480|98|348
	var tozone8a 15|480|98|348|70
	var tozone9b 15|480|98|397
	var tozone10 15|480|98|396
	var tozone11 15|480|98|394
	var tozone12a 15|480|98|437
	var tozone13 15|480|98|147
	var tozone14b 15|480|98|253
	var tozone14c 15|480|98|197
	var tozone50 73
	var tozone150 15|14|702
	var tozone210 15|14|994
	goto BeginNavigating

zone6:
	#Crossing North Gate
	var tozone1 23
	var tozone1j 23|925
	var tozone1k 23|926
	var tozone1l 23|960
	var tozone1m 23|968
	var tozone1n 23|993
	var tozone2 113|15
	var tozone2a 23|466
	var tozone2d 23|466|188
	var tozone4 113
	var tozone4a 113|87
	var tozone6 NA
	var tozone6a 172
	var tozone7 98
	var tozone7a 98|350
	var tozone8 98|348
	var tozone8a 98|348|70
	var tozone9b 98|397
	var tozone10 98|396
	var tozone11 98|394
	var tozone12a 98|437
	var tozone13 98|147
	var tozone14b 98|253
	var tozone14c 98|197
	var tozone50 113|87|73
	var tozone150 23|702
	var tozone210 23|994
	goto BeginNavigating

zone6a:
	#Crossing Necromancer Guild
	var tozone1 1|23
	var tozone1j 1|23|925
	var tozone1k 1|23|926
	var tozone1l 1|23|960
	var tozone1m 1|23|968
	var tozone1n 1|23|993
	var tozone2 1|113|15
	var tozone2a 1|23|466
	var tozone2d 1|23|466|188
	var tozone4 1|113
	var tozone4a 1|113|87
	var tozone6 1
	var tozone6a NA
	var tozone7 1|98
	var tozone7a 1|98|350
	var tozone8 1|98|348
	var tozone8a 1|98|348|70
	var tozone9b 1|98|397
	var tozone10 1|98|396
	var tozone11 1|98|394
	var tozone12a 1|98|437
	var tozone13 1|98|147
	var tozone14b 1|98|253
	var tozone14c 1|98|197
	var tozone50 1|113|87|73
	var tozone150 1|23|702
	var tozone210 1|23|994
	goto BeginNavigating

zone7:
	#Crossing NTR
	var tozone1 NA
	var tozone1 349
	var tozone1j 349|925
	var tozone1k 349|926
	var tozone1l 349|960
	var tozone1m 349|968
	var tozone1n 349|993
	var tozone2 349|172|15
	var tozone2a 349|466
	var tozone2d 349|466|188
	var tozone4 349|172
	var tozone4a 349|172|87
	var tozone6 347
	var tozone6a 347|172
	var tozone7 NA
	var tozone7a 350
	var tozone8 348
	var tozone8a 348|70
	var tozone9b 397
	var tozone10 396
	var tozone11 394
	var tozone12a 437
	var tozone13 147
	var tozone14b 253
	var tozone14c 197
	var tozone50 349|172|87|73
	var tozone150 349|702
	var tozone210 349|994
	goto BeginNavigating

zone7a:
	#NTR Vineyard
	var tozone1 15|349
	var tozone1j 15|349|925
	var tozone1k 15|349|926
	var tozone1l 15|349|960
	var tozone1m 15|349|968
	var tozone1n 15|349|993
	var tozone2 15|349|172|15
	var tozone2a 15|349|466
	var tozone2d 15|349|466|188
	var tozone4 15|349|172
	var tozone4a 15|349|172|87
	var tozone6 15|347
	var tozone6a 15|347|172
	var tozone7 15
	var tozone7a NA
	var tozone8 15|348
	var tozone8a 15|348|70
	var tozone9b 397
	var tozone10 15|396
	var tozone11 15|394
	var tozone12a 15|437
	var tozone13 15|147
	var tozone14b 15|253
	var tozone14c 15|197
	var tozone50 15|349|172|87|73
	var tozone150 15|349|702
	var tozone210 15|349|994
	goto BeginNavigating

zone8:
	#Crossing East Gate
	var tozone1 43
	var tozone1j 43|925
	var tozone1k 43|926
	var tozone1l 43|960
	var tozone1m 43|968
	var tozone1n 43|993
	var tozone2 53|347|113|15
	var tozone2a 43|466
	var tozone2d 43|466|188
	var tozone4 53|347|113
	var tozone4a 53|347|113|87
	var tozone6 53|347
	var tozone6a 53|347|172
	var tozone7 53
	var tozone7a 53|350
	var tozone8 NA
	var tozone8a 70
	var tozone9b 53|397
	var tozone10 53|396
	var tozone11 53||394
	var tozone12a 53|437
	var tozone13 53|147
	var tozone14b 53|253
	var tozone14c 53|197
	var tozone50 53|347|113|87|73
	var tozone150 43|702
	var tozone210 43|994
	goto BeginNavigating

zone8a:
	#Lost Crossing (out East Gate)
	var tozone1 15|43
	var tozone1j 15|43|925
	var tozone1k 15|43|926
	var tozone1l 15|43|960
	var tozone1m 15|43|968
	var tozone1n 15|43|993
	var tozone2 15|53|347|113|15
	var tozone2a 15|43|466
	var tozone2d 15|43|466|188
	var tozone4 15|53|347|113
	var tozone4a 15|53|347|113|87
	var tozone6 15|53|347
	var tozone6a 15|53|347|172
	var tozone7 15|53
	var tozone7a 15|53|350
	var tozone8 15
	var tozone8a NA
	var tozone9b 15|53|397
	var tozone10 15|53|396
	var tozone11 15|53||394
	var tozone12a 15|53|437
	var tozone13 15|53|147
	var tozone14b 15|53|253
	var tozone14c 15|53|197
	var tozone50 15|53|347|113|87|73
	var tozone150 15|43|702
	var tozone210 15|43|994
	goto BeginNavigating

zone9b:
	#Sorrow's Reach (Scouts, vipers, buccas)
	var tozone1 9|349
	var tozone1j 9|349|925
	var tozone1k 9|349|926
	var tozone1l 9|349|960
	var tozone1m 9|349|968
	var tozone1n 9|349|993
	var tozone2 9|349|172|15
	var tozone2a 9|349|466
	var tozone2d 9|349|466|188
	var tozone4 9|349|172
	var tozone4a 9|349|172|87
	var tozone6 9|347
	var tozone6a 9|347|172
	var tozone7 9
	var tozone7a 9|350
	var tozone8 9|348
	var tozone8a 9|348|70
	var tozone9b NA
	var tozone10 9|396
	var tozone11 9|394
	var tozone12a 9|437
	var tozone13 9|147
	var tozone14b 9|253
	var tozone14c 9|197
	var tozone50 9|349|172|87|73
	var tozone150 9|349|702
	var tozone210 9|349|994
	goto BeginNavigating

zone10:
	#NTR Abandoned Mine & Lairocott Brach
	var tozone1 21|349
	var tozone1j 21|349|925
	var tozone1k 21|349|926
	var tozone1l 21|349|960
	var tozone1m 21|349|968
	var tozone1n 21|349|993
	var tozone2 21|349|172|15
	var tozone2a 21|349|466
	var tozone2d 21|349|466|188
	var tozone4 21|349|172
	var tozone4a 21|349|172|87
	var tozone6 21|347
	var tozone6a 21|347|172
	var tozone7 21
	var tozone7a 21|350
	var tozone8 21|348
	var tozone8a 21|348|70
	var tozone9b 21|397
	var tozone10 NA
	var tozone11 21|394
	var tozone12a 21|437
	var tozone13 21|147
	var tozone14b 21|253
	var tozone14c 21|197
	var tozone50 21|349|172|87|73
	var tozone150 21|349|702
	var tozone210 21|349|994
	goto BeginNavigating

zone11:
	#NTR Leucros, Vipers, & Rock Guardians
	var tozone1 2|349
	var tozone1j 2|349|925
	var tozone1k 2|349|926
	var tozone1l 2|349|960
	var tozone1m 2|349|968
	var tozone1n 2|349|993
	var tozone2 2|349|172|15
	var tozone2a 2|349|466
	var tozone2d 2|349|466|188
	var tozone4 2|349|172
	var tozone4a 2|349|172|87
	var tozone6 2|347
	var tozone6a 2|347|172
	var tozone7 2
	var tozone7a 2|350
	var tozone8 2|348
	var tozone8a 2|348|70
	var tozone9b 2|397
	var tozone10 2|396
	var tozone11 NA
	var tozone12a 2|437
	var tozone13 2|147
	var tozone14b 2|253
	var tozone14c 2|197
	var tozone50 2|349|172|87|73
	var tozone150 2|349|702
	var tozone210 2|349|994
	goto BeginNavigating

zone12a:
	# NTR Misenor Abbey
	var tozone1 60|349
	var tozone1j 60|349|925
	var tozone1k 60|349|926
	var tozone1l 60|349|960
	var tozone1m 60|349|968
	var tozone1n 60|349|993
	var tozone2 60|349|172|15
	var tozone2a 60|349|466
	var tozone2d 60|349|466|188
	var tozone4 60|349|172
	var tozone4a 60|349|172|87
	var tozone6 60|347
	var tozone6a 60|347|172
	var tozone7 60
	var tozone7a 60|350
	var tozone8 60|348
	var tozone8a 60|348|70
	var tozone9b 60|397
	var tozone10 60|396
	var tozone11 60|394
	var tozone12a NA
	var tozone13 60|147
	var tozone14b 60|253
	var tozone14c 60|197
	var tozone50 60|349|172|87|73
	var tozone150 60|349|702
	var tozone210 60|349|994
	goto BeginNavigating

zone13:
	#Dirge
	var tozone1 71|349
	var tozone1j 71|349|925
	var tozone1k 71|349|926
	var tozone1l 71|349|960
	var tozone1m 71|349|968
	var tozone1n 71|349|993
	var tozone2 71|349|172|15
	var tozone2a 71|349|466
	var tozone2d 71|349|466|188
	var tozone4 71|349|172
	var tozone4a 71|349|172|87
	var tozone6 71|347
	var tozone6a 71|347|172
	var tozone7 71
	var tozone7a 71|350
	var tozone8 71|348
	var tozone8a 71|348|70
	var tozone9b 71|397
	var tozone10 71|396
	var tozone11 71|394
	var tozone12a 71|437
	var tozone13 NA
	var tozone14b 71|253
	var tozone14c 71|197
	var tozone50 71|349|172|87|73
	var tozone150 71|349|702
	var tozone210 71|349|994
	goto BeginNavigating

zone14b:
	#NTR Greater Fist Volcano
	var tozone1 217|349
	var tozone1j 217|349|925
	var tozone1k 217|349|926
	var tozone1l 217|349|960
	var tozone1m 217|349|968
	var tozone1n 217|349|993
	var tozone2 217|349|172|15
	var tozone2a 217|349|466
	var tozone2d 217|349|466|188
	var tozone4 217|349|172
	var tozone4a 217|349|172|87
	var tozone6 217|347
	var tozone6a 217|347|172
	var tozone7 217
	var tozone7a 217|350
	var tozone8 217|348
	var tozone8a 217|348|70
	var tozone9b 217|397
	var tozone10 217|396
	var tozone11 217|394
	var tozone12a 217|437
	var tozone13 217|147
	var tozone14b NA
	var tozone14c 217|197
	var tozone50 217|349|172|87|73
	var tozone150 217|349|702
	var tozone210 217|349|994
	goto BeginNavigating

zone14c:
	#TODO: Code Special river section...
	if $roomid == 11 then gosub Move southwest
	if $roomid == 2 then
	{
		gosub Move climb stone bridge
		goto zone7
	}
	gosub Move Southeast
	goto zone14c

zone50:
	#Selgoltha River
	var tozone1 36|15|14
	var tozone1j 36|15|14|925
	var tozone1k 36|15|14|926
	var tozone1l 36|15|14|960
	var tozone1m 36|15|14|968
	var tozone1n 36|15|14|993
	var tozone2 36|15|15
	var tozone2a 36|15|14|466
	var tozone2d 36|15|14|466|188
	var tozone4 36|15
	var tozone4a 36
	var tozone6 36|15|480
	var tozone6a 36|15|480|172
	var tozone7 36|15|480|98
	var tozone7a 36|15|480|98|350
	var tozone8 36|15|480|98|348
	var tozone8a 36|15|480|98|348|70
	var tozone9b 36|15|480|98|397
	var tozone10 36|15|480|98|396
	var tozone11 36|15|480|98|394
	var tozone12a 36|15|480|98|437
	var tozone13 36|15|480|98|147
	var tozone14b 36|15|480|98|253
	var tozone14c 36|15|480|98|197
	var tozone50 NA
	var tozone150 36|15|14|702
	var tozone210 36|15|14|994
	goto BeginNavigating

# ----------------------- END OF ZOLUREN SECTION --------------------------

zone30:
	# Riverhaven
	var tozone30 NULL
	var tozone30a 384
	var tozone30b 396
	var tozone30c 462
	var tozone31 203
	var tozone31a 203|100
	var tozone31b 203|100|123
	var tozone32 204
	var tozone33 174
	var tozone33a 174|29
	var tozone34 174|29|48
	var tozone34a 174|29|48|22
	var tozone150 445
	goto BeginNavigating

	zone30a:
	# Dunshade Manor
	var tozone30 57
	var tozone30a NULL
	var tozone30b 57|396
	var tozone30c 57|462
	var tozone31 57|203
	var tozone31a 57|203|100
	var tozone31b 57|203|100|123
	var tozone32 57|204
	var tozone33 57|174
	var tozone33a 57|174|29
	var tozone34 57|174|29|48
	var tozone34a 57|174|29|48|22
	var tozone150 57|445
	goto BeginNavigating

	zone30b:
	# Haven Thief Passages
	var tozone30 14
	var tozone30a 14|384
	var tozone30b NULL
	var tozone30c 14|462
	var tozone31 14|203
	var tozone31a 14|203|100
	var tozone31b 14|203|100|123
	var tozone32 14|204
	var tozone33 14|174
	var tozone33a 14|174|29
	var tozone34 14|174|29|48
	var tozone34a 14|174|29|48|22
	var tozone150 14|445
	goto BeginNavigating

	zone30c:
	# Haven Necromancer Guild
	var tozone30 19
	var tozone30a 19|384
	var tozone30b 19|396
	var tozone30c NULL
	var tozone31 19|203
	var tozone31a 19|203|100
	var tozone31b 19|203|100|123
	var tozone32 19|204
	var tozone33 19|174
	var tozone33a 19|174|29
	var tozone34 19|174|29|48
	var tozone34a 19|174|29|48|22
	var tozone150 19|445
	goto BeginNavigating

	zone31:
	# Riverhaven East Gate
	var tozone30 1
	var tozone30a 1|384
	var tozone30b 1|396
	var tozone30c 1|462
	var tozone31 NULL
	var tozone31a 100
	var tozone31b 100|123
	var tozone32 1|204
	var tozone33 1|174
	var tozone33a 1|174|29
	var tozone34 1|174|29|48
	var tozone34a 1|174|29|48|22
	var tozone150 1|445
	goto BeginNavigating

	zone31a:
	# Zaulfung
	var tozone30 122|1
	var tozone30a 122|1|384
	var tozone30b 122|1|396
	var tozone30c 122|1|462
	var tozone31 122
	var tozone31a NULL
	var tozone31b 123
	var tozone32 122|1|204
	var tozone33 122|1|174
	var tozone33a 122|1|174|29
	var tozone34 122|1|174|29|48
	var tozone34a 122|1|174|29|48|22
	var tozone150 122|1|445
	goto BeginNavigating

	zone31b:
	# Maelshyve's Fortress
	var tozone30 5|122|1
	var tozone30a 5|122|1|384
	var tozone30b 5|122|1|396
	var tozone30c 5|122|1|462
	var tozone31 5|122
	var tozone31a 5
	var tozone31b NULL
	var tozone32 5|122|1|204
	var tozone33 5|122|1|174
	var tozone33a 5|122|1|174|29
	var tozone34 5|122|1|174|29|48
	var tozone34a 5|122|1|174|29|48|22
	var tozone150 5|122|1|445
	goto BeginNavigating

	zone32:
	# Riverhaven North Gate
	var tozone30 1
	var tozone30a 1|384
	var tozone30b 1|396
	var tozone30c 1|462
	var tozone31 1|203
	var tozone31a 1|203|100
	var tozone31b 1|203|100|123
	var tozone32 NULL
	var tozone33 1|174
	var tozone33a 1|174|29
	var tozone34 1|174|29|48
	var tozone34a 1|174|29|48|22
	var tozone150 1|445
	goto BeginNavigating

	zone33:
	# Riverhaven West Gate
	var tozone30 1
	var tozone30a 1|384
	var tozone30b 1|396
	var tozone30c 1|462
	var tozone31 1|203
	var tozone31a 1|203|100
	var tozone31b 1|203|100|123
	var tozone32 1|204
	var tozone33 NULL
	var tozone33a 29
	var tozone34 29|48
	var tozone34a 29|48|22
	var tozone150 1|445
	goto BeginNavigating

	zone33a:
	# Road to Therenbourough
	var tozone30 46|1
	var tozone30a 46|1|384
	var tozone30b 46|1|396
	var tozone30c 46|1|462
	var tozone31 46|1|203
	var tozone31a 46|1|203|100
	var tozone31b 46|1|203|100|123
	var tozone32 46|1|204
	var tozone33 46
	var tozone33a NULL
	var tozone34 48
	var tozone34a 48|22
	var tozone150 46|1|445
	goto BeginNavigating

	zone34:
	# Mistwood Forest
	# Note: zone34 connections to Theren have not been thoroughly tested.
	var tozone30 15|46|1
	var tozone30a 15|46|1|384
	var tozone30b 15|46|1|396
	var tozone30c 15|46|1|462
	var tozone31 15|46|1|203
	var tozone31a 15|46|1|203|100
	var tozone31b 15|46|1|203|100|123
	var tozone32 15|46|1|204
	var tozone33 15|46
	var tozone33a 15
	var tozone34 NULL
	var tozone34a 22
	var tozone40 137
	var tozone40a 137|263
	var tozone41 137|376
	var tozone42 137|211
	var tozone48 137|376|208
	var tozone150 137|378
	var tozone230 137|316
	#var tozone150 15|46|1|445 <- todo: determine which side of the rope bridge I'm on before traveling
	goto BeginNavigating

	zone34a:
	# Rossman's Landing
	var tozone30 134|15|46|1
	var tozone30a 134|15|46|1|384
	var tozone30b 134|15|46|1|396
	var tozone30c 134|15|46|1|462
	var tozone31 134|15|46|1|203
	var tozone31a 134|15|46|1|203|100
	var tozone31b 134|15|46|1|203|100|123
	var tozone32 134|15|46|1|204
	var tozone33 134|15|46
	var tozone33a 134|15
	var tozone34 134
	var tozone34a NULL
	var tozone40 134|137
	var tozone40a 134|137|263
	var tozone41 134|137|376
	var tozone42 134|137|211
	var tozone48 134|137|376|208
	var tozone230 134|137|316
	var tozone150 134|15|46|1|445
	goto BeginNavigating

# ----------------------- END OF RIVERHAVEN SECTION --------------------------
# ----------------------- START OF THEREN SECTION --------------------------

zone40:
	var tozone40 NULL
	var tozone40a 263
	var tozone41 376
	var tozone42 211
	var tozone48 376|208
	var tozone150 378
	var tozone230 316
	goto BeginNavigating

zone40a:
	var tozone40 125
	var tozone40a NULL
	var tozone41 125|376
	var tozone42 125|211
	var tozone48 125|376|208
	var tozone150 125|378
	var tozone230 125|316
	goto BeginNavigating

zone41:
	var tozone40 53
	var tozone40a 53|263
	var tozone41 NULL
	var tozone42 53|211
	var tozone48 208
	var tozone150 53|378
	var tozone230 53|316
	goto BeginNavigating

zone42:
	var tozone40 2
	var tozone40a 2|263
	var tozone41 2|376
	var tozone42 NULL
	var tozone48 2|376|208
	var tozone150 2|378
	var tozone230 2|316
	goto BeginNavigating

zone48:
	var tozone40 92|53
	var tozone40a 92|53|263
	var tozone41 92
	var tozone42 92|53|211
	var tozone48 NULL
	var tozone150 92|53|378
	var tozone230 92|53|316
	goto BeginNavigating

zone230:
	var tozone40 101
	var tozone40a 101|263
	var tozone41 101|376
	var tozone42 101|211
	var tozone48 101|376|208
	var tozone150 101|378
	var tozone230 NULL
	goto BeginNavigating

# ----------------------- END OF THEREN SECTION --------------------------

# -------------------- START OF MUSPAR'I SECTION -------------------------

zone47:
	var tozone150 483
	goto BeginNavigating

# ---------------------- END OF MUSPAR'I SECTION -------------------------

# ----------------------- START OF LETH SECTION --------------------------

zone58:
	# Acenmacra Village
	var tozone58 NULL
	var tozone59 2|182
	var tozone60 2|115
	var tozone61 2
	var tozone62 2|130
	var tozone63 2|130|102
	var tozone112 2|126
	var tozone150 2|236
	goto BeginNavigating

zone59:
	# Moss Meys (Boggy Wood) by Leth
	var tozone58 12|178
	var tozone59 NULL
	var tozone60 12|115
	var tozone61 12
	var tozone62 12|130
	var tozone63 12|130|102
	var tozone112 12|126
	var tozone150 12|236
	goto BeginNavigating

zone60:
	# North of Leth
	var tozone58 57|178
	var tozone59 57|182
	var tozone60 NULL
	var tozone61 57
	var tozone62 57|130
	var tozone63 57|130|102
	var tozone112 57|126
	var tozone150 57|236
	goto BeginNavigating

zone61:
	# Leth Deriel
	var tozone58 178
	var tozone59 182
	var tozone60 115
	var tozone61 NULL
	var tozone62 130
	var tozone63 130|102
	var tozone112 126
	var tozone150 236
	goto BeginNavigating

zone62:
	# STR / South of Leth
	var tozone58 101|178
	var tozone59 101|182
	var tozone60 101|115
	var tozone61 101
	var tozone62 NULL
	var tozone63 102
	var tozone112 101|126
	var tozone150 101|236
	goto BeginNavigating

zone63:
	# Oshu'ehhrsk Manor
	var tozone58 112|101|178
	var tozone59 112|101|182
	var tozone60 112|101|115
	var tozone61 112|101
	var tozone62 112
	var tozone63 NULL
	var tozone112 112|101|126
	var tozone150 112|101|236
	goto BeginNavigating

zone112:
	# Ilaya Taipa (River Clan)
	var tozone58 112|178
	var tozone59 112|182
	var tozone60 112|115
	var tozone61 112
	var tozone62 112|130
	var tozone63 112|130|102
	var tozone112 NULL
	var tozone150 112|236
	goto BeginNavigating

# ----------------------- END OF LETH SECTION --------------------------
# ----------------------- START OF SHARD SECTION --------------------------

zone65:
	# Undergondola Path North
	var tozone65 NULL
	var tozone66 1
	var tozone67 1|216
	var tozone67a 1|216|595
	var tozone68 1|216|230
	var tozone68a 1|216|230|214
	var tozone68b 1|216|230|207
	var tozone69 1|217
	var tozone70 1|217|452
	var tozone71 1|217|452|95
	var tozone116 1|217|283|169
	var tozone123 1|217|283
	var tozone126 1|217|283|169|217
	var tozone127 1|217|283|169|217|103
	var tozone128 1|217|283|169|217|103|635
	var tozone150 1|618
	var tozone240 1|658
	goto BeginNavigating

zone66:
	# North of Shard / South of Gondola
	var tozone65 317
	var tozone66 NULL
	var tozone67 216
	var tozone67a 216|595
	var tozone68 216|230
	var tozone68a 216|230|214
	var tozone68b 216|230|207
	var tozone69 217
	var tozone70 217|452
	var tozone71 217|452|95
	var tozone116 217|283|169
	var tozone123 217|283
	var tozone126 217|283|169|217
	var tozone127 217|283|169|217|103
	var tozone128 217|283|169|217|103|635
	var tozone150 618
	var tozone240 658
	goto BeginNavigating

zone67:
	# Shard Proper
	var tozone65 132|317
	var tozone66 132
	var tozone67 NULL
	var tozone67a 595
	var tozone68 230
	var tozone68a 230|214
	var tozone68b 230|207
	var tozone69 129
	var tozone70 129|452
	var tozone71 129|452|95
	var tozone116 129|283|169
	var tozone123 129|283
	var tozone126 129|283|169|217
	var tozone127 129|283|169|217|103
	var tozone128 129|283|169|217|103|635
	var tozone150 132|618
	var tozone240 132|658
	goto BeginNavigating

zone67a:
	# Thief Passages
	# Note: Currently impossible to navigate TO rooms 18, 20, 21, 22 due to unconnected passage
	if contains("18|20|21|22","$roomid") then var firstDestination 23
	else var firstDestionation 8
	var tozone65 %firstDestionation|132|317
	var tozone66 %firstDestionation|132
	var tozone67 %firstDestionation
	var tozone67a NULL
	var tozone68 %firstDestionation|230
	var tozone68a %firstDestionation|230|214
	var tozone68b %firstDestionation|230|207
	var tozone69 %firstDestionation|129
	var tozone70 %firstDestionation|129|452
	var tozone71 %firstDestionation|129|452|95
	var tozone116 %firstDestionation|129|283|169
	var tozone123 %firstDestionation|129|283
	var tozone126 %firstDestionation|129|283|169|217
	var tozone127 %firstDestionation|129|283|169|217|103
	#var tozone128 %firstDestionation|129|283|169|217|103|635 Not possible to navigate from thief passage to necro guild...
	var tozone150 %firstDestionation|132|618
	var tozone240 %firstDestionation|132|658
	goto BeginNavigating

zone68:
	# South of Shard
	var tozone65 225|132|317
	var tozone66 225|132
	var tozone67 225
	var tozone67a 225|162
	var tozone68 NULL
	var tozone68a 214
	var tozone68b 207
	var tozone69 225|129
	var tozone70 225|129|452
	var tozone71 225|129|452|95
	var tozone116 225|129|283|169
	var tozone123 225|129|283
	var tozone126 225|129|283|169|217
	var tozone127 225|129|283|169|217|103
	var tozone128 225|129|283|169|217|103|635
	var tozone150 225|132|618
	var tozone240 225|132|658
	goto BeginNavigating

zone68a:
	# Ice Caves South of Shard
	# Try to avoid crossing the stupid bridge at all costs.
	var FirstRoom 30
	if contains("|1|2|3|4|5|6|", "|$roomid|") then var FirstRoom 29
	var tozone65 %FirstRoom|225|132|317
	var tozone66 %FirstRoom|225|132
	var tozone67 %FirstRoom|225
	var tozone67a %FirstRoom|225|162
	var tozone68 %FirstRoom
	var tozone68a NULL
	var tozone68b %FirstRoom|207
	var tozone69 %FirstRoom|225|129
	var tozone70 %FirstRoom|225|129|452
	var tozone71 %FirstRoom|225|129|452|95
	var tozone116 %FirstRoom|225|129|283|169
	var tozone123 %FirstRoom|225|129|283
	var tozone126 %FirstRoom|225|129|283|169|217
	var tozone127 %FirstRoom|225|129|283|169|217|103
	var tozone128 %FirstRoom|225|129|283|169|217|103|635
	var tozone150 %FirstRoom|225|132|618
	var tozone240 %FirstRoom|225|132|658
	goto BeginNavigating

zone68b:
	# Corik's Wall / DMZ
	var tozone65 44|225|132|317
	var tozone66 44|225|132
	var tozone67 44|225
	var tozone67a 44|225|162
	var tozone68 44
	var tozone68a 44|214
	var tozone68b NULL
	var tozone69 44|225|129
	var tozone70 44|225|129|452
	var tozone71 44|225|129|452|95
	var tozone116 44|225|129|283|169
	var tozone123 44|225|129|283
	var tozone126 44|225|129|283|169|217
	var tozone127 44|225|129|283|169|217|103
	var tozone128 44|225|129|283|169|217|103|635
	var tozone150 44|225|132|618
	var tozone240 44|225|132|658
	goto BeginNavigating

zone69:
	# West of Shard
	var tozone65 1|317
	var tozone66 1
	var tozone67 31
	var tozone67a 31|595
	var tozone68 31|230
	var tozone68a 31|230|214
	var tozone68b 31|230|207
	var tozone69 NULL
	var tozone70 452
	var tozone71 452|95
	var tozone116 283|169
	var tozone123 283
	var tozone126 283|169|217
	var tozone127 283|169|217|103
	var tozone128 283|169|217|103|635
	var tozone150 1|618
	var tozone240 1|658
	goto BeginNavigating

zone70:
	# Wyvern Mountains, West of Shard
	var tozone65 3|1|317
	var tozone66 3|1
	var tozone67 3|31
	var tozone67a 3|31|595
	var tozone68 3|31|230
	var tozone68a 3|31|230|214
	var tozone68b 3|31|230|207
	var tozone69 3
	var tozone70 NULL
	var tozone71 95
	var tozone116 3|283|169
	var tozone123 3|283
	var tozone126 3|283|169|217
	var tozone127 3|283|169|217|103
	var tozone128 3|283|169|217|103|635
	var tozone150 3|1|618
	var tozone240 3|1|658
	goto BeginNavigating

zone71:
	# Shard Necromancer Guild
	var tozone65 9|3|1|317
	var tozone66 9|3|1
	var tozone67 9|3|31
	var tozone67a 9|3|31|595
	var tozone68 9|3|31|230
	var tozone68a 9|3|31|230|214
	var tozone68b 9|3|31|230|207
	var tozone69 9|3
	var tozone70 9
	var tozone71 NULL
	var tozone116 9|3|283|169
	var tozone123 9|3|283
	var tozone126 9|3|283|169|217
	var tozone127 9|3|283|169|217|103
	var tozone128 9|3|283|169|217|103|635
	var tozone150 9|3|1|618
	var tozone240 9|3|1|658
	goto BeginNavigating

zone113:
	# Ferry Zone between Shard/Leth/Ain Ghazal
	if contains("|4|11|", "$roomid") then
	{
		var tozone114 10
		var tozone150 10|176
	}
	if "$roomid" == "8" then
	{
		var tozone114 9
		var tozone150 9|176
	}
	if "$roomid" == "1" then
	{
		var tozone112 5
	}
	if "$roomid" == "6" then
	{
		var tozone123 7
	}
	goto BeginNavigating

zone114:
	# Ain Ghazal
	var tozone113 1
	var tozone150 176
	goto BeginNavigating

zone116:
	# Hibarnhvidar
	var tozone65 3|175|1|317
	var tozone66 3|175|1
	var tozone67 3|175|31
	var tozone67a 3|175|31|595
	var tozone68 3|175|31|230
	var tozone68a 3|175|31|230|214
	var tozone68b 3|175|31|230|207
	var tozone69 3|175
	var tozone70 3|175|452
	var tozone71 3|175|452|95
	var tozone116 NULL
	var tozone123 3
	var tozone126 217
	var tozone127 217|103
	var tozone128 217|103|635
	var tozone150 425
	var tozone240 3|175|1|658
	goto BeginNavigating

zone123:
	# Raven's Point
	var tozone65 175|1|317
	var tozone66 175|1
	var tozone67 175|31
	var tozone67a 175|31|595
	var tozone68 175|31|230
	var tozone68a 175|31|230|214
	var tozone68b 175|31|230|207
	var tozone69 175
	var tozone70 175|452
	var tozone71 175|452|95
	var tozone116 169
	var tozone123 NULL
	var tozone126 169|217
	var tozone127 169|217|103
	var tozone128 169|217|103|635
	var tozone150 169|425
	var tozone240 175|1|658
	goto BeginNavigating

zone126:
	# Hawkstaal Road (Between Hib and Boar Clan)
	var tozone65 49|3|175|1|317
	var tozone66 49|3|175|1
	var tozone67 49|3|175|31
	var tozone67a 49|3|175|31|595
	var tozone68 49|3|175|31|230
	var tozone68a 49|3|175|31|230|214
	var tozone68b 49|3|175|31|230|207
	var tozone69 49|3|175
	var tozone70 49|3|175|452
	var tozone71 49|3|175|452|95
	var tozone116 49
	var tozone123 49|3
	var tozone126 NULL
	var tozone127 103
	var tozone128 103|635
	var tozone150 49|425
	var tozone240 49|3|175|1|658
	goto BeginNavigating

zone127:
	# Boar Clan & Asketi's Mount
	var tozone65 510|49|3|175|1|317
	var tozone66 510|49|3|175|1
	var tozone67 510|49|3|175|31
	var tozone67a 510|49|3|175|31|595
	var tozone68 510|49|3|175|31|230
	var tozone68a 510|49|3|175|31|230|214
	var tozone68b 510|49|3|175|31|230|207
	var tozone69 510|49|3|175
	var tozone70 510|49|3|175|452
	var tozone71 510|49|3|175|452|95
	var tozone116 510|49
	var tozone123 510|49|3
	var tozone126 510
	var tozone127 NULL
	var tozone128 635
	var tozone150 510|49|425
	var tozone240 510|49|3|175|1|658
	goto BeginNavigating

zone128:
	# P5 Necromancer Guild
	var tozone65 4|510|49|3|175|1|317
	var tozone66 4|510|49|3|175|1
	var tozone67 4|510|49|3|175|31
	var tozone67a 4|510|49|3|175|31|595
	var tozone68 4|510|49|3|175|31|230
	var tozone68a 4|510|49|3|175|31|230|214
	var tozone68b 4|510|49|3|175|31|230|207
	var tozone69 4|510|49|3|175
	var tozone70 4|510|49|3|175|452
	var tozone71 4|510|49|3|175|452|95
	var tozone116 4|510|49
	var tozone123 4|510|49|3
	var tozone126 4|510
	var tozone127 4
	var tozone128 null
	var tozone150 4|510|49|425
	var tozone240 4|510|49|3|175|1|658
	goto BeginNavigating

zone240:
# Duskruin
	var tozone65 28|317
	var tozone66 28
	var tozone67 28|216
	var tozone67a 28|216|595
	var tozone68 28|216|230
	var tozone68a 28|216|230|214
	var tozone68b 28|216|230|207
	var tozone69 28|217
	var tozone70 28|217|452
	var tozone71 28|217|452|95
	var tozone116 28|217|283|169
	var tozone123 28|217|283
	var tozone126 28|217|283|169|217
	var tozone127 28|217|283|169|217|103
	var tozone128 28|217|283|169|217|103|635
	var tozone150 28|618
	var tozone240 NULL
	goto BeginNavigating


# ----------------------- END OF SHARD SECTION --------------------------

zone90:
	# Ratha
	var tozone90 NULL
	var tozone90a 228
	var tozone90d 628
	var tozone92 663
	var tozone95 662
	var tozone150 841
	goto BeginNavigating

zone90a:
	# Sand Sprites
	var tozone90 1
	var tozone90a NULL
	var tozone90d 1|628
	var tozone92 1|663
	var tozone95 1|662
	var tozone150 1|841
	goto BeginNavigating

zone90d:
	# Taisgath
	var tozone90 63
	var tozone90a 63|228
	var tozone90d NULL
	var tozone92 63|663
	var tozone95 63|662
	var tozone150 63|841
	goto BeginNavigating

zone92:
	# NW of Ratha
	var tozone90 1
	var tozone90a 1|228
	var tozone90d 1|628
	var tozone92 NULL
	var tozone95 1|662
	var tozone150 1|841
	goto BeginNavigating

zone95:
	# NE of Ratha
	var tozone90 1
	var tozone90a 1|228
	var tozone90d 1|628
	var tozone92 1|663
	var tozone95 NULL
	var tozone150 1|841
	goto BeginNavigating

# ----------------------- END OF RATHA SECTION --------------------------

zone98:
	# Road to Aesry
	var tozone98 NULL
	var tozone98a 36
	var tozone99 86
	var tozone150 86|392
	goto BeginNavigating

zone98a:
	# Aesry Sea Caves
	var tozone98 97
	var tozone98a NULL
	var tozone99 97|86
	var tozone150 97|86|392
	goto BeginNavigating

zone99:
	# Aesry Proper
	var tozone98 390
	var tozone98a 390|35
	var tozone99 NULL
	var tozone150 392
	goto BeginNavigating

zone106:
	# Hara'jaal
	var tozone150 99
	goto BeginNavigating

zone107:
	# Mer'Kresh
	var tozone150 315
	echo * Nothing besides Fang Cove linked from this zone. *
	echo * Use .travel to reach M'riss or other destinations, sorry.
	goto BeginNavigating

zone108:
	# M'Riss
	var tozone150 378
	goto BeginNavigating

zone300:
	echo .n.cmd should not be started in the ways, something fucked up
	put #script abort all except %scriptname
	put exit
	pause
	exit

# --------------------------------------------------------------------------

BeginNavigating:
	var navigation.path %tozone%DestinationZone
	if "%navigation.path" == "NULL" then {
		echo *** NO DEFINED ROUTE FROM $zoneid to %DestinationZone ***
		put #flash
		put #beep
		#if $charactername == "Rellie" then put stop play
		exit
	}
	#dest.counter is a counter for the array
	var dest.counter 0
	eval total.zones count("%navigation.path","|")
	math total.zones add 1
	#echo *** This trip crosses %total.zones zones. ***
Navigating:
	pause .2
	# The above pause is to allow the map to load before sending /g (goto) instruction.
	eval dest.room element("%navigation.path", "%dest.counter")
	gosub MoveToNewMap %dest.room
	math dest.counter add 1
	if %dest.counter < %total.zones then goto Navigating
	#echo * Finished navigating zone, now going to destination room. *
AlreadyInZone:
	if ("$roomname" == "Caught, Behind the Spider") then gosub WaitOnSpider
	if "%2" == "" then {
		echo * Finished Navigation *
		# Note: no destination room within the destination zone selected.
		goto FinishedNavigation
	}
	if "%2" == "$roomid" then {
		#echo * Already in destination room. *
		echo * Finished Navigation *
		#pause .5
		goto FinishedNavigation
	}
	gosub MoveTo %2
FinishedNavigation:
	# This pause is necessary (for when .n is launched from .travel and you're already in the room), do not remove:
	pause .3
	put #parse NAVIGATION FINISHED
	#echo NAVIGATION FINISHED
	#if $charactername == "Rellie" then put stop play
	pause .1
	exit

MoveTo:
	pause .5
	var Destination $0
	#if "$charactername" == "Copernicus" then {
	#	gosub RunScript g %Destination
	#	pause .05
	#	return
	#}
	#if "$charactername" != "Rellie" then {
		put /g %Destination
		waitforre ^YOU HAVE ARRIVED
	#}
	#if "$charactername" == "Rellie" then gosub RunAutomapperScriptSafe
	#pause .05
	return

MoveToNewMap:
	var Destination $0
	var OriginZone $zoneid
	#echo %Destination is $0
	if ("$roomname" == "Caught, Behind the Spider") then gosub WaitOnSpider
	if "$roomid" == "0" then
	{
		echo Current room unknown, attempting map reset...
		put #mapper reset
		pause 2
	}
	#if "$charactername" != "Rellie" then {
		put /g %Destination
		waitforre ^YOU HAVE ARRIVED
	#}
	#if "$charactername" == "Rellie" then gosub RunAutomapperScriptSafe
WaitingForMapToLoad:
# need to only wait a max amount of time....
	if contains("$roomdesc", "The landscape is dull and uninteresting, stretching for miles") then {
		# Special code for the road west of Theren to Seords...
		waitforre ^Just when it seems you will never reach the end of the road, you .+ through a patch of brush to your destination\.\.\.
		return
	}
	if "$zoneid" != "%OriginZone" then return
	echo Pausing for map load...
	pause
	goto WaitingForMapToLoad

RunAutomapperScriptSafe:
	# Modified from base.cmd
	var automapperHasStarted 0
	var automapperStartCounter 0
	action var automapperHasStarted 1 when eval contains("$scriptlist", "automapper.cmd")
	put /g %Destination
WaitingForAutomapperToRun:
	delay .05
	math automapperStartCounter add 1
	if %automapperStartCounter >= 50 then {
		put #echo >Log red Automapper failed to run within 2.5 seconds, relaunching.
		goto RunAutomapperScriptSafe
	}
	if %automapperHasStarted != 1 then goto WaitingForAutomapperToRun
	action remove eval contains("$scriptlist", "automapper.cmd")
	var automapperHasEnded 0
	action var automapperHasEnded 1 when eval !contains("$scriptlist", "automapper.cmd")
WaitingForAutomapperToEnd:
	delay .05
	if %scriptHasEnded == 0 then goto WaitingForAutomapperToEnd
	action remove eval !contains("$scriptlist", "automapper.cmd")
	delay .05
	return

RunScript:
	# Example: gosub RunScript climb.cmd
	eval ScriptToRun tolower("$1")
	put .$0
	gosub WaitScriptStart %ScriptToRun
	gosub WaitOnScript %ScriptToRun
	return

WaitScriptStart:
	# Wait for script to START
	eval ScriptName tolower("$1")
	waiteval contains("|$scriptlist|", "|%ScriptName.cmd|")
	return

WaitOnScript:
	# Wait for script to END
	eval ScriptName tolower("$1")
WaitingOnScript:
	pause .2
	if !contains("|$scriptlist|", "|%ScriptName.cmd|") then return
	goto WaitingOnScript

RunScriptSafe:
	# Also used in n.cmd
	eval ScriptToRun tolower("$1")
	var scriptHasStarted 0
	action var scriptHasStarted 1 when eval contains("|$scriptlist|", "|%ScriptToRun.cmd|")
	put .$0
WaitingForScriptToRun:
	delay .05
	if %scriptHasStarted != 1 then goto WaitingForScriptToRun
	action remove eval contains("|$scriptlist|", "|%ScriptToRun.cmd|")
	var scriptHasEnded 0
	action var scriptHasEnded 1 when eval !contains("|$scriptlist|", "|%ScriptToRun.cmd|")
WaitingForScriptToEnd:
	delay .05
	if %scriptHasEnded == 0 then goto WaitingForScriptToEnd
	action remove eval !contains("|$scriptlist|", "|%ScriptToRun.cmd|")
	return

ResetMap:
	put #var zoneid 0
	put #mapper reset
WaitingOnReset:
	if "$zoneid" != "0" then return
	echo Waiting on map load after reset...
	pause .05
	goto WaitingOnReset

# Todo: remove this from n and add to some kind of 'stealbase.cmd' script:
NavigateArrested:
	gosub Alert red NavigateArrested
	exit
	
	send sit
	waitforre ^\[PLEAD INNOCENT or PLEAD GUILTY]
	put plead guilty
	waitforre ^\[You think you might be able to try to PLEAD for RELEASE to get out of this jam\.\]
	put plead release
	waitforre ^You accept a sack and retrieve the equipment stored inside\.
	put open my sack
	pause
	matchre EmptySack ^There is nothing in there\.
	matchre StuffInSack ^In the
	put look in my sack
	matchwait 20
StuffInSack:
	put stow my sack
	pause
	put stand
	pause
	goto RestartNav
EmptySack:
	put drop my sack
	pause
	put stand
	pause
	goto RestartNav

RestartNav:
	put .n %DestinationZone %2
	exit

NavigateClearHandsReset:
	gosub ClearHands
	goto Navigate

NavigateTrippedReset:
	gosub Stand
	goto Navigate

Stand:
	action var AbortStanding 1 when ^You begin to get up and \*\*SMACK\!\*\* your head against the rock ceiling\.$
	var AbortStanding 0
	# this is also used in base.cmd, be sure to post any updates there as well
	if $standing then return
	put stand
	wait
	pause .2
	if "%AbortStanding" == "1" then return
	goto Stand

ClearHands:
	# this is also used in base.cmd, but this is a more simple version
	if contains("$righthand $lefthand", "targe") then gosub Wear my targe
	if contains("$righthand $lefthand", "shield") then gosub Wear my shield
	if contains("$righthand $lefthand", "crossbow") then gosub Wear my crossbow
	#if contains("$righthand $lefthand", "armband") then gosub Wear my armband
	#todo: add better wear list?, add unload detection - needs to be on both wear and stow...
	if "$righthand" != "Empty" then
	{
		send Stow right
		wait
		pause .1
	}
	if "$lefthand" != "Empty" then
	{
		send Stow left
		wait
		pause .1
	}
	return

Wear:
# this is a more simple version than in base.cmd
	send wear $0
	wait
	pause .1
	return

Move:
	# this is also used in base.cmd, be sure to post any updates there as well
	delay .00001
	var MoveDirection $0
Moving:
	delay .00001
	matchre Return ^Obvious
	matchre MovePause ^You struggle.+but can't get anywhere\.$|^You slap at the water in a sad failure|^You flounder around in the water\.$
	matchre MovePause $RetryStrings
	matchre MoveRetreat ^You are engaged to|^You can't do that while engaged\!
	matchre MovePremieError ^The air shimmers in front of you as you try to enter the amusement pier\.  It feels as if an invisible force is holding you back\.
	matchre MoveStuckInStocks ^Given your helpless condition, you don't think that will get you very far\.$
	matchre MoveStand ^You can't do that while (kneeling\!|sitting\!|lying down\.)$
	matchre MoveError ^You can't go there\.$|^I could not find what you were referring to\.$|^What were you referring to\?$
	matchre MoveNoGondola ^There is no wooden gondola here\.  You'll have to wait for it to come back around\.$
	matchre MoveNoFerry ^The ferry has just pulled away from the dock\.  You will have to wait for the next one\.$|^There is no ferry here to go aboard\.$|^The ferry .+ isn't docked, so you're stuck here until the next one arrives\.$|^The barge .+ isn't docked, so you're stuck here until the next one arrives\.$
	matchre MoveVaultError ^The attendant says, "Hey bub, are you lost\?
	put %MoveDirection
	matchwait %MatchwaitTime
	gosub Alert Error moving. $zoneid $roomid $roomname attempted movement %MoveDirection
	return
MoveNoGondola:
	echo No gondola here currently.
	return
MoveNoFerry:
	echo No ferry here currently.
	return
MoveRetreat:
	put retreat;retreat
	pause .15
	goto Moving
MoveStand:
	put stand
	wait
	goto Moving
MoveError:
MovePremieError:
MoveStuckInStocks:
	gosub Alert yellow Attempted to move in an invalid direction. Zone "$zoneid" Room "$roomid" Attempted "%MoveDirection" Paths "$roomexits"
	return
MoveVaultError:
	gosub Alert yellow Attempted to enter vault in $zonename but stuff is stored elsewhere.
	return
MovePause:
	pause .15
	goto Moving

ReleaseUSOL:
	pause .15
	matchre USOLisReleased ^The greenish hues about you vanish as the Universal Solvent matrix loses its cohesion\.$
	matchre USOLisReleased ^Release what\?$
	matchre ReleaseUSOL $RetryStrings
	put release USOL
	matchwait
USOLisReleased:
	put #var $SpellTimer.UniversalSolvent.active 0
	put #var $SpellTimer.UniversalSolvent.duration 0
	return

NavigateDestinationNotFound:
	put #mapper reset
	pause
	goto Navigate

WaitOnSpider:
	if ("$roomname" != "Caught, Behind the Spider") then return
	pause .3
	goto WaitOnSpider