#REQUIRE Assemble.cmd
#REQUIRE ClearHand.cmd
#REQUIRE CraftFindFangCoveAnvil.cmd
#REQUIRE CraftReadBook.cmd
#REQUIRE Error.cmd
#REQUIRE Get.cmd
#REQUIRE Measure.cmd
#REQUIRE NavigateRoomName.cmd
#REQUIRE Pound.cmd
#REQUIRE Pour.cmd
#REQUIRE Push.cmd
#REQUIRE Put.cmd
#REQUIRE Study.cmd
#REQUIRE Turn.cmd

# Example:
# .CraftForgeItem weaponsmithing a metal broadsword
# .CraftForgeItem blacksmithing a coarse metal rasp

# Requires you to hold ingot in right hand to begin.
# Left hand doesn't matter.
# Script ends holding the forged item.

# Rellie:
# From the weaponsmithing crafting discipline you have been trained in
# Basic Bladed Weapon Design,
# Proficient Bladed Weapon Design,
# Advanced Bladed Weapon Design,
# Simple Martial Weapon Design,
# Weaponcraft Metallurgy,
# Weaponcraft Theory, and
# Weaponcraft Acumen.

#.runscripts 5 2buy hilt|clearhand both
#.runscripts 8 clearhand both|get steel ingot|craftforgeitem weaponsmithing a metal broadsword

#debuglevel 10
gosub CraftForgeItem %0
exit

CraftForgeItem:
	var CraftForgeItem.discipline $1
	eval CraftForgeItem.itemToForge replace("$0", "%CraftForgeItem.discipline ", "")
	var CraftForgeItem.ingotID #$righthandid
	if ("$righthandnoun" != "ingot") then {
		gosub Error You must start script with ingot in right hand!
		return
	}
	if ("$lefthand" != "%CraftForgeItem.discipline book") then {
		if ("$lefthand" != "Empty") then gosub ClearHand left
		gosub Get my %CraftForgeItem.discipline book
		if ("$lefthand" != "%CraftForgeItem.discipline book") then {
			gosub Error Couldn't find %CraftForgeItem.discipline book, aborting.
			return
		}
	}
	echo gosub CraftReadBook %CraftForgeItem.discipline %CraftForgeItem.itemToForge
	gosub CraftReadBook %CraftForgeItem.discipline %CraftForgeItem.itemToForge
	if (%CraftReadBook.success == 0) then {
		gosub Error Can't forge item, failure to read instructions.
		return
	}
	var CraftForgeItem.haftRequired %CraftReadBook.haftRequired
	var CraftForgeItem.hiltRequired %CraftReadBook.hiltRequired
	var CraftForgeItem.longCordRequired %CraftReadBook.longCordRequired
	var CraftForgeItem.longPoleRequired %CraftReadBook.longPoleRequired
	var CraftForgeItem.shortCordRequired %CraftReadBook.shortCordRequired
	var CraftForgeItem.volumeRequired %CraftReadBook.volumeRequired
	# Measuring currently disabled for speed purposes.
	#gosub Measure #$righthandid
	#if (%Measure.success == 0) then {
	#	gosub Error Unable to measure ingot, aborting.
	#	return
	#}
	#var CraftForgeItem.ingotVolume %Measure.volume
	#if (%CraftForgeItem.ingotVolume < %CraftForgeItem.volumeRequired) then {
	#	gosub Error Insufficient volume to forge item!
	#	return
	#}
	gosub CraftFindFangCoveAnvil
	if (%CraftFindFangCoveAnvil.success == 0) then {
		gosub Error Couldn't find a free anvil to forge on. Go clean them? Aborting.
		exit
		# Todo: clean if room has no player and anvil doesn't have rare mats on it.
	}
	var CraftForgeItem.anvilNumber %CraftFindFangCoveAnvil.anvilNumber
	gosub Put my ingot on anvil
	if (%Put.success == 0) then {
		gosub Error Failed to put ingot on anvil, aborting.
		return
	}
	gosub Study my %CraftForgeItem.discipline book
	if (%Study.success == 0) then {
		gosub Error Failed to study %CraftForgeItem.discipline book. Aborting.
		return
	}

	# Ok, we're live!
	gosub ClearHand both
	var CraftForgeItem.nextAction null
	action var CraftForgeItem.nextAction Push my bellows when ^As you finish the fire flickers and is unable to consume its fuel\.$|^As you finish working the fire dims and produces less heat from the stifled coals\.$
	action var CraftForgeItem.nextAction Push tub when ^The metal now appears ready for cooling in the slack tub\.$|^The .+ is complete and ready for a quench hardening in the slack tub\.$
	action var CraftForgeItem.nextAction Push fuel with my shovel when ^As you complete working the fire dies down and needs more fuel\.$|^As you complete working the fire dies down and appears to need some more fuel\.$
	action var CraftForgeItem.nextAction Turn %CraftForgeItem.noun on anvil with my tongs when ^The .+ could use some straightening along the horn of the anvil\.$|^You notice the .+ would benefit from some soft reworking\.$
	action var CraftForgeItem.nextAction CraftForgeItemGrabPoundedItem when ^The .+ now appears ready for grinding and polishing on a grinding wheel\.$
	#action var CraftForgeItem.nextAction Turn crucible when  ^Upon finishing you observe clumps of molten metal accumulating along the crucible's sides\.$
	#action var CraftForgeItem.nextAction Turn %CraftForgeItem.noun when ^The metal now looks ready to be turned into wire using a mandrel or mold set\.$|^The metal must be transfered to plate molds and drawn into wire on a mandrel set using tongs\.$
	#finished wooden hilt
	var CraftForgeItem.nextAssembleItem null
	action var CraftForgeItem.nextAssembleItem $1 when ^You need another (.+) to continue crafting .+\.  You believe you can assemble the two ingredients together once you acquire them\.$
	gosub Pound ingot on anvil with my hammer
	# Todo: determine best way to check adjective on tools (forging hammer/diagonal-peen hammer, etc)
	if (%Pound.success != 1) then {
		gosub Error Failed the first pound, aborting.
		return
	}
	gosub Look on anvil
	gosub Nounify %Look.contents
	var CraftForgeItem.noun %Nounify.noun
