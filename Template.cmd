#REQUIRE Send.cmd

gosub Template %0
exit

Template:
	var Template.command $0
	var Template.success 0
Templateing:
	gosub Send RT "template %Template.command" "SUCCESS MESSAGES" "FAIL MESSAGES" "WARNING MESSAGES"
	var Template.response %Send.response
	if ("%Send.success" == "1") then {
		var Template.success 1
		return
	}
	return