#REQUIRE CraftFindFangCoveCrucible.cmd
#REQUIRE Error.cmd
#REQUIRE NavigateRoomName.cmd
#REQUIRE RunScripts.cmd
#REQUIRE Get.cmd
#REQUIRE CraftMixCrucible.cmd

gosub CraftMakeSteelIngot %0
exit

CraftMakeSteelIngot:
	var CraftMakeSteelIngot.success 0
	gosub NavigateRoomName 150 ingots Forging Society, Supply Shop
	gosub RunScripts 10 2order 9|clearhand both
	gosub RunScripts order 9|clearhand both
	gosub CraftFindFangCoveCrucible
	if (%CraftFindFangCoveCrucible.success == 0) then {
		gosub Error Couldn't find empty crucible. Aborting.
		return
	}
	gosub RunScripts 21 get my steel ingot|put my ingot in crucible
	gosub CraftMixCrucible
	exit
