#REQUIRE Move.cmd
#REQUIRE Retreat.cmd
#REQUIRE Stand.cmd
#REQUIRE Stow.cmd

#debuglevel 10
gosub Climb %0
exit

# Note: will automatically use a heavy rope if we're holding it.
# Todo: grab it if necessary, and stow afterwards.
# Also, implement a max climb attempt var and a counter.

Climb:
	var Climb.obstacle $0
	var Climb.success 0
	var Climb.retryStrings ^Trying to judge the climb, you peer over the edge\.  A wave of dizziness hits you, and you back away from .+\.$|^You approach .+, but the steepness is intimidating\.$|^You attempt to climb down .+, but you can't seem to find purchase\.$|^You make your way up .+\.  Partway up, you make the mistake of looking down\.  Struck by vertigo, you cling to .+ for a few moments, then slowly climb back down\.$|^You pick your way up .+, but reach a point where your footing is questionable\.  Reluctantly, you climb back down\.$|^You start down .+, but you find it hard going\.  Rather than risking a fall, you make your way back up\.$|^You start up the .+, but slip after a few feet and fall to the ground\!  You are unharmed but feel foolish\.$
	action var Climb.retry 1 when %Climb.retryStrings
Climbing:
	var Climb.retry 0
	var Climb.command %Climb.obstacle
	if (contains("$lefthand $righthand", "heavy rope")) then var Climb.command %Climb.obstacle with my heavy rope
	gosub Send RT "climb %Climb.command" "^Obvious (paths|exits):|^Ship paths:|^It's pitch dark|^You begin to practice your climbing skills\.$" "%Climb.retryStrings|^Not while carrying something in your hands\.$|^You should empty your hands first\!$|^The going gets quite difficult and highlights the need to free up your hands to climb down any further\.$|^You can't climb that\.$|^You're too tired to try.*$|^The ground approaches you at an alarming rate\!  SPLAT\!$|^You are engaged to .*\!$"
	action remove %Climb.retryStrings
	var Climb.response %Send.response
	if (%Send.success) then {
		var Move.success 1
		return
	}
	if (matchre("%Climb.response", "^Not while carrying something in your hands\.$|^You should empty your hands first\!$|^The going gets quite difficult and highlights the need to free up your hands to climb down any further\.$")) then {
		if ("$righthand" != "Empty") then gosub Stow right
		if ("$lefthand" != "Empty") then gosub Stow left
		goto Climbing
	}
	if (matchre("%Climb.response", "^You're too tired to try.*$")) then {
		pause 1
		goto Climbing
	}
	if (matchre("%Climb.response", "^The ground approaches you at an alarming rate\!  SPLAT\!$")) then {
		gosub Stand
		goto Climbing
	}
	if (matchre("%Climb.response", "^You are engaged to .*\!$")) then {
		gosub RetreatCompletely
		goto Climbing
	}
	if (%Climb.retry == 1) then {
		goto Climbing
	}
	return