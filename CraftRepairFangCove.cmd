#REQUIRE ClearHand.cmd
#REQUIRE Get.cmd
#REQUIRE Give.cmd
#REQUIRE Navigate.cmd
#REQUIRE Withdraw.cmd

gosub CraftRepairFangCove
exit

CraftRepairFangCove:
	gosub ClearHand both
	gosub Navigate 150 teller
	gosub Withdraw 10 platinum
	gosub Navigate 150 repair
	gosub CraftRepairFangCoveActualRepair hammer
	gosub CraftRepairFangCoveActualRepair tongs
	gosub CraftRepairFangCoveActualRepair bellows
	gosub CraftRepairFangCoveActualRepair shovel
	gosub CraftRepairFangCoveRedeemAllTickets
	return

CraftRepairFangCoveActualRepair:
	var CraftRepairFangCove.itemToRepair $0
	gosub Get my %CraftRepairFangCove.itemToRepair
	if (%Get.success == 0) then return
	gosub Give clerk
	gosub ClearHand both
	return

CraftRepairFangCoveRedeemAllTickets:
	if ("$righthandnoun" != "ticket") then {
		gosub ClearHand both
		gosub Get my ticket
		# If no more tickets, return:
		if (%Get.success == 0) then return
	}
CraftRepairFangCoveRedeemingAllTickets:
	gosub Give clerk
	if (%Give.success == 0) then pause 15
	goto CraftRepairFangCoveRedeemAllTickets