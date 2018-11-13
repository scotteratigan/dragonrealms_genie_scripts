#REQUIRE Send.cmd

gosub Pull %0
exit

Pull:
	var Pull.command $0
	var Pull.success 0
Pulling:
	gosub Send Q "pull %Pull.command" "^You pull.*$|^You.*wind in.*$|^That's all of it\!$|^You've pulled in .+\.  Quickly you grab it and work it free from the hook\.$" "^I'm afraid that you can't pull that\.$" "^The line is already pulled in all the way\.$"
	var Pull.response %Send.response
	if (matchre("%Pull.response", "^You.+wind in.*$")) then goto Pulling
	if ("%Send.success" == "1") then {
		var Pull.success 1
		return
	}
	return