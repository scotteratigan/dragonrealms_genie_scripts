#REQUIRE Accept.cmd
#REQUIRE Ask.cmd
#REQUIRE ClearHand.cmd
#REQUIRE Fill.cmd
#REQUIRE Get.cmd
#REQUIRE Give.cmd
#REQUIRE Look.cmd
#REQUIRE Move.cmd
#REQUIRE Navigate.cmd
#REQUIRE Nounify.cmd
#REQUIRE Order.cmd
#REQUIRE Pour.cmd
#REQUIRE RunScripts.cmd
#REQUIRE Task.cmd
#REQUIRE Trash.cmd
#REQUIRE FestTrashOrKeep.cmd

put #window add Treasure
var FestTurnInRasps.lastPoltuRoom -1
gosub FestTurnInRasps
exit

FestTurnInRasps:
	action var FestTurnInRasps.poltuDirection $1 when ^Dealer Poltu goes (.+)\.$
	if (!contains("$roomobjs", "Poltu")) then {
		gosub FestTurnInRaspsFindPoltu
		goto FestTurnInRasps
	}
	gosub Task
	if (%Task.inProgress == 0) then {
		gosub Ask Poltu for task
		if (%Ask.success != 1) then {
			pause 10
			goto FestTurnInRasps
		}
		gosub Accept task
	}
FestTurningInRasps:
	if (!contains("$roomobjs", "Poltu")) then {
		gosub FestTurnInRaspsFindPoltu
		goto FestTurningInRasps
	}
	gosub Get my rasp
	if (%Get.success == 0) then return
	if ("$lefthand" != "oil") then {
		gosub Get my oil
		if (%Get.success != 1) then {
			gosub ClearHand both
			gosub Navigate 150 ForgingTools
			gosub Order 6
			if (%Order.success != 1) then return
			gosub ClearHand both
			goto FestTurnInRasps
		}
	}
	gosub Pour my oil on my rasp
	if (%Pour.success != 1) then return
	gosub Give Poltu
	if (%Give.success != 1) then {
		if (!contains("$roomobjs", "Poltu")) then goto FestTurningInRasps
		return
	}
	if !contains("$lefthand $righthand", "woven sack") then goto FestTurningInRasps
# Ok, now parse the treasure:
	gosub ClearHand left
	gosub Look in my woven sack
	put #echo >Treasure white %Look.contents
FestTurnInRaspsGetCoins:
	gosub Get coin
	if (%Get.success == 1) then goto FestTurnInRaspsGetCoins
	gosub Fill my gem pouch with my woven sack
	gosub Look in my woven sack
FestTurnInRaspsGetItem:
	eval FestTurnInRasps.itemToGet element("%Look.contentsList", 0)
	gosub Nounify %FestTurnInRasps.itemToGet
	var FestTurnInRasps.itemToGet %Nounify.noun
	gosub Get %FestTurnInRasps.itemToGet from my woven sack
	gosub FestTrashOrKeep left
	if (%FestTrashOrKeep.success == 0) then gosub ClearHand left
	gosub Look in my woven sack
	if ("%Look.contents" != "null") then goto FestTurnInRaspsGetItem
	gosub Navigate 210 Spinneret
	gosub Trash my woven sack
	goto FestTurnInRasps

FestTurninRaspsFindPoltu:
	if ("%FestTurnInRasps.poltuDirection" != "" && "" !contains("%FestTurnInRasps.poltuDirection", "%")) then gosub Move %FestTurnInRasps.poltuDirection
	if (contains("$roomobjs", "Poltu")) then goto FestTurninRaspsFoundPoltu
	if (%FestTurnInRasps.lastPoltuRoom > 0) then gosub Navigate 210 %FestTurnInRasps.lastPoltuRoom
	if (contains("$roomobjs", "Poltu")) then goto FestTurninRaspsFoundPoltu
	if (!contains("$roomobjs", "Poltu")) then {
		gosub RunScripts FestSearchFor Poltu
	}
FestTurninRaspsFoundPoltu:
	var FestTurnInRasps.poltuDirection 
	var FestTurnInRasps.lastPoltuRoom $roomid
	return