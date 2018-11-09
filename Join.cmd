#REQUIRE Send.cmd

gosub Join %0
exit

Join:
	var Join.command $0
	var Join.success 0
Joining:
	gosub Send Q "join %Join.command" "^You join \w+'s group\.$|^You spot the next available line for your name and scratch your mark\.$" "FAIL MESSAGES" "^You are already following \w+\!$|^You're already on the list\!  Be patient, and Yrisa will attend to you when she can\.$"
	var Join.response %Send.response
	if ("%Send.success" == "1") then {
		var Join.success 1
		return
	}
	return