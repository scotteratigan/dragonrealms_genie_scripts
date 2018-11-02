#REQUIRE Move.cmd
#REQUIRE Retreat.cmd
#REQUIRE Stand.cmd
#REQUIRE Stow.cmd

gosub Climb %0
exit

Climb:
	var Climb.option $0
	var Climb.success 0
Climbing:
	gosub Send RT "climb %Climb.option" "$moveSuccessStrings|^You begin to practice your climbing skills\.$" "^Not while carrying something in your hands\.$|^You should empty your hands first\!$|^The going gets quite difficult and highlights the need to free up your hands to climb down any further\.$|^You can't climb that\.$|^You're too tired to try.*$|^The ground approaches you at an alarming rate\!  SPLAT\!$|^You are engaged to .*\!$"
	if (%Send.success) then {
		var Move.success 1
		return
	}
	if (matchre("%Send.response", "^Not while carrying something in your hands\.$|^You should empty your hands first\!$|^The going gets quite difficult and highlights the need to free up your hands to climb down any further\.$")) then {
		if ("$righthand" != "Empty") then gosub Stow right
		if ("$lefthand" != "Empty") then gosub Stow left
		goto Climbing
	}
	if (matchre("%Send.response", "^You're too tired to try.*$")) then {
		pause 1
		goto Climbing
	}
	if (matchre("%Send.response", "^The ground approaches you at an alarming rate\!  SPLAT\!$")) then {
		gosub Stand
		goto Climbing
	}
	if (matchre("%Send.response", "^You are engaged to .*\!$")) then {
		gosub RetreatCompletely
		goto Climbing
	}
	# todo: try to use rope if you fail, etc
	return

# Todo: can we make this less dry by calling move?