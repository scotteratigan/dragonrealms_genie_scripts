#REQUIRE Send.cmd

gosub Untie %0
exit

Untie:
	var Untie.command $0
	var Untie.success 0
Untieing:
	gosub Send Q "untie %Untie.command" "^You untie .*$" "^You realize neither of your hands are free, and stop\.$|^You have nothing bundled with the logbook\.$" "WARNING MESSAGES"
	var Untie.response %Send.response
	if ("%Send.success" == "1") then {
		var Untie.success 1
		return
	}
	return