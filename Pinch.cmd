#REQUIRE Send.cmd

gosub Pinch %0
exit

Pinch:
	var Pinch.command $0
	var Pinch.success 0
Pinching:
	gosub Send Q "pinch %Pinch.command" "^You pinch.*$" "FAIL MESSAGES" "WARNING MESSAGES"
	var Pinch.response %Send.response
	if ("%Send.success" == "1") then {
		var Pinch.success 1
		return
	}
	return