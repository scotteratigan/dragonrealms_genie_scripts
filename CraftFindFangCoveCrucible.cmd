#REQUIRE Error.cmd
#REQUIRE Look.cmd
#REQUIRE Move.cmd
#REQUIRE Navigate.cmd

# Finds an crucible that is not occupied by item or other player.

#debuglevel 10
gosub CraftFindFangCoveCrucible
exit

CraftFindFangCoveCrucible:
	var CraftFindFangCoveCrucible.freeToUse 0
	var CraftFindFangCoveCrucible.crucibleNumber 0
CraftFindingFangCoveAnvil:
	if ("$roomname" == "Forging Society, Forge") then {
		gosub CraftFindFangCoveCrucibleCheckRoom
		if (%CraftFindFangCoveCrucible.success == 1) then {
			echo Found a free crucible.
			return
		}
	}
	math CraftFindFangCoveCrucible.crucibleNumber add 1
	if (%CraftFindFangCoveCrucible.crucibleNumber > 3) then {
		gosub Error Couldn't find free crucible to forge, aborting.
		return
	}
	if ("$roomid" == "0") then {
		put #mapper reset
		pause 1.5
	}
	if ("$roomid" == "0") then {
		# Automapper breaks frequently due to duplicate rooms. This should fix it.
		if ($north == 1) then gosub Move north
		if (contains("$roomobjs", "door")) then gosub Move go door
	}
	# If roomid is still 0, we'll fall back on the generic MoveRandom.cmd routine called in Navigate.cmd:
	echo gosub Navigate 150 crucible%CraftFindFangCoveCrucible.crucibleNumber
	gosub Navigate 150 crucible%CraftFindFangCoveCrucible.crucibleNumber
	goto CraftFindingFangCoveAnvil


CraftFindFangCoveCrucibleCheckRoom:
	if ("$roomplayers" != "") then return
	gosub Look in crucible
	var Anvil.contents %Look.contents
	if ("%Anvil.contents" != "null") then return
	var CraftFindFangCoveCrucible.success 1
	return