#REQUIRE ClearHand.cmd
#REQUIRE CraftForgeItem.cmd
#REQUIRE Error.cmd
#REQUIRE Get.cmd
#REQUIRE Navigate.cmd
#REQUIRE Order.cmd
#REQUIRE Swap.cmd
#REQUIRE Trash.cmd
#REQUIRE Wealth.cmd
#REQUIRE Withdraw.cmd

gosub CraftMakeUnfinishedRasps %0
exit

CraftMakeUnfinishedRasps:
	var CraftMakeUnfinishedRasps.quantityRequired $1
	if (!matchre("%CraftMakeUnfinishedRasps.quantityRequired", "^\d+$")) then {
		gosub Error Need to specify how many rasps to make.
		return
	}
	action put exit when ^That's too heavy to go in there\!$
	var CraftMakeUnfinishedRasps.count 0
CraftMakingUnfinishedRasps:
	gosub ClearHand both
	gosub Wealth
	if (%Wealth.dokoras < 10000) then {
		gosub Navigate 150 teller
		gosub Withdraw 5 platinum
	}
	gosub Navigate 150 238
	gosub Get my steel ingot
	if (%Get.success == 1) then gosub Trash my steel ingot
	gosub Order 9
	if ("$righthand" == "Empty") then gosub Swap
	gosub CraftForgeItem blacksmithing a coarse metal rasp
	if (%CraftForgeItem.success != 1) then exit
	if (!contains("$lefthand $righthand", "rasp")) then exit
	math CraftMakeUnfinishedRasps.count add 1
	if (%CraftMakeUnfinishedRasps.count < %CraftMakeUnfinishedRasps.quantityRequired) then goto CraftMakingUnfinishedRasps
	action remove ^That's too heavy to go in there\!$
	return
