#REQUIRE Send.cmd

gosub Unlock %0
exit

Unlock:
	var Unlock.command $0
	var Unlock.success 0
Unlocking:
	gosub Send Q "unlock %Unlock.command" "^You unlock .+$" "^You don't have a key\.$|^You need a key for that\.$" "^You rattle the handle to the .+\.  It's already unlocked\.$|^You rattle the handle on .+\.$"
	var Unlock.response %Send.response
	if ("%Send.success" == "1") then {
		var Unlock.success 1
		return
	}
	return