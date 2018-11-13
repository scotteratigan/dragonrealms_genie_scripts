#REQUIRE Close.cmd
#REQUIRE Nounify.cmd
#REQUIRE Open.cmd
#REQUIRE Send.cmd

gosub Put %0
exit

Put:
	var Put.target $0
	var Put.success 0
Putting:
	gosub Send Q "put %Put.target" "^You put.*$|^You drop .+ in.*$|^You vigorously rub.*$|^You place.*$|^The .+ slides easily into.*$|^\w+ says, .Nice work, \w+\..$|^You toss .+ into .+\.$|^Raffle Attendant .* examines your ticket.*$|^A helper runs up to you and says.*$|^You carefully hang your fish.*$" "^You stop, realizing the \w+ is full\.$|^There isn't any more room in the .+ for that\.$|^You can't fit anything else in the .+\.$|^There's no room in .+.$|^You decide that smelting such a volume of metal at once would be dangerous, and stop\.$|^You'll need to close .+ before you put it away\.$|^The fishing pole is too long to fit in the .*\.$|^But that's closed\.$" ""
	var Put.response %Send.response
	if ("%Send.success" == "1") then {
		var Put.success 1
		return
	}
	if (matchre("%Put.response", "^You'll need to close (.+) before you put it away\.$")) then {
		gosub Nounify $1
		gosub Close my %Nounify.noun
		if (%Close.success == 1) then goto Putting
	}
	if ("%Put.response" == "But that's closed.") then {
		if (matchre("%Put.target", " in (.+)$")) then {
			var Put.containerToOpen $1
			gosub Open %Put.containerToOpen
			if (%Open.success == 1) then goto Putting
		}
	}
	if (matchre("%Put.response", "^The fishing pole is too long to fit in the .+\.$")) then {
		gosub Close my fishing pole
		if (%Close.success == 1) then goto Putting
	}
	return

# Todo: Grab the coil strings from stow?