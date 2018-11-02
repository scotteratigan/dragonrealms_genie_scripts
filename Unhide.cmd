#REQUIRE Send.cmd

gosub Unhide %0
exit

# Todo: auto-stand when you creep out of hiding with injuries and fall over?

Unhide:
	var Unhide.success 0
Unhideing:
	gosub Send RT "unhide" "^You come out of hiding\.$|^But you are not hidden\!$" "FAIL MESSAGES" "WARNING MESSAGES"
	if ("%Send.success" == "1") then var Unhide.success 1
	return