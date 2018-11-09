#REQUIRE Error.cmd
#REQUIRE Navigate.cmd
#REQUIRE Waitforre.cmd

# Usage: 
# .FestSearchFor (no arguments) <- will locate the extreme shop
# .FestSearchFor Darkbox <- will locate the darkbox
# .FestSearchFor Mechanic Bradyn
# .FestSearchFor Dealer Poltu  <- forged items
# .FestSearchFor Fisherman Worran
# .FestSearchFor Seamstress Zasele
# .FestSearchFor Attendant Golyaem

gosub FestSearchFor %0
exit

FestSearchFor:
	var searchObject $0
	action goto FestSearchingFor when ^You can't go there\.$
	#put #window add ScriptLog
	#action put #echo >ScriptLog white $1 when ^You also see (.+)\.$
	var FestSearchFor.success 0
FestSearchingFor:
	if ("%searchObject" != "") then {
		put #echo >Log searching for ^You also see.* $1
		action goto FoundIt when ^You also see.* $1
		#var FestSearchFor.searchMatchre ^You also see.* $1
	}
	if ("%searchObject" == "") then {
		put #echo >Log searching for extreme shop
		# Note: added broken-down on 2018/11/02 after we couldn't find it in the fest
		action goto FoundIt when ^You also see a (broken-down|decrepit|dilapidated|dingy|ramshackle|ruined|run-down|tumble-down) (arch|door|entryway|opening|stone arch|stone door|stone entryway|stone opening|wooden arch|wooden door|wooden entryway|wooden opening)
		#var FestSearchFor.searchMatchre ^You also see a (broken-down|decrepit|dilapidated|dingy|ramshackle|ruined|run-down|tumble-down) (arch|door|entryway|opening|stone arch|stone door|stone entryway|stone opening|wooden arch|wooden door|wooden entryway|wooden opening)
	}
	if ("%searchObject" == "Poltu") then goto FestSearchBabyArachnidHead
	gosub Navigate 210 75
	#action if ("$roomobjs" != "") then put #echo >ScriptLog white $roomid: $roomobjs when ^You also see
	put .automapper "southwest" "south" "south" "northeast" "northeast" "south" "south" "southwest" "go iron hatch" "south" "west" "southeast" "go hatch" "southwest" "east" "east" "northwest" "go hatch" "northeast" "west" "climb ladder" "southwest" "northwest" "northeast" "northeast" "go hatch" "northwest" "north" "north" "north" "northeast" "go bronze ramp" "go bronze ramp" "south" "south" "south" "south" "south" "northeast" "north" "north" "north" "south" "south" "south" "southwest" "go hatch" "southeast" "southeast" "southwest" "southwest" "go open valve;stand" "southwest" "go open valve;stand" "southwest" "northeast" "southeast" "northwest" "north" "north" "southwest" "southwest" "southwest" "northeast" "west" "east" "northeast" "northeast" "west" "west" "southwest" "northeast" "northwest" "southeast" "east" "east" "northwest" "northwest" "west" "east" "northwest" "southeast" "southeast" "southeast" "north" "north" "northwest" "southeast" "northeast" "southwest" "south" "south" "northeast" "northeast" "northeast" "southwest" "east" "west" "southwest" "southwest" "east" "east" "northeast" "southwest" "southeast" "northwest" "west" "west" "southeast" "southeast" "east" "west" "southeast"
	gosub Waitforre 90 ^YOU HAVE ARRIVED
	pause .1
	put .automapper northwest northwest northwest south south "go open valve;stand" northeast "go open valve;stand" northeast northwest "climb access ladder" south "go access hatch" "go metallic archway" east east "go metallic archway"
	gosub Waitforre 90 ^YOU HAVE ARRIVED
	pause .1
FestSearchBabyArachnidHead:
	if ($roomid != 82) then gosub Navigate 210 82
	#gosub FestSearchForWaitingOnAutomapper
	if (%FestSearchFor.success == 1) then return
	put .automapper "north" "south" "south" "southeast" "southeast" "northeast" "northeast" "north" "north" "northwest" "west" "west" "south" "south" "south" "east" "east" "north" "north" "north" "west" "south" "south" "south" "south" "south" "north" "north" "north" "north" "north"
	gosub Waitforre 90 ^YOU HAVE ARRIVED
	pause .1
FestSearchBabyArachnidBody:
	if ($roomid != 97) then gosub Navigate 210 97
	put .automapper "north" "northwest" "west" "southwest" "northeast" "east" "northwest" "east" "west" "west" "southwest" "northeast" "east" "northwest" "west" "east" "southeast" "north" "east" "west" "northwest" "west" "east" "southeast" "northeast" "east" "southeast" "west" "east" "northeast" "east" "west" "southwest" "south" "west" "east" "northeast" "east" "west" "southwest" "east" "southeast" "northwest" "west" "southwest" "east" "southeast"
	gosub Waitforre 90 ^YOU HAVE ARRIVED
	pause .1
	gosub Error Could not locate object.
	#goto FestSearchingFor
	exit

#FestSearchForWaitingOnAutomapper:
#	#matchre FestSearchForWaitingOnAutomapper ^Obvious
#	matchre FoundIt %FestSearchFor.searchMatchre
#	matchre FestSearchForReturn ^YOU HAVE ARRIVED
#	matchwait
#FestSearchForReturn:
#	return

FoundIt:
	put #script abort automapper
	var FestSearchFor.success 1
	echo FOUND IT!
	if ("%searchObject" == "Darkbox") then {
		pause .3
		put #tvar darkboxroom $roomid
	}
	#return
	exit

# You know you've found the extreme shop if...
# >l arch
# [Assuming you mean a dingy arch.]
# You see nothing unusual.
# It is open.
# 
# >tap arch
# [Assuming you mean a dingy arch.]
# [Assuming you mean a dingy arch.]
# [Assuming you mean a dingy arch.]
# [Assuming you mean a dingy arch.]
# 
# >HR>sneak arch
# [Assuming you mean a dingy arch.]
# You can't go there.

# Note: tim's regex:
#var extreme_shop.regex \b((broken-down|(?<!shell of a )ruined|decaying|decrepit|dingy|neglected|rickety|ramshackle|run-down|tumble-down) (stone|wooden)? ?(cabana|cabin|house|hovel|lean-to|shack|hut|shed|shelter|wagon))\b
#action put /notify Extreme shop in $zonename ($zoneid $roomid) $roomdesc $roomobjs;put #echo >Log Red Extreme shop in $zonename ($zoneid $roomid) $roomdesc $roomobjs when eval matchre($roomobjs, %extreme_shop.regex)