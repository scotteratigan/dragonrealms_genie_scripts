#REQUIRE Send.cmd
#REQUIRE ClearHand.cmd

gosub Accept %0
exit

Accept:
	var Accept.command $0
	var Accept.success 0
Accepting:
	gosub Send Q "accept %Accept.command" "^You accept \w+'s offer and are now holding .+\.$|^You accept \w+'s tip and slip it away\.$|^\[You can check your progress with the TASK verb\.\]$" "^You have no offers to accept\.$|^But you have no tip offers outstanding\.$|^Both of your hands are full\.$" "WARNING MESSAGES"
	var Accept.response %Send.response
	if ("%Send.success" == "1") then {
		var Accept.success 1
		return
	}
	if ("%Accept.response" == "Both of your hands are full.") then {
		gosub ClearHand left
		if (%ClearHand.success == 1) then goto Accepting
	}
	return