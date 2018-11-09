#REQUIRE Information.cmd
#REQUIRE Send.cmd

gosub Clean %0
exit

# Todo: look on anvil before cleaning, and abort cleaning if metal is rare.

Clean:
	var Clean.target $0
	var Clean.success 0
	var Clean.itemDiscarded null
	action var Clean.itemDiscarded $1 when ^You stop working and clean off the anvil's surface, discarding (.+) into .+\.$
Cleaning:
	gosub Send RT "clean %Clean.target" "^You drag the waste bucket close and prepare to clean off the anvil\.$|^You stop working and clean off the anvil's surface, discarding .+ into the .+\.$" "^Clean what\?$" "^There is nothing to clean off the anvil\!$"
	action remove ^You stop working and clean off the anvil's surface, discarding (.+) into .+\.$
	var Clean.response %Send.response
	if ("%Clean.response" == "You drag the waste bucket close and prepare to clean off the anvil.") then goto Cleaning
	if ("%Clean.itemDiscarded" != "null") then gosub Information Trashed item on anvil: %Clean.itemDiscarded
	if ("%Send.success" == "1") then {
		var Clean.success 1
		return
	}
	return