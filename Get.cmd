#REQUIRE Send.cmd

gosub Get %0
exit

Get:
	var Get.command $0
	var Get.success 0
Geting:
	gosub Send Q "get %Get.command" "^You pick up|^You get|^You fade in for a moment as you (get|pick up)|^You carefully remove .+ from the bundle\.$|^The .+ slides easily out of the .+\.|^You pull .+ out of .+\.$|^You tear off .+ ticket.*$" "^You pull at it, but the ties prevent you\.  Maybe if you untie it, first\?$|^You must unload .+ to get the ammunition from it\.$|^Picking up .+ would push you over the item limit of \d+ items\.  Please reduce your inventory count before you try again\.|^But your hands are full\!$|^You need a free hand to pick that up\.$|^The .+ may be dangerous to touch\.$|^You pull your hand backward, realizing you shouldn't touch that,|^You can't pick that up with your hands that damaged\.$|^That .+ needs to be tended to be removed\.$|^Your unprotected hand is engulfed by a painful burning sensation\!" "^You are already holding that\.$|^But that is already in your inventory\.$"
	if (%Send.success == 1) then var Get.success 1
	return

	# todo: add untie when 'ties prevent you'
	# todo: unload when 'you must unload'?
	# todo: You need a free hand - call stow left?
