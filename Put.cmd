#REQUIRE Send.cmd

gosub Put %0
exit

Put:
	var Put.target $0
Puting:
	gosub Send Q "put %Put.target" "^You put|^You drop .+ in|^You vigorously rub|^You place|^The .+ slides easily into|^\w+ says, "Nice work, \w+\."$|^You toss .+ into .+\.$" "^You stop, realizing the pyramid is full\.$|^There isn't any more room in the .+ for that\.$|^You can't fit anything else in the .+\.$|^You decide that smelting such a volume of metal at once would be dangerous, and stop\.$" ""
	return