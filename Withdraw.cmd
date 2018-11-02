#REQUIRE Error.cmd
#REQUIRE Send.cmd

gosub Withdraw %0
exit

Withdraw:
	var Withdraw.command $0
	var Withdraw.success 0
	var Withdraw.throttled 0
	if ("%Withdraw.command" == "") then {
		gosub Error Called Withdraw without specifying an amount!
		return
	}
	action var Withdraw.throttled 1 when ^The clerk glares at you\.  .I don't know what you think you're doing.*$|^One of the guards lunges and grabs at you\.  He exclaims, .Hey\!  Slow down\!.*$
Withdrawing:
	gosub Send Q "withdraw %Withdraw.command" "^The clerk counts out.*$|^Searching methodically through the shelves, you finally manage to locate the jar labeled \S+, and thrust your hand inside.*$|^You find your jar with little effort, thankfully, and thrust your hand.*$" "^You must be at a bank teller's window to withdraw money\.$|^The clerk flips through her ledger, then says .\w+, you do not seem to have an account.*$|^The clerk glares at you\.  .I don't know what you think you're doing.*$|^One of the guards lunges and grabs at you\.  He exclaims, .Hey\!  Slow down\!.*$" "WARNING MESSAGES"
	action remove ^The clerk glares at you\.  .I don't know what you think you're doing.*$|^One of the guards lunges and grabs at you\.  He exclaims, .Hey\!  Slow down\!.*$
	if ("%Send.success" == "1") then {
		var Withdraw.success 1
		return
	}
	if (%Withdraw.throttled == 1) then {
		# Note: I can't matchre off of text with quotes in it. I also can't replacere text with quotes in it.
		# My solution in this case is to use a trigger to set a variable.
		# An alternate solution would be to match shorter text that doesn't include the quotes.
		pause
		goto Withdrawing
	}
	return

