#REQUIRE Error.cmd
# implements the equivalent of matchwait x, using matchwait
gosub Waitforre %0
exit

Waitforre:
	var Waitforre.seconds $1
	var Waitforre.matchres $0
	eval Waitforre.matchres replacere("%Waitforre.matchres", "^%Waitforre.seconds ", "")
	echo Waiting For: %Waitforre.matchres
	var Waitforre.response null
	if (!matchre("%Waitforre.seconds", "^\d+$")) then {
		gosub Error with Waitforre.cmd, wait time is not a number. Usage: gosub Waitforre 2 sometext. You entered Waitforre $1 $2.
		return
	}
	if ("%Waitforre.matchres" == "") then {
		gosub Error with Waitforre.cmd, no matching text specified. Usage: gosub Waitforre 2 sometext.
		return
	}
	matchre WaitforreReturn %Waitforre.matchres
	matchwait %Waitforre.seconds
	gosub Error Waitforre %Waitforre.seconds %Waitforre.matchres TIMEOUT.
WaitforreReturn:
	var Waitforre.response $0
	return