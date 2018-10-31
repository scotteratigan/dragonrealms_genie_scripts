#REQUIRE Send.cmd

gosub Lower %0
exit

Lower:
	var Lower.item $0
	var Lower.success 0
Lowering:
	# Note: I debated if "You lower your weapon, relaxing your guard" should be a success or failure message, because lower is both an RP verb and a utility verb. In the end, I decided that successful RP should be just that.
	gosub Send RT "lower %Lower.item" "^You gently lower your .+ to the ground\.$|^You lower your .+, relaxing your guard\.$" "^There is no point in lowering .+, since it isn't very threatening\.$" "WARNING MESSAGES"
	if ("%Send.success" == "1") then var Lower.success 1
	return