#REQUIRE Send.cmd

gosub Echo %0
exit

Echo:
	var Echo.command $0
	var Echo.success 0
Echoing:
	gosub Send Q "echo %Echo.command" "^%Echo.command" "FAIL MESSAGES" "WARNING MESSAGES"
	var Echo.response %Send.response
	if ("%Send.success" == "1") then {
		var Echo.success 1
		return
	}
	return