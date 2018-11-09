#REQUIRE ClearHand.cmd
#REQUIRE CraftForgeItem.cmd
#REQUIRE Get.cmd
#REQUIRE Navigate.cmd
#REQUIRE Order.cmd
#REQUIRE Swap.cmd
#REQUIRE Trash.cmd

CraftMakingUnfinishedRasps:
	gosub ClearHand both
	gosub Get my steel ingot
	gosub Trash my steel ingot
	gosub Navigate 150 238
	gosub Order 9
	if ("$righthand" == "Empty") then gosub Swap
	gosub CraftForgeItem blacksmithing a coarse metal rasp
	goto CraftMakingUnfinishedRasps
