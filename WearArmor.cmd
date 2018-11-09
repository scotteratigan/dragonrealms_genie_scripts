#REQUIRE ClearHand.cmd
#REQUIRE Get.cmd
#REQUIRE Inventory.cmd
#REQUIRE Nounify.cmd
#REQUIRE RemoveStow.cmd
#REQUIRE Rummage.cmd
#REQUIRE Store.cmd
#REQUIRE Warning.cmd
#REQUIRE Wear.cmd

gosub WearArmor
exit

WearArmor:
	var WearArmor.success 0
	var WearArmor.itemFailure 0
	if (!contains("$lefthand $righthand", "Empty")) then {
		gosub Warning Tried to WearArmor with no free hands. Clearing hands.
		# Consider re-grabbing items afterwards?
		gosub ClearHand both
		if (!contains("$lefthand $righthand", "Empty")) then {
			gosub Error Tried to ClearHand both to WearArmor, but I still have no free hands. Aborting.
			return
		}
	}
	if ("$armorlist" != "" && !contains("$armorlist", "$")) then {
		var WearArmor.armorList $armorlist
		gosub WearArmorFromList
		return
	}
	gosub Store list
	# Grab armor from the armor container:
	var WearArmor.container %Store.armor
	# ...unless the armor container isn't set, then use default container:
	if ("%WearArmor.container" == "--Not Set-- *") then var WearArmor.container %Store.Default
	gosub Nounify %WearArmor.container
	var WearArmor.nounContainer %Nounify.noun
	gosub Rummage /a my %WearArmor.nounContainer
	var WearArmor.armorList %Rummage.nounList
	if ("%Rummage.nounList" == "null") then return
	gosub WearArmorFromList
	return

WearArmorFromList:
	eval WearArmor.maxIndex count("%WearArmor.armorList", "|")
	var WearArmor.index 0
WearingArmorFromList:
	eval WearArmor.lastItem element("%WearArmor.armorList", %WearArmor.index)
	# Todo: try to get armor from armor container? Or does that just add complexity and potential failure?
	gosub Get my %WearArmor.lastItem
	if ("%Get.success" == "0") then var WearArmor.itemFailure 1
	if ("%Get.success" == "1") then {
		gosub Wear my %WearArmor.lastItem
		if ("%Wear.success" == "0") then var WearArmor.itemFailure 1
	}
	math WearArmor.index add 1
	if (%WearArmor.index <= %WearArmor.maxIndex) then goto WearingArmorFromList
	return 