#REQUIRE Send.cmd

gosub Listen %0
exit

Listen:
	var Listen.command $0
	var Listen.success 0
	action var listen.teacher $1;var Listen.classSkill $2 when ^You begin to listen to (\w+) teach the (.+) skill\.$
Listening:
	gosub Send Q "listen %Listen.command" "You begin to listen to \w+ teach the .+ skill." "^\w+ isn't teaching a class\.$" "^You are already listening to someone\.  You may wish to STOP LISTENING\.$"
	action remove ^You begin to listen to (\w+) teach the (.+) skill\.$
	if ("%Send.success" == "1") then {
		var Listen.success 1
		return
	}
	return