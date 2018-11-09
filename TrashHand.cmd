#REQUIRE Error.cmd
#REQUIRE Trash.cmd

gosub TrashHand %0
exit

TrashHand:
	eval TrashHand.option tolower("$0")
	var TrashHand.success 0
	if (!matchre("%TrashHand.option", "left|right|both")) then {
		gosub Error TrashHand called without valid argument. You entered %TrashHand.option, valid entries are left/right/both.
		return
	}
	if (matchre("%TrashHand.option", "left|both")) then {
		if ("$lefthand" != "Empty") then gosub Trash #$lefthandid
	}
	if (matchre("%TrashHand.option", "right|both")) then {
		if ("$righthand" != "Empty") then gosub Trash #$righthandid
	}
	if ("$lefthand $righthand" == "Empty Empty") then var TrashHand.success 1
	return