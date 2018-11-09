#REQUIRE Get.cmd
#REQUIRE Stir.cmd
#REQUIRE Push.cmd
#REQUIRE ClearHand.cmd
#REQUIRE Swap.cmd

gosub CraftMixCrucible %0
exit

CraftMixCrucible:
	var CraftMixCrucible.success 0
	gosub Get my stirring rod
	var CraftMixCrucible.defaultAction Stir crucible with my stirring rod
	var CraftMixCrucible.nextAction null
	action var CraftMixCrucible.nextAction push fuel with my shovel when ^As you complete working the fire dies down and needs more fuel\.$
	action var CraftMixCrucible.completed 1 when ^At last the metal appears to be thoroughly mixed and you pour it into an ingot mold\.  (The metal quickly cools and you pick up the .+ ingot|The metal quickly cools, but your hands are full so you set it down upon the ground)\.$
CraftMixingCrucible:
	if (%CraftMixCrucible.completed == 1) then goto CraftMixingCrucibleDone

	if ("%CraftMixCrucible.nextAction" == "null") then {
		gosub %CraftMixCrucible.defaultAction
		goto CraftMixingCrucible
	}
	var CraftMixCrucible.thisAction %CraftMixCrucible.nextAction
	var CraftMixCrucible.nextAction null
	gosub CraftMixCrucible.thisAction
	goto CraftMixingCrucible

CraftMixingCrucibleDone:
	action remove ^As you complete working the fire dies down and needs more fuel\.$
	action remove ^At last the metal appears to be thoroughly mixed and you pour it into an ingot mold\.  (The metal quickly cools and you pick up the .+ ingot|The metal quickly cools, but your hands are full so you set it down upon the ground)\.$
	gosub ClearHand right
	if ("$lefthandnoun" == "ingot") then gosub Swap
	gosub ClearHand left
	if ("$righthandnoun" != "ingot") then gosub Get ingot
	return