#REQUIRE Send.cmd

gosub Study %0
exit

Study:
	var Study.command $0
	var Study.success 0
Studying:
	gosub Send RT "study %Study.command" "^You scan .+ and completely understand all facets of the design\.$" "^Study what\?$|^But you're not holding it\.$" "WARNING MESSAGES"
	var Study.response %Send.response
	if ("%Send.success" == "1") then {
		var Study.success 1
		return
	}
	return