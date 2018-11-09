#REQUIRE Send.cmd
#REQUIRE Untie.cmd
#REQUIRE Stand.cmd

gosub Get %0
exit

Get:
	var Get.item $0
	var Get.success 0
Getting:
	gosub Send Q "get %Get.item" "^You grab for .+ teardrinker.*$|^You pick up|^You get|^You fade in for a moment as you (get|pick up)|^You carefully remove .+ from the bundle\.$|^The .+ slides easily out of the .+\.|^You pull .+ out of .+\.$|^You tear off .+ ticket.*$|^You help yourself to an orange pumpkin\.  Yum\!$|^The pumpkin farmer beams happily at you.*$|^You bob your head into the snake pit.*$|^You slip your head into the pile.*$" "^You might try standing first\.$|^You pull at it, but the ties prevent you\.  Maybe if you untie it, first\?$|^You should untie .+ from .+\.$|^You must unload .+ to get the ammunition from it\.$|^Picking up .+ would push you over the item limit of \d+ items\.  Please reduce your inventory count before you try again\.|^But your hands are full\!$|^You need a free hand to pick that up\.$|^The .+ may be dangerous to touch\.$|^You pull your hand backward, realizing you shouldn't touch that,|^You can't pick that up with your hands that damaged\.$|^That .+ needs to be tended to be removed\.$|^Your unprotected hand is engulfed by a painful burning sensation\!|^A wall of force around the vat prevents you from getting it\.$|^The attendant says, .You really should take it easy\..*$|^You plunge your head into the pile while trying to deftly avoid the dancing snakes\.  Unfortunately,.*$|^Greedy\!  You've already gotten a ticket for this drawing\!|$^The attendant says, .You really should take it easy\.  You look a bit like death warmed over, and we don't want to bring the wrath of the Immortals down on our establishment\.." "^You are already holding that\.$|^But that is already in your inventory\.$"
	var Get.response %Send.response
	if (%Send.success == 1) then var Get.success 1
	if (matchre("%Get.response", "^You pull at it, but the ties prevent you\.  Maybe if you untie it, first\?$|^You should untie .+ from .+\.$")) then {
		gosub Untie %Get.item
		var Get.success %Untie.success
	}
	if ("%Get.response" == "You might try standing first.") then {
		gosub Stand
		goto Getting
	}
	return

	# todo: add untie when 'ties prevent you'
	# todo: unload when 'you must unload'?
	# todo: You need a free hand - call stow left?
