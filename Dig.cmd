#REQUIRE Send.cmd

gosub Dig %0
exit

Dig:
	var Dig.command $0
	var Dig.success 0
Diging:
	gosub Send RT "dig %Dig.command" "^You swish your hand around in the open grave.*$" "^Dig what\?$" "WARNING MESSAGES"
	var Dig.response %Send.response
	pause .01
	if ("%Send.success" == "1") then {
		var Dig.success 1
		return
	}
	return