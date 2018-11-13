#REQUIRE Send.cmd

gosub Tie %0
exit

Tie:
	var Tie.command $0
	var Tie.success 0
Tieing:
	gosub Send Q "tie %Tie.command" "^You attach.*$|^You tie up the gem pouch\.$" "^Tie what\?$|^The .+ doesn't seem to fit\.$|^You must be holding the.*$" "^The gem pouch has already been tied off\.$"
	var Tie.response %Send.response
	if ("%Send.success" == "1") then {
		var Tie.success 1
		return
	}
	return