#REQUIRE Buy.cmd
#REQUIRE ClearHand.cmd
#REQUIRE CraftForgeItem.cmd
#REQUIRE Error.cmd
#REQUIRE Get.cmd
#REQUIRE Navigate.cmd
#REQUIRE Order.cmd
#REQUIRE Stow.cmd
#REQUIRE Swap.cmd
#REQUIRE Trash.cmd
#REQUIRE Wealth.cmd
#REQUIRE Withdraw.cmd

gosub CraftMakeBroadswords %0
exit

CraftMakeBroadswords:
	var CraftMakeBroadswords.desired $1
	var CraftMakeBroadswords.success 0
	if (!matchre("%CraftMakeBroadswords.desired", "(^\d+$)")) then {
		gosub Error Need to specify how many broadwords to make!
		return
	}
	var CraftMakeBroadswords.completed 0
	gosub Wealth
	var CraftMakingBroadswords.dokoras %Wealth.dokoras
	# Dokoras required per broadsword:
	# 9).  a massive steel ingot.................... 1443 Dokoras
	# a simple oak hilt for 90 copper Dokoras

	evalmath CraftMakingBroadswords.dokorasRequired (1443 + 90) *%CraftMakeBroadswords.desired
	if (%CraftMakingBroadswords.dokoras < %CraftMakingBroadswords.dokorasRequired) then {
		evalmath CraftMakingBroadswords.additionalDokorasNeeded %CraftMakingBroadswords.dokorasRequired - %CraftMakingBroadswords.dokoras
		gosub Navigate 150 teller
		gosub Withdraw %CraftMakingBroadswords.additionalDokorasNeeded copper
		if (%Withdraw.success == 0) then return
	}
CraftMakingBroadswords:
	gosub ClearHand both
	gosub Get my steel ingot
	gosub Trash my steel ingot
	gosub Navigate 150 267
	gosub Buy hilt in crate
	gosub Stow my hilt
	gosub Navigate 150 238
	gosub Order 9
	if ("$righthand" == "Empty") then gosub Swap
	gosub CraftForgeItem weaponsmithing a metal broadsword
	var CraftMakeBroadswords.success %CraftForgeItem.success 
	math CraftMakeBroadswords.completed add 1
	if (%CraftMakeBroadswords.completed < %CraftMakeBroadswords.desired) then goto CraftMakingBroadswords
	return
