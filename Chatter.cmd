#REQUIRE Send.cmd

gosub Chatter %0
exit

Chatter:
	var Chatter.message $0
	var Chatter.success 0
Chattering:
	gosub Send Q "chatter %Chatter.message" "^You chatter away\.\.\." "FAIL MESSAGES" "WARNING MESSAGES"
	if ("%Send.success" == "1") then {
		var Chatter.success 1
		return
	}
	return