CraftForgingItem:
	# Setting nextAction this way ensure we don't overwrite other actions if first pound messaged that we need to get fuel or something similar:
	if ("%CraftForgeItem.nextAction" == "null") then var CraftForgeItem.nextAction Pound %CraftForgeItem.noun on anvil with my hammer
	var CraftForgeItem.currentAction %CraftForgeItem.nextAction
	var CraftForgeItem.nextAction null
	gosub %CraftForgeItem.currentAction
	if ("%CraftForgeItem.currentAction" == "Push tub") then goto CraftForgeItemGrabPoundedItem
	goto CraftForgingItem

CraftForgeItemGrabPoundedItem:
	gosub ClearHand both
	if (%ClearHand.success != 1) then {
		gosub Error Couldn't clear hands, aborting.
		return
	}
	gosub Get %CraftForgeItem.noun from anvil
	if (%Get.success != 1) then {
		gosub Error Couldn't grab item from anvil.
		return
	}
	if ("%CraftForgeItem.nextAssembleItem" != "null") then {
		# todo: add code for buying items also.
		if ("%CraftForgeItem.nextAssembleItem" == "finished wooden haft") then gosub Get my haft
		if ("%CraftForgeItem.nextAssembleItem" == "finished wooden hilt") then gosub Get my hilt
		if ("$lefthand" == "Empty") then {
			gosub Error Can't get item to assemble with, aborting.
			return
		}
		gosub Assemble #$righthandid with #$lefthandid
		if (%Assemble.success != 1) then {
			gosub Error Failed to assemble properly, aborting.
			return
		}
	}
	# Todo: detect if we need to grind this via action, only perform grindstone steps if necessary.
	if ("$charactername" != "Rellie") then return
	gosub NavigateRoomName 150 anvil%CraftForgeItem.anvilNumber Forging Society, Forge
	gosub Turn grindstone
	gosub Push grindstone with my %CraftForgeItem.noun
	gosub Get my oil
	gosub Pour my oil on my %CraftForgeItem.noun
	gosub ClearHand left
	return



#The maul is complete and ready for a quench hardening in the slack tub.

#You need another finished wooden haft to continue crafting an unfinished steel splitting maul.  You believe you can assemble the two ingredients together once you acquire them.

# Ask.chapter: 9
# Ask.trainer: Phahoe
# Ask.itemRequested: a metal splitting maul
# Ask.quantityRequested: 4
# Ask.timeRemaining: of superior quality