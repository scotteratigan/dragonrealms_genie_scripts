#REQUIRE Send.cmd

gosub Appraise %0
exit

Appraise:
	var Appraise.command $0
	var Appraise.success 0
Appraiseing:
	gosub Send RT "appraise %Appraise.command" "^You think you can.*$" "^You are pretty sure you can PUSH the BUTTON to start playing the spinneret game\.$" "WARNING MESSAGES"
	var Appraise.response %Send.response
	if ("%Send.success" == "1") then {
		var Appraise.success 1
		return
	}
	return