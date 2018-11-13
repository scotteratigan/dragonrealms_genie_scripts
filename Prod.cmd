#REQUIRE Send.cmd

gosub Prod %0
exit

Prod:
	var Prod.command $0
	var Prod.success 0
Proding:
	gosub Send Q "prod %Prod.command" "^You prod.*$|^You give .+ just a small prodding.*$" "FAIL MESSAGES" "WARNING MESSAGES"
	var Prod.response %Send.response
	if ("%Send.success" == "1") then {
		var Prod.success 1
		return
	}
	return