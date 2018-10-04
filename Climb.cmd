#REQUIRE Move.cmd
#REQUIRE Stow.cmd

gosub Climb %0
exit

Climb:
	var Climb.option $0
Climbing:
	gosub Send RT "climb %Climb.option" "$moveSuccessStrings|^You begin to practice your climbing skills\.$" "^Not while carrying something in your hands\.$|^You should empty your hands first\!$|^You can't climb that\.$|^You're too tired to try"
	if (%Send.success) then return
	if (matchre("%Send.response", "^Not while carrying something in your hands\.$|^You should empty your hands first\!$")) then {
		if ("$righthand" != "Empty") then gosub Stow right
		if ("$lefthand" != "Empty") then gosub Stow left
		goto Climbing
	}
	if (matchre("%Send.response", "^You're too tired to try")) then {
		pause 1
		goto Climbing
	}
	# todo: try to use rope if you fail, etc
	return