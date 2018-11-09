#REQUIRE Ask.cmd
#REQUIRE CraftFindFangCoveTrainer.cmd
#REQUIRE Error.cmd
#REQUIRE Get.cmd
#REQUIRE Send.cmd
#REQUIRE Untie.cmd

# Only works in FC for now.
# Usage: CraftGetWorkOrder easy/challenging/hard blacksmithing/remedies/outfitting/armorsmithing/weaponsmithing/etc
# Example: CraftGetWorkOrder challenging weaponsmithing

gosub CraftGetWorkOrder %0
exit

CraftGetWorkOrder:
	var CraftGetWorkOrder.difficulty $1
	var CraftGetWorkOrder.discipline $2
	var CraftGetWorkOrder.success 0
	var CraftGetWorkOrder.masterName null
	var CraftGetWorkOrder.logbookType null
	if (contains("armorsmithing|blacksmithing|weaponsmithing", "%CraftGetWorkOrder.discipline")) then {
		var CraftGetWorkOrder.masterName Phahoe
		var CraftGetWorkOrder.logbookType forging
	}
	if (contains("remedies", "%CraftGetWorkOrder.discipline")) then {
		var CraftGetWorkOrder.masterName Swetyne
		var CraftGetWorkOrder.logbookType alchemy
	}
	if (contains("tailoring", "%CraftGetWorkOrder.discipline")) then {
		var CraftGetWorkOrder.masterName Varcenti
		var CraftGetWorkOrder.logbookType outfitting
	}
	if (contains("carving|shaping|tinkering", "%CraftGetWorkOrder.discipline")) then {
		var CraftGetWorkOrder.masterName Brogir
		var CraftGetWorkOrder.logbookType engineering
	}
	if ("%CraftGetWorkOrder.masterName" == "null") then {
		gosub Error Invalid crafting discipline specified, don't know what trainer to find.
		return
	}
	if ("$lefthand" != "Empty") then gosub ClearHand left
	if ("$righthand" != "%CraftGetWorkOrder.logbookType logbook") then {
		gosub ClearHand right
		gosub Get my %CraftGetWorkOrder.logbookType logbook
	}
	if ("$righthand" != "%CraftGetWorkOrder.logbookType logbook") then {
		gosub Error Couldn't find logbook to get a new work order.
		return
	}
# Check that we don't already have an expired work order?
CraftGetWorkOrderUntieBundledItemsFirst:
	gosub Untie my logbook
	if (%Untie.success == 1) then {
		gosub ClearHand left
		goto CraftGetWorkOrderUntieBundledItemsFirst
	}
CraftGettingWorkOrder:
	gosub CraftFindFangCoveTrainer %CraftGetWorkOrder.masterName
	gosub Ask %CraftGetWorkOrder.masterName for %CraftGetWorkOrder.difficulty %CraftGetWorkOrder.discipline work
	if (%Ask.success == 1) then {
		var CraftGetWorkOrder.success 1
		return
	}
	goto CraftGettingWorkOrder