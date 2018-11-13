#REQUIRE Get.cmd
#REQUIRE ClearHand.cmd
#REQUIRE Error.cmd
#REQUIRE Swap.cmd

# Usage: EnsureHands right:left(optional)
# EnsureHands fishing pole:Empty
# EnsureHands r: fishing pole : l: Empty :

gosub EnsureHands %0
exit

EnsureHands:
	# Need to parse input in this way because while you can pass $1 and $2 from a gosub, you can't pass %1 and %2 from the command line because quotes are stripped.
	# Also, I don't want to use | as a separator because that would break compatibility with RunScripts.cmd
	var EnsureHands.input $0
	var EnsureHands.success 0
	# Set the defaults:
	var EnsureHands.right Empty
	var EnsureHands.left Empty
	if (matchre("%EnsureHands.input", "^([\w -']+):")) then {
		var EnsureHands.right $1
	}
	if (matchre("%EnsureHands.input", ":([\w -']+)$")) then {
		var EnsureHands.left $1
	}
	if (!contains("%EnsureHands.input", ":")) then var EnsureHands.right %EnsureHands.input
	echo EnsureHands.right: %EnsureHands.right
	echo EnsureHands.left: %EnsureHands.left
	if ("%EnsureHands.right-%EnsureHands.left" == "Empty-Empty") then {
		gosub Error Need to specify at least one hand. (Use ClearHands both if you want hands empty.)
		return
	}
	if ("$righthand" == "%EnsureHands.left") then if ("$lefthand" == "%EnsureHands.right") then gosub Swap

	if ("$righthand" != "%EnsureHands.right") then {
		if ("$righthand" != "Empty") then gosub ClearHand right
		if ("$lefthand" == "%EnsureHands.right") then if ("%EnsureHands.right" != "%EnsureHands.left") then gosub Swap
		# Todo: is this instruction sufficient? What about items that don't share the adjective?
		if ("$righthand" != "%EnsureHands.right") then gosub Get my %EnsureHands.right
	}

	if ("$lefthand" != "%EnsureHands.left") then {
		if ("$lefthand" != "Empty") then gosub ClearHand left
		if ("$righthand" == "%EnsureHands.left") then if ("%EnsureHands.right" != "%EnsureHands.left") then gosub Swap
		if ("$lefthand" != "%EnsureHands.left") then gosub Get my %EnsureHands.left
		if ("$lefthand" == "Empty") then if ("$righthand" == "%EnsureHands.left") then gosub Swap
	}
	if ("$lefthand" == "%EnsureHands.left") then if ("$righthand" == "%EnsureHands.right") then var EnsureHands.success 1
	return