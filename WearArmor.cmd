#REQUIRE ClearHand.cmd
#REQUIRE Get.cmd
#REQUIRE Inventory.cmd
#REQUIRE Nounify.cmd
#REQUIRE RemoveStow.cmd
#REQUIRE Rummage.cmd
#REQUIRE Store.cmd
#REQUIRE Warning.cmd
#REQUIRE Wear.cmd

# Usage:
# WearArmor <- will rumamge in your default armor container (or default container if not set) and attempt to wear all armor in container.
# WearArmor greaves|gauntlets|targe|vambraces|jerkin|balaclava <- send a list of armor, and it'll skip the store list/rummage steps and just wear what you specify. (useful if you sometimes pick up extra armor or if you do armor swapping).

gosub WearArmor %0
exit

WearArmor:
	var WearArmor.list $0
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
	if ("%WearArmor.list" != "") then {
		gosub WearArmorFromList
		return
	}
	gosub Store list
	# Grab armor from the armor container:
	var WearArmor.container %Store.armor
	# ...unless the armor container isn't set, then use default container:
	if ("%WearArmor.container" == "--Not Set-- *") then var WearArmor.container %Store.Default
	# Todo: check if shields are in different container.
	gosub Nounify %WearArmor.container
	var WearArmor.nounContainer %Nounify.noun
	gosub Rummage /a my %WearArmor.nounContainer
	var WearArmor.list %Rummage.nounList
	if ("%Rummage.nounList" == "null") then return
	gosub WearArmorFromList
	return

WearArmorFromList:
	eval WearArmor.maxIndex count("%WearArmor.list", "|")
	var WearArmor.index 0
WearingArmorFromList:
	eval WearArmor.lastItem element("%WearArmor.list", %WearArmor.index)
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