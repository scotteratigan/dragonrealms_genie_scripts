#REQUIRE Send.cmd
#REQUIRE Stand.cmd

gosub Grab %0
exit

Grab:
	var Grab.command $0
	var Grab.success 0
	var Grab.hollowEveSuccessMessages ^You thrust your hands into the dark water searching.*$|^You start to reach into the dark red water.*$|^Closing your eyes, you reach into the murky red water.*$|^You reach your hand below the surface of the water.*$|^As you reach into the enormous vat.*$|^Your hand slips on the edge of the enormous vat.*$|^You reach into the vat and pull forth.*$|^Watching the bobbing pumpkins, you wait for one to surface.*$|^You reach into the enormous vat and feel teeth clamp onto your hand.*$|^As you reach into the blood-hued water,.*$
Grabbing:
	gosub Send RT "grab %Grab.command" "%Grab.hollowEveSuccessMessages" "^You must have your right hand free to do that\.$|^You are too injured to get a pumpkin\.$|^Perhaps that would work better if you were standing\.$" "WARNING MESSAGES"
	var Grab.response %Send.response
	if ("%Send.success" == "1") then {
		var Grab.success 1
		return
	}
	if ("%Grab.response" == "Perhaps that would work better if you were standing.") then {
		gosub Stand
		if (%Stand.success == 1) then goto Grabbing
	}
	return