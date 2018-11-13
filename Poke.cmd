#REQUIRE Send.cmd

gosub Poke %0
exit

Poke:
	var Poke.command $0
	var Poke.success 0
Pokeing:
	gosub Send Q "poke %Poke.command" "^You poke.*$|^You turn the .*$|^You move the .+\.  Hopefully that's a good thing." "FAIL MESSAGES" "WARNING MESSAGES"
	var Poke.response %Send.response
	if ("%Send.success" == "1") then {
		var Poke.success 1
		return
	}
	return