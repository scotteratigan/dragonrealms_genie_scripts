#REQUIRE Clean.cmd
#REQUIRE ClearHand.cmd
#REQUIRE Drop.cmd
#REQUIRE Error.cmd
#REQUIRE Get.cmd
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
	var CraftFindFangCoveAnvil.cleanAnvil 0
	var CraftFindFangCoveAnvil.leftHandID #$lefthandid
	var CraftFindFangCoveAnvil.rightHandID #$righthandid
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
		# Falsely encountered this too many times due to race condition.
		#gosub Error Couldn't find free anvil to forge, aborting.
		#return
		var CraftFindFangCoveAnvil.anvilNumber 1
		var CraftFindFangCoveAnvil.cleanAnvil 1
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
	var CraftFindFangCoveAnvil.contents %Look.contents
	if ("%CraftFindFangCoveAnvil.contents" != "null") then {
		# On first pass, we return.
		if (%CraftFindFangCoveAnvil.cleanAnvil == 1) then {
			# On our second pass, we will clean an anvil if the room is empty.
			gosub Clean anvil
			if (%Clean.success == 1) then goto CraftFindFangCoveAnvilCheckRoom
			gosub Nounify %CraftFindFangCoveAnvil.contents
			var CraftFindFangCoveAnvil.noun %Nounify.noun
			gosub ClearHand both
			gosub Get %CraftFindFangCoveAnvil.noun from anvil
			# Dropping is safer than trashing. Although cleaning still isn't safe...
			gosub Drop my %CraftFindFangCoveAnvil.noun
			if ("%CraftFindFangCoveAnvil.rightHandID" != "") then gosub Get %CraftFindFangCoveAnvil.rightHandID
			if ("%CraftFindFangCoveAnvil.leftHandID" != "") then gosub Get %CraftFindFangCoveAnvil.leftHandID
			var CraftFindFangCoveAnvil.success 1
		}
		return
	}
	var CraftFindFangCoveAnvil.success 1
	return