#REQUIRE Send.cmd

gosub Pour %0
exit

Pour:
	var Pour.command $0
	var Pour.success 0
Pouring:
	gosub Send RT "pour %Pour.command" "^After applying some of the oil to the rag, you vigorously buff several rough spots on .+ and spread the protective sheen across the metal's surface\.$|^Tipping the oil to one side, you dampen a cloth with the syrupy black mixture\.  Then you run the cloth over the surface of your .+ until an even coat of oil covers it\.$|^You unwrap the cloth protecting your oil, and pour several drops over the .+\.  With gentle strokes you wipe the oil across the metal's surface until only a glossy sheen remains\.$|^You unwrap the cloth surrounding the oil, and use it to rub grime and grit off your .+\.  Then, you pour a small amount on the metal and work it in\.$" "^Pour what\?$|^You can't pour .+\!$|^You must be holding .+ to do that\.$|^You cannot figure out how to do that\.  Perhaps finding suitable ingredients and studying some instructions would help\.$" "WARNING MESSAGES"
	var Pour.response %Send.response
	if ("%Send.success" == "1") then {
		var Pour.success 1
		return
	}
	return