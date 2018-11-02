#REQUIRE Close.cmd
#REQUIRE Nounify.cmd
#REQUIRE Send.cmd

gosub Put %0
exit

Put:
	var Put.target $0
	var Put.success 0
Putting:
	gosub Send Q "put %Put.target" "^You put|^You drop .+ in|^You vigorously rub|^You place|^The .+ slides easily into|^\w+ says, .Nice work, \w+\..$|^You toss .+ into .+\.$|^Raffle Attendant .* examines your ticket.*$" "^You stop, realizing the \w+ is full\.$|^There isn't any more room in the .+ for that\.$|^You can't fit anything else in the .+\.$|^You decide that smelting such a volume of metal at once would be dangerous, and stop\.$|^You'll need to close .+ before you put it away\.$" ""
	var Put.response %Send.response
	if ("%Send.success" == "1") then {
		var Put.success 1
		return
	}
	if (matchre("%Send.response", "^You'll need to close (.+) before you put it away\.$")) then {
		gosub Nounify $1
		gosub Close my %Nounify.noun
		if (%Close.success == 1) then goto Putting
	}
	return

# Todo: Grab the coil strings from stow?