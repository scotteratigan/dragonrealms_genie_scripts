#REQUIRE Send.cmd

gosub Template %0
exit

Template:
	var Template.target $0
	var Template.success 0
Templateing:
	gosub Send RT "template %Template.target" "SUCCESS MESSAGES" "FAIL MESSAGES" "WARNING MESSAGES"
	if ("%Send.success" == "1") then var Template.success 1
	return