#REQUIRE Remove.cmd
#REQUIRE Stow.cmd

# Todo: modify this to accept an array as well.

gosub RemoveStow %0
exit

RemoveStow:
	var RemoveStow.item $0
	var RemoveStow.success 0
RemoveStowing:
	gosub Remove %RemoveStow.item
	if ("%Remove.success" != "1") then return
	gosub Stow %RemoveStow.item
	if ("%Send.success" == "1") then var RemoveStow.success 1
	return