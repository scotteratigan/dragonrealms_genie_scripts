#REQUIRE Send.cmd

gosub Nod %0
exit

Nod:
	var Nod.command $0
	var Nod.success 0
Noding:
	gosub Send Q "nod %Nod.command" "^You nod.*$" "FAIL MESSAGES" "WARNING MESSAGES"
	var Nod.response %Send.response
	if ("%Send.success" == "1") then {
		var Nod.success 1
		return
	}
	return