#REQUIRE Error.cmd
#REQUIRE Look.cmd
#REQUIRE Move.cmd
#REQUIRE Navigate.cmd

# Finds an anvil that is not occupied by item or other player.

#debuglevel 10
gosub CraftFindFangCoveAnvil
exit

CraftFindFangCoveAnvil:
	var CraftFindFangCoveAnvil.freeToUse 0
	var CraftFindFangCoveAnvil.anvilNumber 0
	var CraftFindFangCoveAnvil.success 0
CraftFindingFangCoveAnvil:
	if ("$roomname" == "Forging Society, Forge") then {
		gosub CraftFindFangCoveAnvilCheckRoom
		if (%CraftFindFangCoveAnvil.success == 1) then {
			echo Found a free anvil.
			return
		}
	}
	math CraftFindFangCoveAnvil.anvilNumber add 1
	if (%CraftFindFangCoveAnvil.anvilNumber > 3) then {
		gosub Error Couldn't find free anvil to forge, aborting.
		return
	}
	if ("$roomid" == "0") then {
		put #mapper reset
		pause 1.5
	}
	if ("$roomid" == "0") then {
		# Automapper breaks frequently due to duplicate rooms. This should fix it.
		if ($north == 1) then gosub Move north
		if (contains("$roomobjs", "door")) then gosub Move door
	}
	# If roomid is still 0, we'll fall back on the generic MoveRandom.cmd routine called in Navigate.cmd:
	echo gosub Navigate 150 anvil%CraftFindFangCoveAnvil.anvilNumber
	gosub Navigate 150 anvil%CraftFindFangCoveAnvil.anvilNumber
	goto CraftFindingFangCoveAnvil


CraftFindFangCoveAnvilCheckRoom:
	if ("$roomplayers" != "") then return
	gosub Look on anvil
	var Anvil.contents %Look.contents
	if ("%Anvil.contents" != "null") then return
	var CraftFindFangCoveAnvil.success 1
	return