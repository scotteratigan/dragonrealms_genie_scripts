#REQUIRE Send.cmd

# Usage: to sort items in your inventory. Currently recognizes:
# Sort item (moves item to top of inventory)
# Sort item in container (moves items? to the top of the container)
# Sort up item (moves an item up in your inventory)
# Sort down item (moves an item down in your inventory)
# Sort up item in container (moves an item up inside a container - not very useful)
# Sort down item in container (moves an item down inside a contaienr - not very useful)
# Sort automatic headtotoe (puts helms before backpacks before boots, etc)
# Sort automatic reverse (reverses the current inventory order exactly)

gosub Sort %0
exit

Sort:
	var Sort.command $0
	var Sort.success 0
Sorting:
	gosub Send Q "sort %Sort.command" "^All items in .+ that match your .(.+). are now at the top of the container\.$|^All items that match your ..*. are now at the top of your inventory\.$|^Your inventory is now arranged in head-to-toe order\.$|^Your inventory has been reversed\.$|^.*has been moved up in your inventory\.$|^.*has been moved down in your inventory\.$|^.* has been moved up in .*\.$|^.* has been moved down in .*\.$" "^You may only sort items that are located somewhere in your inventory or in your Carousel vault\.$" "^.*is already the first item in your inventory, it cannot be moved up\.$|^.*is already the last item in your inventory, it cannot be moved down\.$"
	var Sort.response %Send.response
	if ("%Send.success" == "1") then {
		var Sort.success 1
		return
	}
	return