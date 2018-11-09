#REQUIRE Send.cmd

gosub Swap %0
exit

Swap:
	var Swap.success 0
Swaping:
	# Note: currently only saves the first swap if you have something in both hands.
	gosub Send Q "swap" "^You move .+ to your (left|right) hand\.$" "^You have nothing to swap\!$" "WARNING MESSAGES"
	var Swap.response %Send.response
	if ("%Send.success" == "1") then {
		var Swap.success 1
		return
	}
	return