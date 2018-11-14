#REQUIRE Inventory.cmd
#REQUIRE Nounify.cmd
#REQUIRE RemoveStow.cmd
#REQUIRE Warning.cmd

gosub RemoveArmor
exit

RemoveArmor:
	var RemoveArmor.success 0
	var RemoveArmor.itemFailure 0
	gosub Inventory armor
	var RemoveArmor.maxIndex %Inventory.maxIndex
	var RemoveArmor.list %Inventory.list
	var RemoveArmor.index 0
	if ("%RemoveArmor.list" == "") then {
		gosub Warning RemoveArmor called with no armor worn.
		return
	}
RemovingArmor:
	eval RemoveArmor.lastItem element("%RemoveArmor.list", %RemoveArmor.index)
	gosub Nounify %RemoveArmor.lastItem
	var RemoveArmor.lastItem %Nounify.noun
	gosub Remove %RemoveArmor.lastItem
	if (%Remove.success != 1) then var RemoveArmor.itemFailure 1
	if (%Remove.success == 1) then {
		gosub Stow %RemoveArmor.lastItem
		if (%Stow.success != 1) then var RemoveArmor.itemFailure 1
	}
	math RemoveArmor.index add 1
	if (%RemoveArmor.index <= %RemoveArmor.maxIndex) then goto RemovingArmor
	# While it is redundant to have 2 variables to track this, the convention is for a success variable, but I don't want to assume success in case of an unexpected return of some kind.
	if (%RemoveArmor.itemFailure == 0) then var RemoveArmor.success 1 
	return