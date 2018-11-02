#REQUIRE Open.cmd
#REQUIRE Nounify.cmd
#REQUIRE Send.cmd

gosub Fill %0
exit

Fill:
	var Fill.command $0
	var Fill.success 0
	action var Fill.gemsMoved $1;var Fill.gemOrigin $2 when ^You open your gem pouch and quickly fill it with (\d+) gems? from your (.+), closing it quickly\.$
	action var Fill.gemsMoved 0;var Fill.gemOrigin $1 when ^There aren't any gems in the (.+)\.$
Filling:
	gosub Send Q "fill %Fill.command" "You open your gem pouch and quickly fill it.*$|^There aren't any gems in the .+\.$" "^You'll need to open the .+ before finding the gems inside\.$" "WARNING MESSAGES"
	action remove ^You open your gem pouch and quickly fill it with (\d+) gems? from your (.+), closing it quickly\.$
	action remove ^There aren't any gems in the (.+)\.$
	if ("%Send.success" == "1") then {
		var Fill.success 1
		return
	}
	if (matchre("%Send.response", "^You'll need to open the (.+) before finding the gems inside\.$")) then {
		gosub Nounify $1
		var Fill.containerToOpen %Nounify.noun
		gosub Open my %Fill.containerToOpen
		if ("%Open.success" == "1") then goto Filling
	}
	return