#REQUIRE Send.cmd

gosub Rub %0
exit

Rub:
	var Rub.command $0
	var Rub.success 0
Rubing:
	gosub Send Q "rub %Rub.command" "^You rub.*$|^As you rub your viper ring.*$" "^Rub what\?$" "WARNING MESSAGES"
	var Rub.response %Send.response
	if ("%Send.success" == "1") then {
		var Rub.success 1
		return
	}
	return