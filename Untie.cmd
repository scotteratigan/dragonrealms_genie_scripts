#REQUIRE Send.cmd

gosub Untie %0
exit

Untie:
	var Untie.command $0
	var Untie.success 0
Untieing:
	gosub Send Q "untie %Untie.command" "^You untie .*$|^You carefully untie your gem pouch and move roughly half its contents into your gem pouch, carefully tying up both pouches when you are done\.$" "^You realize neither of your hands are free, and stop\.$|^You have nothing bundled with the logbook\.$|^That's not going to work\.  You need to hold the tied gem pouch in your right hand and an empty one in your left\.$" "WARNING MESSAGES"
	var Untie.response %Send.response
	if ("%Send.success" == "1") then {
		var Untie.success 1
		return
	}
	return